<#
.SYNOPSIS
    Validate that the three Kiroku layers are consistent.
.PARAMETER Project
    Path to the target project containing TRAIL/
#>
param(
    [string]$Project = (Get-Location).Path
)

$trailDir = Join-Path $Project "TRAIL"
$failures = 0
$warnings = 0

function Fail($msg) { Write-Host "  FAIL: $msg" -ForegroundColor Red; $script:failures++ }
function Warn($msg) { Write-Host "  WARN: $msg" -ForegroundColor Yellow; $script:warnings++ }
function Pass($msg) { Write-Host "  PASS: $msg" -ForegroundColor Green }

Write-Host "Kiroku Trail Validation: $Project"
Write-Host "=" * 50

# Check 1: Structure exists
Write-Host "`nCheck 1: Trail structure"
$summaryPath = Join-Path $trailDir "SUMMARY.md"
$indexPath = Join-Path $trailDir "INDEX.md"
$sessionsDir = Join-Path $trailDir "sessions"

if (Test-Path $summaryPath) { Pass "SUMMARY.md exists" } else { Fail "SUMMARY.md missing" }
if (Test-Path $indexPath) { Pass "INDEX.md exists" } else { Fail "INDEX.md missing" }
if (Test-Path $sessionsDir) { Pass "sessions/ directory exists" } else { Fail "sessions/ directory missing" }

# GENBA.md is optional — owned by Kata, not kiroku
$genbaPath = Join-Path $trailDir "GENBA.md"
if (Test-Path $genbaPath) { Pass "GENBA.md exists (methodology-specific, managed by Kata)" }

$readmePath = Join-Path $trailDir "README.md"
if (Test-Path $readmePath) { Pass "README.md exists (observer entry point)" } else { Warn "README.md missing (no observer entry point)" }

# Check 2: Session files have fidelity headers
Write-Host "`nCheck 2: Session fidelity headers"
$sessionFiles = Get-ChildItem -Path $sessionsDir -Filter "*.md" -ErrorAction SilentlyContinue
if ($sessionFiles.Count -eq 0) {
    Warn "No session files found"
} else {
    foreach ($file in $sessionFiles) {
        $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        if ($content -match 'fidelity:\s*(verbatim|reconstructed|mixed)') {
            Pass "$($file.Name) has fidelity header: $($Matches[1])"
        } else {
            Fail "$($file.Name) missing fidelity header"
        }
        
        if ($content -notmatch 'participants:') {
            Warn "$($file.Name) missing participants field"
        }
    }
}

# Check 3: Decision count consistency
Write-Host "`nCheck 3: Decision count consistency"
$sessionDecisions = 0
foreach ($file in $sessionFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $lines = $content -split "`n"
    foreach ($line in $lines) {
        if ($line -match '^\s*\[!DECISION\]' -and $line -notmatch '<!--') {
            $sessionDecisions++
        }
    }
}

$indexDecisions = 0
if (Test-Path $indexPath) {
    $indexContent = [System.IO.File]::ReadAllText($indexPath, [System.Text.Encoding]::UTF8)
    $indexDecisions = ([regex]::Matches($indexContent, '### DEC-\d{3}')).Count
}

Write-Host "  Session [!DECISION] markers: $sessionDecisions"
Write-Host "  INDEX DEC-NNN entries: $indexDecisions"
if ($sessionDecisions -eq $indexDecisions) {
    Pass "Decision counts match"
} elseif ($indexDecisions -gt $sessionDecisions) {
    Warn "INDEX has more decisions than session markers (manual entries?)"
} else {
    Fail "Session has $sessionDecisions decisions but INDEX only has $indexDecisions - run kiroku-index.ps1"
}

# Check 4: Summary freshness
Write-Host "`nCheck 4: Summary freshness"
if (Test-Path $summaryPath) {
    $summaryContent = [System.IO.File]::ReadAllText($summaryPath, [System.Text.Encoding]::UTF8)
    
    # Check for self-authorship warning
    if ($summaryContent -match 'self-authored') {
        Pass "Self-authorship warning present"
    } else {
        Fail "Missing self-authorship warning in SUMMARY.md"
    }
    
    # Check for one-line status
    if ($summaryContent -match 'One-line status|status:') {
        Pass "One-line status present"
    } else {
        Fail "Missing one-line status in SUMMARY.md"
    }
}

# Check 5: No unclosed sessions
Write-Host "`nCheck 5: Open sessions"
$openSessions = @()
foreach ($file in $sessionFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ($content -match 'status:\s*in-progress') {
        $openSessions += $file.Name
    }
}
if ($openSessions.Count -eq 0) {
    Pass "No unclosed sessions"
} elseif ($openSessions.Count -eq 1) {
    Pass "One open session (current): $($openSessions[0])"
} else {
    Warn "Multiple open sessions: $($openSessions -join ', ')"
}

# Check 6: Fidelity honesty - no session claiming 100% verbatim without tool output
Write-Host "`nCheck 6: Fidelity honesty"
foreach ($file in $sessionFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ($content -match 'fidelity:\s*verbatim' -and $content -notmatch '\[VERBATIM\]') {
        Warn "$($file.Name) claims verbatim fidelity but has no [VERBATIM] markers"
    }
}

# Check 7: Decision recording quality
Write-Host "`nCheck 7: Decision recording quality"
if (Test-Path $indexPath) {
    $indexContent = [System.IO.File]::ReadAllText($indexPath, [System.Text.Encoding]::UTF8)
    # Count only actual rationale/alternatives fields marked as not recorded.
    # A narrative mention of the phrase inside a decision should not create a false warning.
    $missingFieldPattern = '(?m)^(?:- \*\*)?(?:Rationale|Alternatives(?: considered)?)(?::\*\*|:)\s+\*not recorded(?: at decision point)?\*'
    $sparseDecisions = ([regex]::Matches($indexContent, $missingFieldPattern)).Count
    if ($sparseDecisions -gt 0) {
        Warn "$sparseDecisions decision(s) have missing rationale or alternatives - enrich at decision time"
    } else {
        Pass "All decisions have rationale recorded"
    }
}

# Summary
Write-Host "`n" + "=" * 50
Write-Host "Results: $failures failures, $warnings warnings"
if ($failures -eq 0) {
    Write-Host "Trail is valid." -ForegroundColor Green
} else {
    Write-Host "Trail has issues - fix before proceeding." -ForegroundColor Red
}

exit $failures
