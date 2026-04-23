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
    signal detection (warns on sustained plateau: 3+ consecutive zero-delta runs),
    governing-document integrity (skipped, manifesto extracted),
    CHANGELOG version contiguity (catches silently-reverted release entries),
    SCORECARD<->GENBA per-run coverage (catches silently-reverted history),
    latest-run model identity consistency (catches cross-ledger model drift),
    score-change/artifact-change correlation (P3 convergence support),
    and replacement-character / mojibake sentinel detection for skill files.

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

function Get-ScorecardRunRows {
    param([string]$Content)

    $rows = @()
    $inRunTable = $false
    foreach ($line in ($Content -split "`r?`n")) {
        if (-not $inRunTable) {
            if ($line -match '^\|\s*Run\s*\|\s*Date\s*\|\s*Model\s*\|\s*Start Score\s*\|\s*End Score\s*\|\s*Delta\s*\|\s*Target\s*\|\s*Result\s*\|') {
                $inRunTable = $true
            }
            continue
        }

        if ($line -match '^##\s+') {
            $inRunTable = $false
            continue
        }

        if ($line -match '^\|\s*:?-+:?\s*\|') {
            continue
        }

        if ($line -notmatch '^\|\s*(\d+)\s*\|') {
            continue
        }

        $cells = ($line.TrimStart('| ').TrimEnd('| ') -split '\s*\|\s*')
        if ($cells.Count -lt 8) {
            continue
        }

        $rows += [PSCustomObject]@{
            Run        = [int]$cells[0]
            Date       = $cells[1]
            Model      = $cells[2]
            StartScore = $cells[3]
            EndScore   = $cells[4]
            Delta      = $cells[5]
            Target     = $cells[6]
            Result     = ($cells[7..($cells.Count - 1)] -join ' | ')
            Raw        = $line.Trim()
        }
    }

    return $rows
}

$skills = @('kata', 'kaizen', 'kaikaku', 'hansei', 'shiken', 'intent')

Write-Host "`n=== TPS Skill Suite - Mechanical Integrity Check ===" -ForegroundColor Cyan
Write-Host "Suite root: $script:suiteRoot"
Write-Host ""

