<#
.SYNOPSIS
    Computable metrics for the TPS Skill Suite -- objective statistics derived
    from SCORECARD.md and GENBA.md ledger data.
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

# Extract rows: | N | date | model | start | end | delta | target | result |
$scorePattern = '(?m)^\|\s*(\d+)\s*\|\s*(\S+)\s*\|\s*(.+?)\s*\|\s*(\S+)\s*\|\s*(\S+)\s*\|\s*(\S+)\s*\|\s*(\S+)\s*\|\s*(.+?)\s*\|'
$rows = @()
foreach ($m in [regex]::Matches($scContent, $scorePattern)) {
    $rows += [PSCustomObject]@{
        Run        = [int]$m.Groups[1].Value
        Date       = $m.Groups[2].Value
        Model      = $m.Groups[3].Value.Trim()
        StartScore = $m.Groups[4].Value.Trim()
        EndScore   = $m.Groups[5].Value.Trim()
        Delta      = $m.Groups[6].Value.Trim()
        Target     = $m.Groups[7].Value.Trim()
        Result     = $m.Groups[8].Value.Trim()
    }
}

$totalRuns = $rows.Count
$invalidPattern = '\*\*Invalidated\*\*'
$invalidated = @($rows | Where-Object { $_.Result -match $invalidPattern })
$valid = @($rows | Where-Object { $_.Result -notmatch $invalidPattern })

# ---------------------------------------------------------------------------
# Parse GENBA.md for recurrence data
# ---------------------------------------------------------------------------
$genbaPath = Join-Path $script:suiteRoot 'GENBA.md'
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
    Write-Host "    No structured findings in GENBA.md"
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

if ($poor -eq 0 -and $moderate -le 1) {
    Write-Host ""
    Write-Host "  Overall calibration: HEALTHY" -ForegroundColor Green
} elseif ($poor -le 1) {
    Write-Host ""
    Write-Host "  Overall calibration: FAIR -- address the flagged areas" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "  Overall calibration: WEAK -- multiple metrics need attention" -ForegroundColor Red
}

Write-Host ""
