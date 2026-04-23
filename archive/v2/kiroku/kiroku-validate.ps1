<#
.SYNOPSIS
    Validate that the three Kiroku layers are consistent.
.PARAMETER Project
    Path to the target project containing TRAIL/
#>
param(
    [string]$Project = (Get-Location).Path,
    [int]$StaleOpenSessionHours = 12,
    [int]$PerformanceWarnMs = 250
)

if (-not (Test-Path $Project)) {
    Write-Error "Project path not found: $Project"
    exit 1
}

$Project = (Resolve-Path $Project).Path
$timer = [System.Diagnostics.Stopwatch]::StartNew()

$trailDir = Join-Path $Project "TRAIL"
$failures = 0
$warnings = 0

function Fail($msg) { Write-Host "  FAIL: $msg" -ForegroundColor Red; $script:failures++ }
function Warn($msg) { Write-Host "  WARN: $msg" -ForegroundColor Yellow; $script:warnings++ }
function Pass($msg) { Write-Host "  PASS: $msg" -ForegroundColor Green }
function Info($msg) { Write-Host "  INFO: $msg" -ForegroundColor Cyan }

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
$genbaArchivePath = Join-Path $trailDir "GENBA_ARCHIVE.md"
if (Test-Path $genbaArchivePath) { Pass "GENBA_ARCHIVE.md exists (methodology-specific, managed by Kata)" }

$readmePath = Join-Path $trailDir "README.md"
if (Test-Path $readmePath) { Pass "README.md exists (observer entry point)" } else { Warn "README.md missing (no observer entry point)" }

