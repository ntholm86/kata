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

# Extract rows by splitting pipe-delimited cells (robust against spaces in score fields)
$rows = @()
foreach ($line in ($scContent -split "`n")) {
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
# Parse TRAIL/GENBA.md for recurrence data
# ---------------------------------------------------------------------------
$genbaPath = Join-Path (Join-Path $script:suiteRoot 'TRAIL') 'GENBA.md'
$recurrenceCount = 0
$totalFindings = 0
if (Test-Path $genbaPath) {
    $gContent = Get-Content $genbaPath -Raw -Encoding UTF8
    # Count findings rows that have "Run N" in the Recurred? column (not "First")
    $findingPattern = '(?m)^\|\s*\d+\s*\|.*?\|\s*(First|Run \d+)\s*\|'
    $findingRows = [regex]::Matches($gContent, $findingPattern)
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
