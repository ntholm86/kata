<#
.SYNOPSIS
    Computable metrics for the TPS Skill Suite -- objective statistics derived
    from SCORECARD.md and TRAIL/GENBA.md ledger data.
.DESCRIPTION
    Bridges the gap between semantic scoring (Rubric v1) and mechanical
    checking (verify-suite.ps1) by computing reproducible, model-independent
    statistics from the experiment data trail.

    Metrics computed:
      1. Inter-rater agreement   -- do different models agree on starting scores?
      2. Defect recurrence rate  -- are fixes sticking?
      3. Invalidation rate       -- how often do runs get thrown out?
      4. Regression frequency    -- how often does a run damage the suite?
      5. Model diversity index   -- how many distinct model families have participated?
      6. Fix durability          -- what fraction of runs produced lasting improvements?
      7. P3 silence counter      -- consecutive zero-delta runs and distinct evaluators (computed, not asserted)
      8. Session elapsed time    -- how long do sessions take? (model speed, suite overhead)
      9. Transcript size         -- how large are session transcripts? (effort/context cost proxy)
     10. GENBA growth rate       -- is the ledger becoming a scaling bottleneck?
     11. Reviewer engagement     -- is anyone actually reading the trail?

    Threshold rationale (CMMI QPM L4 -- operationally defined):
      Agreement (stdev of de-anchored start scores):
        GOOD <= 0.5  : on a 1-10 scale, 0.5 stdev means ~95% of scores fall
                       within 1 point of the mean. Comparable to inter-rater
                       reliability thresholds in psychometrics (ICC > 0.75).
        MODERATE <= 1.0 : evaluators disagree by up to 2 points -- actionable
                          but not disqualifying.
        POOR > 1.0   : >2-point spread suggests evaluators are measuring
                        different things or anchoring to different baselines.
      Recurrence rate:
        GOOD <= 10%  : comparable to software defect escape rates in CMMI L4
                       organizations. Most fixes stick.
        MODERATE <= 25% : 1 in 4 fixes fails -- root causes may be structural.
        POOR > 25%   : fixes are cosmetic, not causal.
      Invalidation rate:
        GOOD <= 5%   : <1 in 20 runs produces unusable output. Comparable to
                       manufacturing defect rates at Six Sigma 3-sigma level.
        MODERATE <= 15% : occasional tool/model failure, manageable.
        POOR > 15%   : the evaluation process itself is unreliable.
      Regression rate:
        GOOD <= 5%   : same threshold as invalidation -- improvements should
                       be at least as durable as the process is valid.
        MODERATE <= 15% : some backsliding, often from rubric changes.
        POOR > 15%   : the loop is not locking in gains.
      Model diversity:
        GOOD >= 5    : enough families to surface family-specific blind spots.
                       Based on empirical finding that 3-4 families still miss
                       defects (Runs 3-4 showed different models find different
                       defects at the same score).
        MODERATE >= 3 : minimum for meaningful cross-validation.
        POOR < 3     : effectively single-evaluator despite multiple runs.

    Requires PowerShell 5.1+ (Windows) or PowerShell Core 7+ (any OS).
.EXAMPLE
    .\metrics.ps1
    .\metrics.ps1 -Verbose
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$script:suiteRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

# ---------------------------------------------------------------------------
# Parse SCORECARD.md
# ---------------------------------------------------------------------------
$scorecardPath = Join-Path $script:suiteRoot 'SCORECARD.md'
if (-not (Test-Path $scorecardPath)) {
    Write-Error "SCORECARD.md not found at $scorecardPath"
    return
}

$scContent = Get-Content $scorecardPath -Raw -Encoding UTF8

# Extract only the main run table rows. SCORECARD also contains numeric rubric and
# trajectory tables that must not be counted as run records.
$rows = @()
$inRunTable = $false
foreach ($line in ($scContent -split "`r?`n")) {
    if (-not $inRunTable) {
        if ($line -match '^\|\s*Run\s*\|\s*Date\s*\|\s*Model\s*\|\s*Start Score\s*\|\s*End Score\s*\|\s*Delta\s*\|\s*Target\s*\|\s*Result\s*\|') {
            $inRunTable = $true
        }
        continue
    }

    if ($line -match '^##\s+') {
        break
    }

    if ($line -match '^\|\s*:?-+:?\s*\|') {
        continue
    }

    if ($line -match '^\|\s*(\d+)\s*\|') {
        # Strip leading/trailing pipes and split by remaining pipes
        $cells = ($line.TrimStart('| ').TrimEnd('| ') -split '\s*\|\s*')
        if ($cells.Count -ge 8) {
            $rows += [PSCustomObject]@{
                Run        = [int]$cells[0]
                Date       = $cells[1]
                Model      = $cells[2]
                StartScore = $cells[3]
                EndScore   = $cells[4]
                Delta      = $cells[5]
                Target     = $cells[6]
                Result     = ($cells[7..($cells.Count - 1)] -join ' | ')
            }
        }
    }
}

