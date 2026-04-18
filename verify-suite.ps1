<#
.SYNOPSIS
    Mechanical integrity verification for the TPS Skill Suite.
.DESCRIPTION
    Catches the entire defect class of Runs 11, 14, and 15 without
    requiring a model to remember to look. Run after every Kata/Kaizen cycle.

    Checks: encoding integrity, placeholder text, cross-reference completeness,
    version alignment, ledger consistency, frontmatter validation, file-hash
    snapshot (diff-based validation inspired by evo's proof ledger), suite skill
    inventory (detects orphan/non-TPS skill directories), periodic-Hansei
    cadence (warns when Hansei has not been invoked for 5+ Kata runs),
    governing-document integrity (PRINCIPLES.md principle inventory),
    CHANGELOG version contiguity (catches silently-reverted release entries),
    and SCORECARD<->GENBA per-run coverage (catches silently-reverted history).

    Requires PowerShell 5.1+ (Windows) or PowerShell Core 7+ (any OS).
    On Linux/macOS: install pwsh via https://aka.ms/install-powershell then
    run `pwsh verify-suite.ps1`. If PowerShell is unavailable, models should
    fall back to manual text scanning per the Kaizen CHECK / Kata Rules guidance.
.EXAMPLE
    .\verify-suite.ps1
    .\verify-suite.ps1 -Verbose
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$script:failures = @()
$script:warnings = @()
$script:suiteRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

function Fail  { param([string]$Msg) $script:failures += $Msg; Write-Host "  FAIL  $Msg" -ForegroundColor Red }
function Warn  { param([string]$Msg) $script:warnings += $Msg; Write-Host "  WARN  $Msg" -ForegroundColor Yellow }
function Pass  { param([string]$Msg) Write-Verbose "  PASS  $Msg" }
function Info  { param([string]$Msg) Write-Host "  INFO  $Msg" -ForegroundColor Cyan }

function Test-BareText {
    # Returns $true if $Pattern matches in $Line OUTSIDE of backtick-quoted spans
    param([string]$Line, [string]$Pattern)
    $stripped = $Line -replace '`[^`]*`', ''
    return ($stripped -match $Pattern)
}

$skills = @('kata', 'kaizen', 'kaikaku', 'mura', 'muri', 'muda', 'hansei')

Write-Host "`n=== TPS Skill Suite - Mechanical Integrity Check ===" -ForegroundColor Cyan
Write-Host "Suite root: $script:suiteRoot"
Write-Host ""

# -- Check 1: Encoding integrity (mojibake) ------------------------------------
Write-Host "[1/12] Encoding integrity" -ForegroundColor White
# Build patterns from Unicode code points to avoid encoding issues in the script itself
$mojibakePatterns = @(
    [regex]::Escape("$([char]0xE2)$([char]0x20AC)"),   # matches double-encoded em dashes, curly quotes
    [regex]::Escape("$([char]0xE2)$([char]0x2020)"),   # matches double-encoded arrows
    [regex]::Escape("$([char]0xC3)$([char]0xA2)"),     # matches double-encoded a-circumflex
    [regex]::Escape("$([char]0xE6)$([char]0x201C)$([char]0xB9)")  # matches double-encoded CJK (kaizen/kaikaku)
)
$allMd = Get-ChildItem -Path $script:suiteRoot -Recurse -Include '*.md' -File
foreach ($file in $allMd) {
    $lines = Get-Content $file.FullName -Encoding UTF8
    $lineNum = 0
    foreach ($line in $lines) {
        $lineNum++
        foreach ($pat in $mojibakePatterns) {
            if ($line -match $pat -and (Test-BareText $line $pat)) {
                Fail "Mojibake in $($file.Name):$lineNum"
            }
        }
    }
}
Pass "Encoding check complete"

# -- Check 2: Placeholder / unfinished text ------------------------------------
Write-Host "[2/12] Placeholder text" -ForegroundColor White
foreach ($skill in $skills) {
    $path = Join-Path $script:suiteRoot "$skill\SKILL.md"
    if (-not (Test-Path $path)) { Fail "Missing: $skill/SKILL.md"; continue }
    $lines = Get-Content $path -Encoding UTF8
    $lineNum = 0
    foreach ($line in $lines) {
        $lineNum++
        if (Test-BareText $line '//\s*\.\.\.\s*existing') {
            Fail "Placeholder '// ... existing code' in $skill/SKILL.md:$lineNum"
        }
    }
    Pass "No placeholders in $skill/SKILL.md"
}

# -- Check 3: Cross-reference completeness ------------------------------------
Write-Host "[3/12] Cross-reference completeness" -ForegroundColor White
$siblingMap = @{
    kata    = @('Kaizen', 'Kaikaku', 'Mura', 'Muri', 'Muda', 'Hansei')
    kaizen  = @('Kata', 'Kaikaku', 'Mura', 'Muri', 'Muda', 'Hansei')
    kaikaku = @('Kata', 'Kaizen', 'Mura', 'Muri', 'Muda', 'Hansei')
    mura    = @('Kata', 'Kaizen', 'Kaikaku', 'Muri', 'Muda', 'Hansei')
    muri    = @('Kata', 'Kaizen', 'Kaikaku', 'Mura', 'Muda', 'Hansei')
    muda    = @('Kata', 'Kaizen', 'Kaikaku', 'Mura', 'Muri', 'Hansei')
    hansei  = @('Kata', 'Kaizen', 'Kaikaku', 'Mura', 'Muri', 'Muda')
}
foreach ($skill in $skills) {
    $path = Join-Path $script:suiteRoot "$skill\SKILL.md"
    if (-not (Test-Path $path)) { continue }
    $content = Get-Content $path -Raw
    foreach ($sib in $siblingMap[$skill]) {
        if ($content -notmatch "\*\*$sib\*\*") {
            Fail "$skill/SKILL.md missing bold reference to **$sib**"
        }
    }
    Pass "$skill references all 6 siblings"
}

# -- Check 4: Version alignment -----------------------------------------------
Write-Host "[4/12] Version alignment" -ForegroundColor White
$versions = @{}
foreach ($skill in $skills) {
    $path = Join-Path $script:suiteRoot "$skill\SKILL.md"
    if (-not (Test-Path $path)) { continue }
    $content = Get-Content $path -Raw
    if ($content -match 'version:\s*([\d.]+)') {
        $versions[$skill] = $Matches[1]
    } else {
        Fail "$skill/SKILL.md has no version field in frontmatter"
    }
}
$unique = @($versions.Values | Sort-Object -Unique)
if ($unique.Count -gt 1) {
    $detail = ($versions.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join ', '
    Fail "Version mismatch across skills: $detail"
} elseif ($unique.Count -eq 1) {
    Pass "All skills at v$($unique[0])"
}

# -- Check 5: GENBA / SCORECARD consistency ------------------------------------
Write-Host "[5/12] Ledger consistency" -ForegroundColor White
$genbaPath = Join-Path $script:suiteRoot 'GENBA.md'
$scorecardPath = Join-Path $script:suiteRoot 'SCORECARD.md'
if ((Test-Path $genbaPath) -and (Test-Path $scorecardPath)) {
    $gContent = Get-Content $genbaPath -Raw
    $gRuns = ([regex]::Matches($gContent, '## Run \d+')).Count

    $sContent = Get-Content $scorecardPath -Raw
    $sRows = ([regex]::Matches($sContent, '(?m)^\|\s*\d+\s*\|')).Count
    $invalidatedRows = ([regex]::Matches($sContent, '(?m)^\|\s*\d+\s*\|.*\*\*Invalidated\*\*')).Count

    if ($gRuns -ne $sRows) {
        Warn "GENBA has $gRuns run entries, SCORECARD has $sRows rows ($invalidatedRows invalidated row(s); mismatch can also come from archived or lost history)"
    } else {
        Pass "GENBA ($gRuns) and SCORECARD ($sRows) counts match"
    }
} else {
    if (-not (Test-Path $genbaPath))     { Warn 'GENBA.md not found' }
    if (-not (Test-Path $scorecardPath)) { Warn 'SCORECARD.md not found' }
}

# -- Check 6: Frontmatter validation ------------------------------------------
Write-Host "[6/12] Frontmatter validation" -ForegroundColor White
$requiredFields = @('name', 'version', 'description')
foreach ($skill in $skills) {
    $path = Join-Path $script:suiteRoot "$skill\SKILL.md"
    if (-not (Test-Path $path)) { continue }
    $content = Get-Content $path -Raw
    if ($content -notmatch '^---\s*\r?\n([\s\S]*?)\r?\n---') {
        Fail "$skill/SKILL.md has no YAML frontmatter block"
        continue
    }
    $fm = $Matches[1]
    foreach ($field in $requiredFields) {
        if ($fm -notmatch "${field}\s*:") {
            Fail "$skill/SKILL.md frontmatter missing '$field'"
        }
    }
    Pass "$skill frontmatter complete"
}

# -- Check 7: File-hash snapshot (diff-based validation) -----------------------
Write-Host "[7/12] File-hash snapshot" -ForegroundColor White
$hashFile = Join-Path $script:suiteRoot 'INTEGRITY.json'
$current = [ordered]@{}
foreach ($skill in $skills) {
    $rel = "$skill/SKILL.md"
    $abs = Join-Path $script:suiteRoot "$skill\SKILL.md"
    if (Test-Path $abs) {
        $current[$rel] = (Get-FileHash $abs -Algorithm SHA256).Hash.Substring(0, 16)
    }
}
foreach ($ledger in @('GENBA.md', 'SCORECARD.md', 'CHANGELOG.md', 'PRINCIPLES.md')) {
    $abs = Join-Path $script:suiteRoot $ledger
    if (Test-Path $abs) {
        $current[$ledger] = (Get-FileHash $abs -Algorithm SHA256).Hash.Substring(0, 16)
    }
}

if (Test-Path $hashFile) {
    $stored = Get-Content $hashFile -Raw | ConvertFrom-Json
    $modified = @()
    $current.GetEnumerator() | ForEach-Object {
        $key = $_.Key
        $val = $_.Value
        $prev = $stored.files.PSObject.Properties | Where-Object { $_.Name -eq $key } | Select-Object -ExpandProperty Value
        if ($prev -and $prev -ne $val) {
            $modified += $key
        }
    }
    if ($modified.Count -gt 0) {
        Info "Files modified since last snapshot: $($modified -join ', ')"
    } else {
        Pass 'All files match stored hashes'
    }
}

# Write new snapshot
$snapshot = [ordered]@{
    last_verified = (Get-Date -Format 'o')
    suite_version = if ($unique.Count -eq 1) { $unique[0] } else { 'MISMATCH' }
    files         = $current
}
$snapshot | ConvertTo-Json -Depth 3 | Set-Content $hashFile -Encoding UTF8
Pass "Hash snapshot written to INTEGRITY.json"

# -- Check 8: Suite skill inventory -------------------------------------------
Write-Host "[8/12] Suite skill inventory" -ForegroundColor White
$skillDirs = Get-ChildItem -Path $script:suiteRoot -Directory | Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }
$nonTps = @()
foreach ($dir in $skillDirs) {
    if ($skills -notcontains $dir.Name) {
        $nonTps += $dir.Name
    }
}
if ($nonTps.Count -gt 0) {
    Info "Non-TPS skills present in suite root: $($nonTps -join ', ') (out of scope for TPS checks; tracked for inventory honesty)"
} else {
    Pass 'Only TPS skills present'
}

# -- Check 9: Periodic-Hansei cadence -----------------------------------------
Write-Host "[9/12] Periodic-Hansei cadence" -ForegroundColor White
if (Test-Path $genbaPath) {
    $gContent = Get-Content $genbaPath -Raw
    $runBlocks = [regex]::Matches($gContent, '(?ms)^## Run (\d+).*?(?=^## Run \d+|\z)')
    $latestRun = $null
    $lastHanseiRun = $null

    foreach ($block in $runBlocks) {
        $runNumber = [int]$block.Groups[1].Value
        if ($null -eq $latestRun -or $runNumber -gt $latestRun) {
            $latestRun = $runNumber
        }

        # Only count explicit Hansei sections, not narrative mentions in findings or observations.
        if ($block.Value -match '(?im)^###+\s*Hansei(?:\s+Pass)?\b') {
            if ($null -eq $lastHanseiRun -or $runNumber -gt $lastHanseiRun) {
                $lastHanseiRun = $runNumber
            }
        }
    }

    if ($null -eq $lastHanseiRun) {
        Warn "GENBA shows no Hansei invocation. Periodic-Hansei rule (every 5 Kata runs) overdue."
    } else {
        $runsAfterHansei = $latestRun - $lastHanseiRun
        if ($runsAfterHansei -ge 5) {
            Warn "$runsAfterHansei Kata runs since last Hansei reference in GENBA. Periodic-Hansei (default 5) overdue."
        } else {
            Pass "$runsAfterHansei Kata runs since last Hansei (within periodic threshold of 5)"
        }
    }
} else {
    Warn 'GENBA.md not found — cannot check Hansei cadence'
}

# -- Check 10: PRINCIPLES.md governing-document integrity ----------------------
Write-Host "[10/12] Governing-document integrity" -ForegroundColor White
$principlesPath = Join-Path $script:suiteRoot 'PRINCIPLES.md'
if (Test-Path $principlesPath) {
    $pContent = Get-Content $principlesPath -Raw
    $expectedPrinciples = @(
        @{ Number = 1; Name = "Commander's Intent" },
        @{ Number = 2; Name = "Observable Autonomy" },
        @{ Number = 3; Name = "Convergence Is Silence" }
    )
    foreach ($p in $expectedPrinciples) {
        $pattern = "## Principle $($p.Number):\s*$([regex]::Escape($p.Name))"
        if ($pContent -notmatch $pattern) {
            Fail "PRINCIPLES.md missing Principle $($p.Number): $($p.Name)"
        }
    }
    if ($script:failures.Count -eq 0) {
        Pass "PRINCIPLES.md contains all $($expectedPrinciples.Count) expected principles"
    }
} else {
    Fail 'PRINCIPLES.md not found — governing document missing'
}

# -- Check 11: CHANGELOG version contiguity -----------------------------------
Write-Host "[11/12] CHANGELOG version contiguity" -ForegroundColor White
$changelogPath = Join-Path $script:suiteRoot 'CHANGELOG.md'
if (Test-Path $changelogPath) {
    $cContent = Get-Content $changelogPath -Raw
    $versionMatches = [regex]::Matches($cContent, '(?m)^##\s*\[(\d+)\.(\d+)\.(\d+)\]')
    $versionTriples = @()
    foreach ($m in $versionMatches) {
        $versionTriples += ,@([int]$m.Groups[1].Value, [int]$m.Groups[2].Value, [int]$m.Groups[3].Value)
    }
    if ($versionTriples.Count -lt 2) {
        Pass "CHANGELOG has $($versionTriples.Count) versioned entries (no contiguity check needed)"
    } else {
        # Walk newest-first: each pair (newer, older) must be exactly one minor or one patch step.
        $gaps = @()
        for ($i = 0; $i -lt $versionTriples.Count - 1; $i++) {
            $newer = $versionTriples[$i]
            $older = $versionTriples[$i + 1]
            $okMinor = ($newer[0] -eq $older[0]) -and ($newer[1] -eq $older[1] + 1) -and ($newer[2] -eq 0)
            $okPatch = ($newer[0] -eq $older[0]) -and ($newer[1] -eq $older[1])     -and ($newer[2] -eq $older[2] + 1)
            $okMajor = ($newer[0] -eq $older[0] + 1) -and ($newer[1] -eq 0) -and ($newer[2] -eq 0)
            if (-not ($okMinor -or $okPatch -or $okMajor)) {
                $newerStr = "$($newer[0]).$($newer[1]).$($newer[2])"
                $olderStr = "$($older[0]).$($older[1]).$($older[2])"
                $gaps += "$newerStr -> $olderStr"
            }
        }
        if ($gaps.Count -gt 0) {
            Fail "CHANGELOG has non-contiguous version sequence (skipped releases): $($gaps -join '; ')"
        } else {
            Pass "CHANGELOG version sequence is contiguous ($($versionTriples.Count) entries)"
        }
    }
} else {
    Warn 'CHANGELOG.md not found'
}

# -- Check 12: SCORECARD <-> GENBA per-run coverage ----------------------------
Write-Host "[12/12] SCORECARD <-> GENBA per-run coverage" -ForegroundColor White
if ((Test-Path $genbaPath) -and (Test-Path $scorecardPath)) {
    $gContent = Get-Content $genbaPath -Raw
    $sContent = Get-Content $scorecardPath -Raw
    # Collect run numbers from GENBA "## Run N" headings
    $genbaRuns = @()
    foreach ($m in [regex]::Matches($gContent, '(?m)^## Run (\d+)')) {
        $genbaRuns += [int]$m.Groups[1].Value
    }
    # Collect non-invalidated SCORECARD rows: "| N | YYYY-MM-DD | ... | <not Invalidated> |"
    $scorecardRows = @()
    foreach ($m in [regex]::Matches($sContent, '(?m)^\|\s*(\d+)\s*\|[^\n]*$')) {
        $row = $m.Value
        if ($row -notmatch '\*\*Invalidated\*\*') {
            $scorecardRows += [int]$m.Groups[1].Value
        }
    }
    $missingFromGenba = @($scorecardRows | Where-Object { $genbaRuns -notcontains $_ } | Sort-Object)
    if ($missingFromGenba.Count -gt 0) {
        Warn "SCORECARD lists runs with no GENBA entry: $($missingFromGenba -join ', ') (likely archived/lost history; investigate)"
    } else {
        Pass "Every non-invalidated SCORECARD row has a matching GENBA entry"
    }
} else {
    Pass 'SCORECARD/GENBA coverage check skipped (one or both missing)'
}

# -- Summary -------------------------------------------------------------------
Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Cyan
$fc = $script:failures.Count
$wc = $script:warnings.Count
Write-Host "Failures : $fc" -ForegroundColor $(if ($fc -eq 0) { 'Green' } else { 'Red' })
Write-Host "Warnings : $wc" -ForegroundColor $(if ($wc -eq 0) { 'Green' } else { 'Yellow' })

if ($fc -gt 0) {
    Write-Host "`nFailed checks:" -ForegroundColor Red
    $script:failures | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    exit 1
}

Write-Host "`nAll checks passed." -ForegroundColor Green
exit 0