$normalizedProject = $Project.TrimEnd('\\').ToLowerInvariant()

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

        if ($content -notmatch '(?m)^source:\s*\S+') {
            Warn "$($file.Name) missing source field"
        }

        if ($content -match '(?m)^project:\s*(.+)$') {
            $sessionProjectRaw = $Matches[1].Trim()
            if (-not (Test-Path $sessionProjectRaw)) {
                Fail "$($file.Name) has non-existent project path: $sessionProjectRaw"
            } else {
                $resolvedSessionProject = (Resolve-Path $sessionProjectRaw).Path.TrimEnd('\\').ToLowerInvariant()
                if ($resolvedSessionProject -ne $normalizedProject) {
                    Fail "$($file.Name) points to a different target repo: $sessionProjectRaw"
                }
            }
        } else {
            Fail "$($file.Name) missing project header"
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

    if ($sessionFiles.Count -gt 0) {
        $latestSessionWriteUtc = ($sessionFiles | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum
        $summaryWriteUtc = (Get-Item $summaryPath).LastWriteTimeUtc
        if ($summaryWriteUtc -lt $latestSessionWriteUtc) {
            Fail "SUMMARY.md is older than the latest session update (digested layer stale)"
        } else {
            Pass "SUMMARY.md is fresh against latest session update"
        }
    }
}

if ((Test-Path $indexPath) -and ($sessionFiles.Count -gt 0)) {
    $decisionSessionFiles = @()
    foreach ($file in $sessionFiles) {
        $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        if ($content -match '^\s*\[!DECISION\]' -or $content -match '(?m)^\s*\[!DECISION\]') {
            $decisionSessionFiles += $file
        }
    }

    if ($decisionSessionFiles.Count -gt 0) {
        $latestDecisionSessionWriteUtc = ($decisionSessionFiles | Measure-Object -Property LastWriteTimeUtc -Maximum).Maximum
        $indexWriteUtc = (Get-Item $indexPath).LastWriteTimeUtc
        if ($indexWriteUtc -lt $latestDecisionSessionWriteUtc) {
            Fail "INDEX.md is older than latest decision-bearing session - run kiroku-index.ps1"
        } else {
            Pass "INDEX.md is fresh against decision-bearing sessions"
        }
    }
}

# Check 5: No unclosed sessions
Write-Host "`nCheck 5: Open sessions"
$openSessions = @()
foreach ($file in $sessionFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ($content -match 'status:\s*in-progress') {
        $openSessions += [PSCustomObject]@{
            Name = $file.Name
            Content = $content
        }
    }
}
if ($openSessions.Count -eq 0) {
    Pass "No unclosed sessions"
} elseif ($openSessions.Count -eq 1) {
    Pass "One open session (current): $($openSessions[0].Name)"
} else {
    Fail "Multiple open sessions: $($openSessions.Name -join ', ')"
}

foreach ($open in $openSessions) {
    $triggerSection = [regex]::Match($open.Content, '(?ms)^##\s+Trigger\s*(.*?)(?=^##\s+|\z)').Groups[1].Value
    $intentSection = [regex]::Match($open.Content, '(?ms)^##\s+Intent\s*(.*?)(?=^##\s+|\z)').Groups[1].Value
    $exchangeSection = [regex]::Match($open.Content, '(?ms)^##\s+Exchange Log\s*(.*?)(?=^##\s+|\z)').Groups[1].Value

    $cleanTrigger = ([regex]::Replace($triggerSection, '(?ms)<!--.*?-->', '')).Trim()
    $cleanIntent = ([regex]::Replace($intentSection, '(?ms)<!--.*?-->', '')).Trim()
    $cleanExchange = ([regex]::Replace($exchangeSection, '(?ms)<!--.*?-->', '')).Trim()

    if ([string]::IsNullOrWhiteSpace($cleanTrigger)) {
        Fail "$($open.Name) has empty Trigger section"
    }
    if ([string]::IsNullOrWhiteSpace($cleanIntent)) {
        Fail "$($open.Name) has empty Intent section"
    }

    if ($open.Content -match '(?m)^started:\s*(.+)$') {
        try {
            $startedAt = [DateTimeOffset]::Parse($Matches[1].Trim())
            $ageHours = ([DateTimeOffset]::Now - $startedAt).TotalHours
            if ($ageHours -gt $StaleOpenSessionHours) {
                Fail "$($open.Name) is stale ($([Math]::Round($ageHours, 1))h open)"
            }

            $ageMinutes = ([DateTimeOffset]::Now - $startedAt).TotalMinutes
            if ([string]::IsNullOrWhiteSpace($cleanExchange) -and $ageMinutes -gt 30) {
                Warn "$($open.Name) has no exchange log entries after $([Math]::Round($ageMinutes, 0)) minutes"
            }
        } catch {
            Warn "$($open.Name) has unparsable started timestamp"
        }
    }
}

# Check 6: Fidelity honesty
Write-Host "`nCheck 6: Fidelity honesty"
foreach ($file in $sessionFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ($content -match 'fidelity:\s*verbatim' -and $content -notmatch '\[VERBATIM\]') {
        Fail "$($file.Name) claims verbatim fidelity but has no [VERBATIM] markers"
    }
    if ($content -match 'fidelity:\s*mixed' -and $content -notmatch '\[VERBATIM\]') {
        Warn "$($file.Name) claims mixed fidelity but has no [VERBATIM] markers"
    }
}

# Check 7: Secret hygiene
Write-Host "`nCheck 7: Secret hygiene"
$secretPatterns = @(
    @{ Name = 'AWS Access Key'; Pattern = 'AKIA[0-9A-Z]{16}' },
    @{ Name = 'AWS STS Key'; Pattern = 'ASIA[0-9A-Z]{16}' },
    @{ Name = 'GitHub token'; Pattern = 'gh[pousr]_[A-Za-z0-9]{36,}' },
    @{ Name = 'GitHub fine-grained token'; Pattern = 'github_pat_[A-Za-z0-9_]{60,}' },
    @{ Name = 'Slack token'; Pattern = 'xox[baprs]-[A-Za-z0-9-]{20,}' },
    @{ Name = 'Private key block'; Pattern = '-----BEGIN (RSA |EC |OPENSSH |)?PRIVATE KEY-----' },
    @{ Name = 'Inline secret assignment'; Pattern = '(?i)(api[_-]?key|token|secret|password)\s*[:=]\s*["''][A-Za-z0-9_\-\/=+\.]{20,}["'']' }
)

$trailFilesToScan = @($summaryPath, $indexPath, $readmePath, $genbaPath, $genbaArchivePath)
$trailFilesToScan += @($sessionFiles | ForEach-Object { $_.FullName })
$trailFilesToScan = $trailFilesToScan | Where-Object { $_ -and (Test-Path $_) } | Sort-Object -Unique

$secretHits = 0
foreach ($path in $trailFilesToScan) {
    $lines = [System.IO.File]::ReadAllLines($path, [System.Text.Encoding]::UTF8)
    for ($i = 0; $i -lt $lines.Count; $i++) {
        foreach ($entry in $secretPatterns) {
            if ($lines[$i] -match $entry.Pattern) {
                $rel = $path.Substring($Project.Length).TrimStart('\\')
                Fail "${rel}:$($i + 1) possible secret detected ($($entry.Name))"
                $secretHits++
            }
        }
    }
}

if ($secretHits -eq 0) {
    Pass "No high-confidence secret patterns detected in trail artifacts"
}

# Check 8: Performance guardrail
Write-Host "`nCheck 8: Performance guardrail"
$timer.Stop()
$sessionTotalBytes = ($sessionFiles | Measure-Object -Property Length -Sum).Sum
if (-not $sessionTotalBytes) {
    $sessionTotalBytes = 0
}
$sessionTotalKb = [Math]::Round($sessionTotalBytes / 1024, 1)
$elapsedMs = [Math]::Round($timer.Elapsed.TotalMilliseconds, 2)
Info "Processed $($sessionFiles.Count) session files ($sessionTotalKb KB) in $elapsedMs ms"
if ($elapsedMs -gt $PerformanceWarnMs) {
    Warn "Validation runtime exceeded guardrail ($elapsedMs ms > $PerformanceWarnMs ms)"
} else {
    Pass "Validation runtime within guardrail ($elapsedMs ms <= $PerformanceWarnMs ms)"
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