$totalRuns = $rows.Count
$invalidPattern = '\*\*Invalidated\*\*'
$invalidated = @($rows | Where-Object { $_.Result -match $invalidPattern })
$valid = @($rows | Where-Object { $_.Result -notmatch $invalidPattern })

# ---------------------------------------------------------------------------
# Parse TRAIL/GENBA.md (active + archive) for recurrence data
# ---------------------------------------------------------------------------
$genbaPath = Join-Path (Join-Path $script:suiteRoot 'TRAIL') 'GENBA.md'
$genbaArchivePath = Join-Path (Join-Path $script:suiteRoot 'TRAIL') 'GENBA_ARCHIVE.md'
$recurrenceCount = 0
$totalFindings = 0
if (Test-Path $genbaPath) {
    $gContent = Get-Content $genbaPath -Raw -Encoding UTF8
    # Combine active + archive for full recurrence analysis
    $gFullContent = $gContent
    if (Test-Path $genbaArchivePath) {
        $gArchiveContent = Get-Content $genbaArchivePath -Raw -Encoding UTF8
        $gFullContent = $gContent + "`n" + $gArchiveContent
    }
    # Count findings rows that have "Run N" in the Recurred? column (not "First")
    $findingPattern = '(?m)^\|\s*\d+\s*\|.*?\|\s*(First|Run \d+)\s*\|'
    $findingRows = [regex]::Matches($gFullContent, $findingPattern)
    $totalFindings = $findingRows.Count
    $recurredPattern = 'Run \d+'
    foreach ($fr in $findingRows) {
        if ($fr.Groups[1].Value -match $recurredPattern) {
            $recurrenceCount++
        }
    }
}

# ---------------------------------------------------------------------------
# Metric 1: Inter-Rater Agreement (Start Score Variance)
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "=== TPS Skill Suite -- Computable Metrics ===" -ForegroundColor Cyan
Write-Host "Data source: $totalRuns SCORECARD rows, $totalFindings GENBA findings"
Write-Host ""

$numericStarts = @()
$numPattern = '^(\d+\.?\d*)'
foreach ($r in $valid) {
    $s = $r.StartScore
    if ($s -match $numPattern) {
        $numericStarts += [double]$Matches[1]
    }
}

$stddev = 0
if ($numericStarts.Count -ge 2) {
    $mean = ($numericStarts | Measure-Object -Average).Average
    $sumSqDev = 0
    foreach ($v in $numericStarts) { $sumSqDev += ($v - $mean) * ($v - $mean) }
    $variance = $sumSqDev / $numericStarts.Count
    $stddev = [Math]::Sqrt($variance)

    $minStart = ($numericStarts | Measure-Object -Minimum).Minimum
    $maxStart = ($numericStarts | Measure-Object -Maximum).Maximum

    Write-Host "[1] Inter-Rater Agreement (de-anchored start scores)" -ForegroundColor White
    Write-Host "    Mean start score : $([Math]::Round($mean, 2))"
    Write-Host "    Std deviation    : $([Math]::Round($stddev, 2))"
    Write-Host "    Range            : $minStart to $maxStart"
    Write-Host "    N (valid runs)   : $($numericStarts.Count)"
    if ($stddev -le 0.5) {
        Write-Host "    Assessment       : GOOD -- evaluators broadly agree (stdev <= 0.5)" -ForegroundColor Green
    } elseif ($stddev -le 1.0) {
        Write-Host "    Assessment       : MODERATE -- some evaluator disagreement (0.5 < stdev <= 1.0)" -ForegroundColor Yellow
    } else {
        Write-Host "    Assessment       : POOR -- significant evaluator disagreement (stdev > 1.0)" -ForegroundColor Red
    }
} else {
    Write-Host "[1] Inter-Rater Agreement: insufficient data (need >= 2 valid runs)"
}

# ---------------------------------------------------------------------------
# Metric 2: Defect Recurrence Rate
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "[2] Defect Recurrence Rate" -ForegroundColor White
$recurrenceRate = 0
if ($totalFindings -gt 0) {
    $recurrenceRate = [Math]::Round(($recurrenceCount / $totalFindings) * 100, 1)
    Write-Host "    Total findings   : $totalFindings"
    Write-Host "    Recurrences      : $recurrenceCount"
    Write-Host "    Recurrence rate  : $recurrenceRate%"
    if ($recurrenceRate -le 10) {
        Write-Host "    Assessment       : GOOD -- fixes are sticking (<= 10%)" -ForegroundColor Green
    } elseif ($recurrenceRate -le 25) {
        Write-Host "    Assessment       : MODERATE -- some fixes not durable (10-25%)" -ForegroundColor Yellow
    } else {
        Write-Host "    Assessment       : POOR -- high recurrence, root causes not addressed (> 25%)" -ForegroundColor Red
    }
} else {
    Write-Host "    No structured findings in TRAIL/GENBA.md"
}

