<#
.SYNOPSIS
    Close a Kiroku session. Updates session metadata, runs index rebuild, and prompts for summary update.
.PARAMETER SessionFile
    Path to the session file to close. If omitted, finds the most recent in-progress session.
.PARAMETER Project
    Path to the target project containing TRAIL/
.PARAMETER All
    Close all in-progress sessions (orphan cleanup).
#>
param(
    [string]$SessionFile,
    [string]$Project = (Get-Location).Path,
    [switch]$All
)

$sessionsDir = Join-Path (Join-Path $Project "TRAIL") "sessions"

# Find the session file(s)
if ($All) {
    $candidates = Get-ChildItem -Path $sessionsDir -Filter "*.md" -ErrorAction SilentlyContinue |
        Where-Object {
            $c = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
            $c -match 'status:\s*in-progress'
        }
    if (-not $candidates) {
        Write-Host "No in-progress sessions found."
        exit 0
    }
    $timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssK"
    $closed = 0
    foreach ($file in $candidates) {
        $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        $content = $content -replace 'status:\s*in-progress', "status: closed`nclosed: $timestamp"
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Closed: $($file.Name)"
        $closed++
    }
    Write-Host "`nClosed $closed orphaned session(s) at $timestamp"
    Write-Host "Rebuilding decision index..."
    & (Join-Path (Split-Path $PSCommandPath) "kiroku-index.ps1") -Project $Project
    exit 0
}

if (-not $SessionFile) {
    # Find the most recent in-progress session
    $candidates = Get-ChildItem -Path $sessionsDir -Filter "*.md" -ErrorAction SilentlyContinue |
        Where-Object {
            $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
            $content -match 'status:\s*in-progress'
        } |
        Sort-Object Name -Descending |
        Select-Object -First 1
    
    if (-not $candidates) {
        Write-Error "No in-progress session found in $sessionsDir"
        exit 1
    }
    $SessionFile = $candidates.FullName
}

if (-not (Test-Path $SessionFile)) {
    Write-Error "Session file not found: $SessionFile"
    exit 1
}

$timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssK"

# Update session metadata
$content = [System.IO.File]::ReadAllText($SessionFile, [System.Text.Encoding]::UTF8)
$content = $content -replace 'status:\s*in-progress', "status: closed`nclosed: $timestamp"
[System.IO.File]::WriteAllText($SessionFile, $content, [System.Text.Encoding]::UTF8)

Write-Host "Session closed: $(Split-Path $SessionFile -Leaf)"
Write-Host "Closed at: $timestamp"

# Count decisions in this session
$decisionCount = ([regex]::Matches($content, '\[!DECISION\]')).Count
$realizationCount = ([regex]::Matches($content, '\[!REALIZATION\]')).Count
$reversalCount = ([regex]::Matches($content, '\[!REVERSAL\]')).Count

Write-Host ""
Write-Host "Session stats:"
Write-Host "  Decisions:    $decisionCount"
Write-Host "  Realizations: $realizationCount"
Write-Host "  Reversals:    $reversalCount"

# Rebuild index
Write-Host ""
Write-Host "Rebuilding decision index..."
& (Join-Path (Split-Path $PSCommandPath) "kiroku-index.ps1") -Project $Project

# Remind about summary
Write-Host ""
Write-Host "REMINDER: Update TRAIL/SUMMARY.md with:"
Write-Host "  - Current one-line status"
Write-Host "  - Last 3-5 decisions"
Write-Host "  - Any integrity notes"