# -- Check 1: Encoding integrity (mojibake) ------------------------------------
Write-Host "[1/14] Encoding integrity" -ForegroundColor White
# Build patterns from Unicode code points to avoid encoding issues in the script itself
$mojibakePatterns = @(
    [regex]::Escape("$([char]0xE2)$([char]0x20AC)"),   # matches double-encoded em dashes, curly quotes
    [regex]::Escape("$([char]0xE2)$([char]0x2020)"),   # matches double-encoded arrows
    [regex]::Escape("$([char]0xC3)$([char]0xA2)"),     # matches double-encoded a-circumflex
    [regex]::Escape("$([char]0xE6)$([char]0x201C)$([char]0xB9)"),  # matches double-encoded CJK (kaizen/kaikaku)
    [regex]::Escape([string][char]0xFFFD),                            # Unicode replacement character
    [regex]::Escape([string][char]0x00F9)                             # cp1252 artifact seen in corrupted skill files
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
Write-Host "[2/14] Placeholder text" -ForegroundColor White
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
Write-Host "[3/14] Cross-reference completeness" -ForegroundColor White
$siblingMap = @{
    kata    = @('Kaizen', 'Kaikaku', 'Hansei', 'Shiken')
    kaizen  = @('Kata', 'Kaikaku', 'Hansei', 'Shiken')
    kaikaku = @('Kata', 'Kaizen', 'Hansei', 'Shiken')
    hansei  = @('Kata', 'Kaizen', 'Kaikaku', 'Shiken')
    shiken  = @('Kata', 'Kaizen', 'Kaikaku', 'Hansei')
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
    Pass "$skill references all $($siblingMap[$skill].Count) siblings"
}

# -- Check 4: Version alignment -----------------------------------------------
Write-Host "[4/14] Version alignment" -ForegroundColor White
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
Write-Host "[5/14] Ledger consistency" -ForegroundColor White
$genbaPath = Join-Path (Join-Path $script:suiteRoot 'TRAIL') 'GENBA.md'
$genbaArchivePath = Join-Path (Join-Path $script:suiteRoot 'TRAIL') 'GENBA_ARCHIVE.md'
$scorecardPath = Join-Path $script:suiteRoot 'SCORECARD.md'
if ((Test-Path $genbaPath) -and (Test-Path $scorecardPath)) {
    $gContent = Get-Content $genbaPath -Raw -Encoding UTF8
    # Combine active + archive GENBA content for full run history
    $gFullContent = $gContent
    if (Test-Path $genbaArchivePath) {
        $gArchiveContent = Get-Content $genbaArchivePath -Raw -Encoding UTF8
        $gFullContent = $gContent + "`n" + $gArchiveContent
    }
    $genbaRunNumbers = @([regex]::Matches($gFullContent, '(?m)^## Run (\d+)') | ForEach-Object { [int]$_.Groups[1].Value })
    $gRuns = $genbaRunNumbers.Count

    $sContent = Get-Content $scorecardPath -Raw -Encoding UTF8
    $scorecardArchives = Get-ChildItem -Path (Join-Path $script:suiteRoot 'TRAIL') -Filter 'SCORECARD_ARCHIVE*.md'
    foreach ($archive in $scorecardArchives) {
        $sContent += "`n" + (Get-Content $archive.FullName -Raw -Encoding UTF8)
    }
    
    $scorecardRunRows = @(Get-ScorecardRunRows -Content $sContent)
    $genbaTrackedRows = @()
    $invalidatedRows = 0
    foreach ($row in $scorecardRunRows) {
        if ($row.Result -match '\*\*Invalidated\*\*') {
            $invalidatedRows++
        }

        # GENBA is the suite-level ledger. It tracks all TPS Skill Suite rows,
        # plus selected external-target methodology-validation runs that are
        # explicitly recorded in the suite ledger (for example Run 62).
        if ($row.Target -eq 'TPS Skill Suite' -or $genbaRunNumbers -contains $row.Run) {
            $genbaTrackedRows += $row.Run
        }
    }

    if ($gRuns -ne $genbaTrackedRows.Count) {
        Warn "TRAIL/GENBA.md has $gRuns run entries, SCORECARD has $($genbaTrackedRows.Count) rows that should be represented in the suite GENBA ($invalidatedRows invalidated row(s))"
    } else {
        Pass "TRAIL/GENBA.md ($gRuns) and SCORECARD ($($genbaTrackedRows.Count)) suite-GENBA-tracked row counts match"
    }
} else {
    if (-not (Test-Path $genbaPath))     { Warn 'TRAIL/GENBA.md not found' }
    if (-not (Test-Path $scorecardPath)) { Warn 'SCORECARD.md not found' }
}

# -- Check 6: Frontmatter validation ------------------------------------------
Write-Host "[6/14] Frontmatter validation" -ForegroundColor White
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
Write-Host "[7/14] File-hash snapshot" -ForegroundColor White
$hashFile = Join-Path $script:suiteRoot 'INTEGRITY.json'
$current = [ordered]@{}
foreach ($skill in $skills) {
    $rel = "$skill/SKILL.md"
    $abs = Join-Path $script:suiteRoot "$skill\SKILL.md"
    if (Test-Path $abs) {
        $current[$rel] = (Get-FileHash $abs -Algorithm SHA256).Hash.Substring(0, 16)
    }
}
foreach ($ledger in @('TRAIL/GENBA.md', 'TRAIL/GENBA_ARCHIVE.md', 'SCORECARD.md', 'CHANGELOG.md', 'STANDARDS.md', 'METRICS_HISTORY.md', 'verify-suite.ps1', 'metrics.ps1')) {
    $abs = Join-Path $script:suiteRoot $ledger
    if (Test-Path $abs) {
        $current[$ledger] = (Get-FileHash $abs -Algorithm SHA256).Hash.Substring(0, 16)
    }
}

$currentVersion = if ($unique.Count -eq 1) { $unique[0] } else { 'MISMATCH' }
$shouldWriteSnapshot = $true
$storedLatestScoredRun = $null
$currentLatestScoredRun = $null

if (Test-Path $scorecardPath) {
    $currentScorecardRows = @(Get-ScorecardRunRows -Content (Get-Content $scorecardPath -Raw -Encoding UTF8))
    $currentScoredRows = @($currentScorecardRows | Where-Object { $_.Delta -notmatch 'N/A' })
    if ($currentScoredRows.Count -gt 0) {
        $currentLatestScoredRun = ($currentScoredRows | Measure-Object -Property Run -Maximum).Maximum
    }
}

if (Test-Path $hashFile) {
    $stored = Get-Content $hashFile -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($stored.PSObject.Properties.Name -contains 'latest_scored_run' -and $stored.latest_scored_run -ne $null) {
        $storedLatestScoredRun = [int]$stored.latest_scored_run
    }
    $storedFiles = @{}
    foreach ($prop in $stored.files.PSObject.Properties) {
        $storedFiles[$prop.Name] = $prop.Value
    }

    $added = @()
    $removed = @()
    $modified = @()

    foreach ($key in $current.Keys) {
        if (-not $storedFiles.ContainsKey($key)) {
            $added += $key
            continue
        }

        $val = $current[$key]
        $prev = $storedFiles[$key]
        if ($prev -ne $val) {
            $modified += $key
        }
    }

    foreach ($key in $storedFiles.Keys) {
        if (-not $current.Contains($key)) {
            $removed += $key
        }
    }

    if ($added.Count -gt 0) {
        Info "Files added to snapshot: $($added -join ', ')"
    }
    if ($removed.Count -gt 0) {
        Info "Files removed from snapshot: $($removed -join ', ')"
    }
    if ($modified.Count -gt 0) {
        Info "Files modified since last snapshot: $($modified -join ', ')"
    }

    if ($added.Count -eq 0 -and $removed.Count -eq 0 -and $modified.Count -eq 0 -and $stored.suite_version -eq $currentVersion) {
        Pass 'All files match stored hashes'
        $shouldWriteSnapshot = $false
    }
}

# Write new snapshot only when tracked content materially changed.
if ($shouldWriteSnapshot) {
    $snapshot = [ordered]@{
        last_verified     = (Get-Date -Format 'o')
        suite_version     = $currentVersion
        latest_scored_run = $currentLatestScoredRun
        files             = $current
    }
    $snapshot | ConvertTo-Json -Depth 3 | Set-Content $hashFile -Encoding UTF8
    Pass "Hash snapshot written to INTEGRITY.json"
} else {
    Pass 'Hash snapshot unchanged; INTEGRITY.json not rewritten'
}

# -- Check 8: Suite skill inventory -------------------------------------------
Write-Host "[8/14] Suite skill inventory" -ForegroundColor White
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

# -- Check 9: Periodic-Hansei signal detection --------------------------------
Write-Host "[9/14] Periodic-Hansei cadence" -ForegroundColor White
if (Test-Path $genbaPath) {
    # Use combined active + archive content for full Hansei history
    $gCheckContent = $gFullContent
    if ($null -eq $gCheckContent) { $gCheckContent = Get-Content $genbaPath -Raw -Encoding UTF8 }
    $runBlocks = [regex]::Matches($gCheckContent, '(?ms)^## Run (\d+).*?(?=^## Run \d+|\z)')
    $latestRun = $null
    $lastHanseiRun = $null

    foreach ($block in $runBlocks) {
        $runNumber = [int]$block.Groups[1].Value
        if ($null -eq $latestRun -or $runNumber -gt $latestRun) {
            $latestRun = $runNumber
        }

        # Only count explicit Hansei sections or Hansei runs, not narrative mentions in findings or observations.
        if ($block.Value -match '(?im)^###+\s*Hansei(?:\s+Pass)?\b' -or $block.Value -match '(?im)^## Run \d+\s*\(Hansei\)') {
            if ($null -eq $lastHanseiRun -or $runNumber -gt $lastHanseiRun) {
                $lastHanseiRun = $runNumber
            }
        }
    }

    # Signal-based: check for sustained plateau (3+ consecutive zero-delta runs
    # without convergence declared). This replaces the old fixed-cadence check.
    $scPath = Join-Path $script:suiteRoot 'SCORECARD.md'
    if (Test-Path $scPath) {
        $scContent = Get-Content $scPath -Raw
        $scRunRows = Get-ScorecardRunRows $scContent
        # Walk backward from latest run, count consecutive zero-delta rows
        $zeroChain = 0
        $sortedRows = $scRunRows | Sort-Object { $_.Run } -Descending
        foreach ($row in $sortedRows) {
            if ($row.Delta -match '^\+?-?0\.0+$') {
                $zeroChain++
            } else {
                break
            }
        }
        if ($zeroChain -ge 3 -and $null -ne $lastHanseiRun -and $latestRun -gt $lastHanseiRun) {
            Warn "$zeroChain consecutive zero-delta runs detected (sustained plateau). Hansei signal triggered — consider loop reflection."
        } else {
            Pass "No sustained-plateau signal ($zeroChain consecutive zero-delta runs, threshold 3)"
        }
    } else {
        # Fallback: no SCORECARD, use simple run-count check
        if ($null -eq $lastHanseiRun) {
            Warn "GENBA shows no Hansei invocation. Consider whether Hansei signals (recurring findings, plateau, methodology doubt) are present."
        } else {
            Pass "Last Hansei at Run $lastHanseiRun (signal-based check — no SCORECARD for plateau detection)"
        }
    }
} else {
    Warn 'TRAIL/GENBA.md not found — cannot check Hansei signals'
}

# -- Check 10: PRINCIPLES.md governing-document integrity (Skipped) --------
Write-Host "[10/14] Governing-document integrity (Skipped - Manifesto Extracted)" -ForegroundColor DarkGray
Pass "Governing-document extracted to independent manifesto repository"

# -- Check 11: CHANGELOG version contiguity -----------------------------------
Write-Host "[11/14] CHANGELOG version contiguity" -ForegroundColor White
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
Write-Host "[12/14] SCORECARD <-> GENBA per-run coverage" -ForegroundColor White
if ((Test-Path $genbaPath) -and (Test-Path $scorecardPath)) {
    # Use combined active + archive for full run coverage
    $gCheck12Content = $gFullContent
    if ($null -eq $gCheck12Content) { $gCheck12Content = Get-Content $genbaPath -Raw -Encoding UTF8 }
    $sContent = Get-Content $scorecardPath -Raw
    # Collect run numbers from GENBA "## Run N" headings (active + archive)
    $genbaRuns = @()
    foreach ($m in [regex]::Matches($gCheck12Content, '(?m)^## Run (\d+)')) {
        $genbaRuns += [int]$m.Groups[1].Value
    }
    # Collect non-invalidated SCORECARD rows for this target only.
    $scorecardRows = @()
    foreach ($row in (Get-ScorecardRunRows -Content $sContent)) {
        if ($row.Result -notmatch '\*\*Invalidated\*\*' -and $row.Target -notlike '*external*') {
            $scorecardRows += $row.Run
        }
    }
    $missingFromGenba = @($scorecardRows | Where-Object { $genbaRuns -notcontains $_ } | Sort-Object)
    if ($missingFromGenba.Count -gt 0) {
        Warn "SCORECARD lists TPS Skill Suite runs with no GENBA entry: $($missingFromGenba -join ', ')"
    } else {
        Pass "Every non-invalidated TPS Skill Suite SCORECARD row has a matching GENBA entry"
    }
} else {
    Pass 'SCORECARD/TRAIL/GENBA coverage check skipped (one or both missing)'
}

# -- Check 13: Latest-run model identity consistency --------------------------
Write-Host "[13/14] Latest-run model identity consistency" -ForegroundColor White
if ((Test-Path $genbaPath) -and (Test-Path $scorecardPath)) {
    # Latest run is always in the active GENBA file (not archive)
    $gContent = Get-Content $genbaPath -Raw -Encoding UTF8
    $sContent = Get-Content $scorecardPath -Raw
    $scorecardRunRows = @(Get-ScorecardRunRows -Content $sContent)

    $runMatches = [regex]::Matches($gContent, '(?m)^## Run (\d+)')
    if ($runMatches.Count -eq 0) {
        Fail 'GENBA has no run headings; cannot verify latest model identity'
    } else {
        $latestGenbaRun = ($runMatches | ForEach-Object { [int]$_.Groups[1].Value } | Measure-Object -Maximum).Maximum
        $latestBlock = [regex]::Match($gContent, "(?ms)^## Run $latestGenbaRun\b.*?(?=^## Run \d+|\z)")
        if (-not $latestBlock.Success) {
            Fail "Could not extract GENBA block for latest run $latestGenbaRun"
        } else {
            $genbaModelMatch = [regex]::Match($latestBlock.Value, '(?m)^\|\s*Model\s*\|\s*(.*?)\s*\|\s*$')
            if (-not $genbaModelMatch.Success) {
                Fail "GENBA Run $latestGenbaRun missing '| Model | ... |' row"
            } else {
                $genbaModel = $genbaModelMatch.Groups[1].Value.Trim()
                if ([string]::IsNullOrWhiteSpace($genbaModel) -or $genbaModel -match '^\[.*\]$') {
                    Fail "GENBA Run $latestGenbaRun model is empty or placeholder: '$genbaModel'"
                } else {
                        $scoreRow = @($scorecardRunRows | Where-Object { $_.Run -eq $latestGenbaRun } | Select-Object -First 1)
                        if ($scoreRow.Count -eq 0) {
                        Fail "SCORECARD missing row for latest GENBA run $latestGenbaRun"
                    } else {
                            $scoreModel = $scoreRow[0].Model.Trim()
                            if ([string]::IsNullOrWhiteSpace($scoreModel) -or $scoreModel -match '^\[.*\]$') {
                                Fail "SCORECARD Run $latestGenbaRun model is empty or placeholder: '$scoreModel'"
                            } elseif ($scoreModel -ne $genbaModel) {
                                Fail "Latest run model mismatch for Run $latestGenbaRun GENBA='$genbaModel' vs SCORECARD='$scoreModel'"
                            } else {
                                Pass "Latest run model identity is consistent for Run $latestGenbaRun ($genbaModel)"
                        }
                    }
                }
            }
        }
    }
} else {
    Pass 'Latest-run model identity check skipped (one or both missing)'
}

# -- Check 14: Score-change / artifact-change correlation (P3 convergence) -----
Write-Host "[14/14] Score-change / artifact-change correlation" -ForegroundColor White
if ((Test-Path $scorecardPath) -and (Test-Path $hashFile)) {
    $sContent = Get-Content $scorecardPath -Raw -Encoding UTF8
    # Find the latest scored run (non-N/A delta) in the main run table only.
    $scoredRows = @(Get-ScorecardRunRows -Content $sContent | Where-Object { $_.Delta -notmatch 'N/A' })
    if ($scoredRows.Count -ge 1) {
        $latest = $scoredRows | Sort-Object Run -Descending | Select-Object -First 1
        $deltaVal = 0.0
        if ($latest.Delta -match '^[+-]?(\d+\.?\d*)') {
            $deltaVal = [double]$latest.Delta
        }
        # A non-zero score delta with zero artifact changes (or vice versa) is suspicious
        # The hash check (Check 7) already flags modified files -- we cross-reference
        $hasArtifactChanges = ($null -ne $modified -and $modified.Count -gt 0) -or ($null -ne $added -and $added.Count -gt 0) -or ($null -ne $removed -and $removed.Count -gt 0)
        if ([Math]::Abs($deltaVal) -gt 0 -and -not $hasArtifactChanges -and $storedLatestScoredRun -ne $latest.Run) {
            Warn "Run $($latest.Run) reports delta $($latest.Delta) but INTEGRITY.json shows no artifact changes -- verify score is justified by prior-run fixes"
        } elseif ([Math]::Abs($deltaVal) -gt 0 -and -not $hasArtifactChanges -and $storedLatestScoredRun -eq $latest.Run) {
            Pass "Latest scored run (Run $($latest.Run)) is already reflected in the current snapshot"
        } else {
            Pass "Score-change/artifact-change correlation is consistent for latest scored run (Run $($latest.Run), delta $($latest.Delta))"
        }
    } else {
        Pass 'No scored runs found in SCORECARD -- correlation check skipped'
    }
} else {
    Pass 'Score/artifact correlation check skipped (SCORECARD or INTEGRITY.json missing)'
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