# ---------------------------------------------------------------------------
# Metric 3: Invalidation Rate
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "[3] Invalidation Rate" -ForegroundColor White
$invalRate = [Math]::Round(($invalidated.Count / $totalRuns) * 100, 1)
Write-Host "    Total runs       : $totalRuns"
Write-Host "    Invalidated      : $($invalidated.Count)"
Write-Host "    Invalidation rate: $invalRate%"
if ($invalRate -le 5) {
    Write-Host "    Assessment       : GOOD -- rarely produces invalid results (<= 5%)" -ForegroundColor Green
} elseif ($invalRate -le 15) {
    Write-Host "    Assessment       : MODERATE -- occasional invalid runs (5-15%)" -ForegroundColor Yellow
} else {
    Write-Host "    Assessment       : POOR -- frequent invalid runs (> 15%)" -ForegroundColor Red
}

# ---------------------------------------------------------------------------
# Metric 4: Regression Frequency
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "[4] Regression Frequency" -ForegroundColor White
$regressions = 0
$negPattern = '^-'
foreach ($r in $valid) {
    $d = $r.Delta
    if ($d -match $negPattern) { $regressions++ }
}
$regRate = if ($valid.Count -gt 0) { [Math]::Round(($regressions / $valid.Count) * 100, 1) } else { 0 }
Write-Host "    Valid runs       : $($valid.Count)"
Write-Host "    Regressions      : $regressions"
Write-Host "    Regression rate  : $regRate%"
if ($regRate -le 5) {
    Write-Host "    Assessment       : GOOD -- improvements are locked in (<= 5%)" -ForegroundColor Green
} elseif ($regRate -le 15) {
    Write-Host "    Assessment       : MODERATE -- some backsliding (5-15%)" -ForegroundColor Yellow
} else {
    Write-Host "    Assessment       : POOR -- frequent regressions (> 15%)" -ForegroundColor Red
}

# ---------------------------------------------------------------------------
# Metric 5: Model Diversity Index
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "[5] Model Diversity Index" -ForegroundColor White
$families = @{}
$stripPattern = '\s*\(.*\)\s*$'
$stripPattern2 = '\s*(xhigh|high)\s*$'
foreach ($r in $valid) {
    $family = $r.Model -replace $stripPattern, '' -replace $stripPattern2, ''
    $family = $family.Trim()
    if (-not $families.ContainsKey($family)) {
        $families[$family] = 0
    }
    $families[$family]++
}
$distinctFamilies = $families.Count
Write-Host "    Distinct model families : $distinctFamilies"
foreach ($f in ($families.GetEnumerator() | Sort-Object -Property Value -Descending)) {
    Write-Host "      $($f.Key): $($f.Value) runs"
}
if ($distinctFamilies -ge 5) {
    Write-Host "    Assessment       : GOOD -- high diversity (>= 5 families)" -ForegroundColor Green
} elseif ($distinctFamilies -ge 3) {
    Write-Host "    Assessment       : MODERATE -- some diversity (3-4 families)" -ForegroundColor Yellow
} else {
    Write-Host "    Assessment       : POOR -- low diversity (< 3 families)" -ForegroundColor Red
}

# ---------------------------------------------------------------------------
# Metric 6: Fix Durability (runs with positive delta / total valid runs)
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "[6] Fix Durability" -ForegroundColor White
$positive = 0
$neutral = 0
$neutralPattern1 = '^\+0\.0$'
$posPattern = '^\+'
foreach ($r in $valid) {
    $d = $r.Delta
    if ($d -match $neutralPattern1 -or $d -eq '0.0') { $neutral++ }
    elseif ($d -match $posPattern) { $positive++ }
}
$durability = if ($valid.Count -gt 0) { [Math]::Round(($positive / $valid.Count) * 100, 1) } else { 0 }
Write-Host "    Positive-delta runs  : $positive"
Write-Host "    Neutral-delta runs   : $neutral"
Write-Host "    Negative-delta runs  : $regressions"
Write-Host "    Durability           : $durability% of runs produced lasting improvement"

# ---------------------------------------------------------------------------
# Metric 7: Principle 3 Convergence Silence Counter (computed, not asserted)
# ---------------------------------------------------------------------------
# Walks SCORECARD rows backward from the most recent valid scored run.
# A run contributes to silence if TWO criteria are both met:
#   (1) delta is +0.0 (zero score change), AND
#   (2) the Result column contains the word "silence".
#
# Criterion (2) distinguishes genuine P3 silence runs from zero-delta action
# runs (e.g., CM fixes that leave scores unchanged). P3 requires zero artifact
# changes in addition to zero score delta; the "silence" keyword in the Result
# column is the SCORECARD-detectable proxy for zero artifact changes.
#
# Convention (see also Kata Step 5): silence SCORECARD entries must include
# the marker "(silence)" (in parentheses) in the Result column, e.g.,
# "Kaizen (silence). ...". Bare occurrences of the word without parentheses
# (e.g., "not a silence run") do NOT qualify. Zero-delta action runs that
# do NOT include the "(silence)" marker break the chain.
#
# Non-scoring rows (N/A delta) are skipped rather than treated as chain
# breakers, so external-target runs do not interrupt the silence chain.
# The chain is broken by any non-zero delta, invalidated row, or zero-delta
# row without the "silence" marker.
#
# This metric exists to detect drift between the asserted SCORECARD counter
# and the actual chain. Convergence cannot be self-narrated -- it must be
# derivable from the data.
Write-Host ""
Write-Host "[7] P3 Convergence Silence Counter" -ForegroundColor White
$silentChain = @()
$zeroDeltaPattern = '^\+?-?0(\.0+)?$'
# Walk backward through ALL rows (valid + invalidated). Skip non-scoring rows,
# but break on invalidation, non-zero scored delta, or zero-delta non-silence.
for ($i = $rows.Count - 1; $i -ge 0; $i--) {
    $r = $rows[$i]
    if ($r.Result -match $invalidPattern) { break }
    if ($r.Delta -eq 'N/A' -or $r.Delta -eq '') { continue }
    if ($r.Delta -notmatch $zeroDeltaPattern) { break }
    # Zero-delta action runs (CM fixes, sub-threshold housekeeping, etc.) that
    # are not explicitly marked 'silence' break the chain -- they are not P3
    # silence votes even though the score did not move.
    if ($r.Result -notmatch '^\s*\*\*[^*]+\(\s*(?i)silence') { break }
    $silentChain += $r
}
$silentRuns = $silentChain.Count
$silentFamilies = @{}
foreach ($r in $silentChain) {
    $family = $r.Model -replace $stripPattern, '' -replace $stripPattern2, ''
    $family = $family.Trim()
    $silentFamilies[$family] = $true
}
$silentDistinct = $silentFamilies.Count

# Parse asserted counter from SCORECARD
$assertedPattern = 'Principle 3 silence counter:\s*(\d+)/(\d+)'
$assertedRuns = $null
$assertedThreshold = 3
if ($scContent -match $assertedPattern) {
    $assertedRuns = [int]$Matches[1]
    $assertedThreshold = [int]$Matches[2]
}

Write-Host "    Computed silent chain : $silentRuns consecutive zero-delta runs"
Write-Host "    Distinct families     : $silentDistinct"
if ($null -ne $assertedRuns) {
    Write-Host "    Asserted counter      : $assertedRuns/$assertedThreshold (from SCORECARD)"
} else {
    Write-Host "    Asserted counter      : not found in SCORECARD"
}

$convergenceMet = ($silentRuns -ge $assertedThreshold) -and ($silentDistinct -ge $assertedThreshold)
if ($convergenceMet) {
    Write-Host "    Assessment            : CONVERGED -- $silentRuns silent runs, $silentDistinct distinct families" -ForegroundColor Green
} elseif ($silentRuns -eq 0) {
    Write-Host "    Assessment            : ACTIVE -- last run produced score change, counter at 0" -ForegroundColor Cyan
} else {
    Write-Host "    Assessment            : APPROACHING -- $silentRuns/$assertedThreshold silent runs, $silentDistinct/$assertedThreshold distinct families" -ForegroundColor Yellow
}

# Drift detection between asserted and computed
if ($null -ne $assertedRuns -and $assertedRuns -ne $silentRuns) {
    Write-Host "    *** DRIFT -- asserted $assertedRuns/$assertedThreshold but computed $silentRuns ***" -ForegroundColor Red
}

# ---------------------------------------------------------------------------
# Metric 8: Elapsed Time per Session
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "[8] Session Elapsed Time" -ForegroundColor White
$sessionsDir = Join-Path (Join-Path $script:suiteRoot 'TRAIL') 'sessions'
$sessionDurations = @()
if (Test-Path $sessionsDir) {
    $sessionFiles = Get-ChildItem $sessionsDir -Filter '*.md' -ErrorAction SilentlyContinue
    foreach ($sf in $sessionFiles) {
        $sfContent = Get-Content $sf.FullName -Raw -Encoding UTF8
        # Timestamps are in YAML frontmatter: started: and closed: fields
        $startMatch = [regex]::Match($sfContent, '(?m)^started:\s*(.+)')
        $closedMatch = [regex]::Match($sfContent, '(?m)^closed:\s*(.+)')
        if ($startMatch.Success -and $closedMatch.Success) {
            try {
                $startTime = [DateTimeOffset]::Parse($startMatch.Groups[1].Value.Trim())
                $closedTime = [DateTimeOffset]::Parse($closedMatch.Groups[1].Value.Trim())
                $elapsed = $closedTime - $startTime
                if ($elapsed.TotalMinutes -gt 0 -and $elapsed.TotalHours -lt 24) {
                    $sessionDurations += [PSCustomObject]@{
                        File     = $sf.Name
                        Minutes  = [Math]::Round($elapsed.TotalMinutes, 1)
                    }
                }
            } catch { }
        }
    }
}
if ($sessionDurations.Count -ge 1) {
    $avgMin = [Math]::Round(($sessionDurations | Measure-Object -Property Minutes -Average).Average, 1)
    $minMin = [Math]::Round(($sessionDurations | Measure-Object -Property Minutes -Minimum).Minimum, 1)
    $maxMin = [Math]::Round(($sessionDurations | Measure-Object -Property Minutes -Maximum).Maximum, 1)
    Write-Host "    Closed sessions  : $($sessionDurations.Count)"
    Write-Host "    Average duration : $avgMin min"
    Write-Host "    Range            : $minMin min to $maxMin min"
    if ($avgMin -le 15) {
        Write-Host "    Assessment       : GOOD -- sessions are fast (<= 15 min avg)" -ForegroundColor Green
    } elseif ($avgMin -le 30) {
        Write-Host "    Assessment       : MODERATE -- sessions are reasonable (15-30 min avg)" -ForegroundColor Yellow
    } else {
        Write-Host "    Assessment       : POOR -- sessions are slow (> 30 min avg)" -ForegroundColor Red
    }
} else {
    Write-Host "    No closed sessions with timestamps found"
}

# ---------------------------------------------------------------------------
# Metric 9: Transcript Size (proxy for effort/context cost)
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "[9] Transcript Size" -ForegroundColor White
if (Test-Path $sessionsDir) {
    $sessionSizes = @(Get-ChildItem $sessionsDir -Filter '*.md' -ErrorAction SilentlyContinue |
        Select-Object Name, @{N='KB'; E={[Math]::Round($_.Length / 1024, 1)}})
    if ($sessionSizes.Count -ge 1) {
        $avgKB = [Math]::Round(($sessionSizes | Measure-Object -Property KB -Average).Average, 1)
        $totalKB = [Math]::Round(($sessionSizes | Measure-Object -Property KB -Sum).Sum, 1)
        $maxSession = $sessionSizes | Sort-Object -Property KB -Descending | Select-Object -First 1
        Write-Host "    Total sessions   : $($sessionSizes.Count)"
        Write-Host "    Avg size         : $avgKB KB"
        Write-Host "    Total trail size : $totalKB KB"
        Write-Host "    Largest session  : $($maxSession.Name) ($($maxSession.KB) KB)"
        if ($avgKB -le 5) {
            Write-Host "    Assessment       : GOOD -- sessions are concise (<= 5 KB avg)" -ForegroundColor Green
        } elseif ($avgKB -le 10) {
            Write-Host "    Assessment       : MODERATE -- sessions are reasonable (5-10 KB avg)" -ForegroundColor Yellow
        } else {
            Write-Host "    Assessment       : POOR -- sessions are large (> 10 KB avg), review for bloat" -ForegroundColor Red
        }
    } else {
        Write-Host "    No session files found"
    }
} else {
    Write-Host "    TRAIL/sessions/ not found"
}

# ---------------------------------------------------------------------------
# Metric 10: GENBA Growth Rate
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "[10] GENBA Growth Rate" -ForegroundColor White
if (Test-Path $genbaPath) {
    $genbaSize = [Math]::Round((Get-Item $genbaPath).Length / 1024, 1)
    $genbaRunCount = @([regex]::Matches($gContent, '(?m)^##\s+Run\s+\d+')).Count
    $perRunKB = if ($genbaRunCount -gt 0) { [Math]::Round($genbaSize / $genbaRunCount, 1) } else { 0 }
    Write-Host "    Active GENBA     : $genbaSize KB ($genbaRunCount entries, $perRunKB KB/entry)"
    if (Test-Path $genbaArchivePath) {
        $archiveSize = [Math]::Round((Get-Item $genbaArchivePath).Length / 1024, 1)
        $archiveRunCount = @([regex]::Matches($gArchiveContent, '(?m)^##\s+Run\s+\d+')).Count
        $totalSize = [Math]::Round($genbaSize + $archiveSize, 1)
        $totalRuns2 = $genbaRunCount + $archiveRunCount
        Write-Host "    Archive GENBA    : $archiveSize KB ($archiveRunCount entries)"
        Write-Host "    Total (all time) : $totalSize KB ($totalRuns2 entries)"
    }
    if ($genbaSize -le 50) {
        Write-Host "    Assessment       : GOOD -- active GENBA is manageable (<= 50 KB)" -ForegroundColor Green
    } elseif ($genbaSize -le 100) {
        Write-Host "    Assessment       : MODERATE -- active GENBA is growing (50-100 KB), consider archival" -ForegroundColor Yellow
    } else {
        Write-Host "    Assessment       : POOR -- active GENBA exceeds 100 KB, archival recommended" -ForegroundColor Red
    }
} else {
    Write-Host "    TRAIL/GENBA.md not found"
}

# ---------------------------------------------------------------------------
# Metric 11: Reviewer Engagement
# ---------------------------------------------------------------------------
# Audit trails are necessary but not sufficient. Trust requires that someone
# actually reads them. This metric makes review activity observable so that
# non-engagement is at least visible. Parses TRAIL/SUMMARY.md for the
# "Human Review Checkpoint" block (checkbox state, last-reviewed date) and
# the "Review Log" table for total review history.
#
# Threshold rationale:
#   GOOD     : checkbox is [x] AND a Review Log row exists since the latest run
#   MODERATE : a review exists but is stale (>= 1 run behind, < 5 runs behind)
#   POOR     : no review ever recorded, or >= 5 runs behind the active ledger
Write-Host ""
Write-Host "[11] Reviewer Engagement" -ForegroundColor White
$summaryPath = Join-Path (Join-Path $script:suiteRoot 'TRAIL') 'SUMMARY.md'
if (Test-Path $summaryPath) {
    $sumContent = Get-Content $summaryPath -Raw -Encoding UTF8

    # Parse checkbox state under "## Human Review Checkpoint"
    $checkboxState = 'unknown'
    $checkpointBlock = [regex]::Match($sumContent, '(?ms)##\s+Human Review Checkpoint.*?(?=^##\s|\z)')
    if ($checkpointBlock.Success) {
        if ($checkpointBlock.Value -match '(?m)^\s*>\s*-\s*\[x\]\s*Yes') {
            $checkboxState = 'checked'
        } elseif ($checkpointBlock.Value -match '(?m)^\s*>\s*-\s*\[\s*\]\s*Yes') {
            $checkboxState = 'unchecked'
        }
    }

    # Parse "Last reviewed: YYYY-MM-DD" date
    $lastReviewedDate = $null
    $daysSinceReview = $null
    if ($checkpointBlock.Success -and $checkpointBlock.Value -match '(?m)Last reviewed:\s*(\d{4}-\d{2}-\d{2})') {
        try {
            $lastReviewedDate = [DateTime]::ParseExact($Matches[1], 'yyyy-MM-dd', $null)
            $daysSinceReview = [int]((Get-Date).Date - $lastReviewedDate).TotalDays
        } catch { }
    }

    # Parse Review Log table rows (skip placeholder "_none yet_")
    $reviewRows = @()
    $logBlock = [regex]::Match($sumContent, '(?ms)###\s+Review Log.*?(?=^---|\z)')
    if ($logBlock.Success) {
        foreach ($line in ($logBlock.Value -split "`r?`n")) {
            if ($line -match '^\|\s*(\d{4}-\d{2}-\d{2})\s*\|\s*([^|]+?)\s*\|\s*Run\s+(\d+)\s*\|') {
                $reviewRows += [PSCustomObject]@{
                    Date     = $Matches[1]
                    Reviewer = $Matches[2].Trim()
                    Run      = [int]$Matches[3]
                }
            }
        }
    }

    # Determine latest active-ledger run number
    $latestActiveRun = $null
    if (Test-Path $genbaPath) {
        $runMatches = [regex]::Matches($gContent, '(?m)^##\s+Run\s+(\d+)')
        if ($runMatches.Count -gt 0) {
            $latestActiveRun = ($runMatches | ForEach-Object { [int]$_.Groups[1].Value } | Measure-Object -Maximum).Maximum
        }
    }
    $latestReviewedRun = if ($reviewRows.Count -gt 0) { ($reviewRows | Measure-Object -Property Run -Maximum).Maximum } else { $null }
    $runsBehind = if ($null -ne $latestActiveRun -and $null -ne $latestReviewedRun) { $latestActiveRun - $latestReviewedRun } else { $null }

    Write-Host "    Checkpoint state  : $checkboxState"
    if ($null -ne $daysSinceReview) {
        Write-Host "    Last reviewed     : $($lastReviewedDate.ToString('yyyy-MM-dd')) ($daysSinceReview day(s) ago)"
    } else {
        Write-Host "    Last reviewed     : never"
    }
    Write-Host "    Review log rows   : $($reviewRows.Count)"
    if ($null -ne $latestActiveRun) {
        if ($null -ne $latestReviewedRun) {
            Write-Host "    Coverage          : last review = Run $latestReviewedRun, latest = Run $latestActiveRun ($runsBehind run(s) behind)"
        } else {
            Write-Host "    Coverage          : latest = Run $latestActiveRun, no review recorded"
        }
    }

    if ($checkboxState -eq 'checked' -and $null -ne $runsBehind -and $runsBehind -eq 0) {
        Write-Host "    Assessment        : GOOD -- trail acknowledged and review is current" -ForegroundColor Green
    } elseif ($checkboxState -eq 'checked' -and $null -ne $daysSinceReview -and $daysSinceReview -le 7 -and $reviewRows.Count -eq 0) {
        Write-Host "    Assessment        : GOOD -- checkpoint acknowledged ($daysSinceReview day(s) ago); populate Review Log in TRAIL/SUMMARY.md for full audit trail" -ForegroundColor Green
    } elseif ($null -ne $runsBehind -and $runsBehind -lt 5 -and $reviewRows.Count -gt 0) {
        Write-Host "    Assessment        : MODERATE -- review recorded but stale ($runsBehind run(s) behind)" -ForegroundColor Yellow
    } else {
        Write-Host "    Assessment        : POOR -- no current human review; trail risks accumulating into noise" -ForegroundColor Red
    }
} else {
    Write-Host "    TRAIL/SUMMARY.md not found -- cannot evaluate reviewer engagement"
}

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "=== Calibration Summary ===" -ForegroundColor Cyan

$assessments = @()
if ($numericStarts.Count -ge 2 -and $stddev -le 0.5) { $assessments += 'Agreement_GOOD' }
elseif ($numericStarts.Count -ge 2 -and $stddev -le 1.0) { $assessments += 'Agreement_MODERATE' }
elseif ($numericStarts.Count -ge 2) { $assessments += 'Agreement_POOR' }

if ($totalFindings -gt 0) {
    if ($recurrenceRate -le 10) { $assessments += 'Recurrence_GOOD' }
    elseif ($recurrenceRate -le 25) { $assessments += 'Recurrence_MODERATE' }
    else { $assessments += 'Recurrence_POOR' }
}

if ($invalRate -le 5) { $assessments += 'Invalidation_GOOD' }
elseif ($invalRate -le 15) { $assessments += 'Invalidation_MODERATE' }
else { $assessments += 'Invalidation_POOR' }

if ($regRate -le 5) { $assessments += 'Regression_GOOD' }
elseif ($regRate -le 15) { $assessments += 'Regression_MODERATE' }
else { $assessments += 'Regression_POOR' }

if ($distinctFamilies -ge 5) { $assessments += 'Diversity_GOOD' }
elseif ($distinctFamilies -ge 3) { $assessments += 'Diversity_MODERATE' }
else { $assessments += 'Diversity_POOR' }

$good = @($assessments | Where-Object { $_ -like '*_GOOD' }).Count
$moderate = @($assessments | Where-Object { $_ -like '*_MODERATE' }).Count
$poor = @($assessments | Where-Object { $_ -like '*_POOR' }).Count

Write-Host "  GOOD     : $good / $($assessments.Count)"
Write-Host "  MODERATE : $moderate / $($assessments.Count)"
Write-Host "  POOR     : $poor / $($assessments.Count)"

$overallStatus = 'WEAK'
if ($poor -eq 0 -and $moderate -le 1) {
    $overallStatus = 'HEALTHY'
    Write-Host ""
    Write-Host "  Overall calibration: HEALTHY" -ForegroundColor Green
} elseif ($poor -le 1) {
    $overallStatus = 'FAIR'
    Write-Host ""
    Write-Host "  Overall calibration: FAIR -- address the flagged areas" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "  Overall calibration: WEAK -- multiple metrics need attention" -ForegroundColor Red
}

# ---------------------------------------------------------------------------
# Metrics History -- DMAIC Control Phase: track metrics over time
# ---------------------------------------------------------------------------
$historyPath = Join-Path $script:suiteRoot 'METRICS_HISTORY.md'
$timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm'

# Build assessments lookup for compact storage
$agreeLabel = 'N/A'
if ($numericStarts.Count -ge 2) {
    if ($stddev -le 0.5) { $agreeLabel = 'GOOD' }
    elseif ($stddev -le 1.0) { $agreeLabel = 'MODERATE' }
    else { $agreeLabel = 'POOR' }
}
$recurLabel = 'N/A'
if ($totalFindings -gt 0) {
    if ($recurrenceRate -le 10) { $recurLabel = 'GOOD' }
    elseif ($recurrenceRate -le 25) { $recurLabel = 'MODERATE' }
    else { $recurLabel = 'POOR' }
}
$invalLabel = if ($invalRate -le 5) { 'GOOD' } elseif ($invalRate -le 15) { 'MODERATE' } else { 'POOR' }
$regLabel = if ($regRate -le 5) { 'GOOD' } elseif ($regRate -le 15) { 'MODERATE' } else { 'POOR' }
$divLabel = if ($distinctFamilies -ge 5) { 'GOOD' } elseif ($distinctFamilies -ge 3) { 'MODERATE' } else { 'POOR' }

$historyRow = "| $timestamp | $totalRuns | $([Math]::Round($stddev,2)) | $agreeLabel | $recurrenceRate% | $recurLabel | $invalRate% | $invalLabel | $regRate% | $regLabel | $distinctFamilies | $divLabel | $overallStatus |"

if (-not (Test-Path $historyPath)) {
    # Create history file with header
    $header = @"
# Metrics History -- DMAIC Control Phase

Tracks computable metrics across runs to detect trends and out-of-control conditions.
Each row is appended when ``metrics.ps1`` executes.

| Timestamp | Runs | Stdev | Agree | Recur% | Recur | Inval% | Inval | Regr% | Regr | Families | Divers | Overall |
|-----------|:----:|:-----:|:-----:|:------:|:-----:|:------:|:-----:|:-----:|:----:|:--------:|:------:|:-------:|
$historyRow
"@
    [System.IO.File]::WriteAllText($historyPath, $header, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host ""
    Write-Host "  History: created METRICS_HISTORY.md with first row" -ForegroundColor Cyan
} else {
    # Read existing, detect trends, append
    $existingContent = Get-Content $historyPath -Raw -Encoding UTF8

    # Parse last data row for trend detection
    $dataRowPattern = '(?m)^\|\s*[\d-]+\s+[\d:]+\s*\|'
    $dataRows = [regex]::Matches($existingContent, $dataRowPattern)
    $degraded = @()
    if ($dataRows.Count -gt 0) {
        $lastRow = $dataRows[$dataRows.Count - 1].Value
        # Extract previous assessments by position
        $cells = $lastRow -split '\|' | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }
        if ($cells.Count -ge 12) {
            $prevAgree = $cells[3]
            $prevRecur = $cells[5]
            $prevInval = $cells[7]
            $prevRegr  = $cells[9]
            $prevDiv   = $cells[11]

            $rankMap = @{ 'GOOD' = 3; 'MODERATE' = 2; 'POOR' = 1; 'N/A' = 0 }
            if ($rankMap[$agreeLabel] -lt $rankMap[$prevAgree]) { $degraded += "Agreement: $prevAgree -> $agreeLabel" }
            if ($rankMap[$recurLabel] -lt $rankMap[$prevRecur]) { $degraded += "Recurrence: $prevRecur -> $recurLabel" }
            if ($rankMap[$invalLabel] -lt $rankMap[$prevInval]) { $degraded += "Invalidation: $prevInval -> $invalLabel" }
            if ($rankMap[$regLabel] -lt $rankMap[$prevRegr])    { $degraded += "Regression: $prevRegr -> $regLabel" }
            if ($rankMap[$divLabel] -lt $rankMap[$prevDiv])     { $degraded += "Diversity: $prevDiv -> $divLabel" }
        }
    }

    # Append the new row
    $newContent = $existingContent.TrimEnd() + "`n" + $historyRow + "`n"
    [System.IO.File]::WriteAllText($historyPath, $newContent, (New-Object System.Text.UTF8Encoding($false)))

    $rowCount = $dataRows.Count + 1
    Write-Host ""
    Write-Host "  History: appended row $rowCount to METRICS_HISTORY.md" -ForegroundColor Cyan

    if ($degraded.Count -gt 0) {
        Write-Host ""
        Write-Host "  *** TREND ALERT -- Metric degradation detected ***" -ForegroundColor Red
        foreach ($d in $degraded) {
            Write-Host "    $d" -ForegroundColor Red
        }
    } else {
        Write-Host "  Trend: no degradation from previous snapshot" -ForegroundColor Green
    }
}

Write-Host ""
