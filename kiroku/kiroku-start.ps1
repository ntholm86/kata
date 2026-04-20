<#
.SYNOPSIS
    Start a new Kiroku session. Creates a session transcript file with metadata header.
.PARAMETER Slug
    Short identifier for the session (e.g., "measurement-redesign", "skills-rebuild")
.PARAMETER Project
    Path to the target project. Trail goes into $Project/TRAIL/sessions/
    Defaults to current directory.
.PARAMETER Participants
    Comma-separated list of participants (e.g., "human, Claude Opus 4.6")
.PARAMETER Fidelity
    Expected fidelity level: verbatim, reconstructed, mixed. Default: reconstructed
.EXAMPLE
    .\kiroku-start.ps1 -Slug "measurement-redesign" -Project "C:\Users\admin\.copilot\skills" -Participants "human, Claude Opus 4.6"
#>
param(
    [Parameter(Mandatory)]
    [string]$Slug,
    
    [string]$Project = (Get-Location).Path,
    
    [string]$Participants = "human, Claude Opus 4.6",
    
    [ValidateSet("verbatim", "reconstructed", "mixed")]
    [string]$Fidelity = "reconstructed"
)

$date = Get-Date -Format "yyyy-MM-dd"
$timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssK"
$filename = "$date-$Slug.md"
$trailDir = Join-Path (Join-Path $Project "TRAIL") "sessions"

# Create directory if needed
if (-not (Test-Path $trailDir)) {
    New-Item -ItemType Directory -Path $trailDir -Force | Out-Null
    Write-Host "Created TRAIL/sessions/ in $Project"
}

# Create TRAIL/README.md on first use (observer entry point)
$trailRoot = Join-Path $Project "TRAIL"
$readmePath = Join-Path $trailRoot "README.md"
if (-not (Test-Path $readmePath)) {
    $projectName = Split-Path $Project -Leaf
    $readmeContent = @"
# Audit Trail: $projectName

This directory contains the complete audit trail for autonomous agent operations on this project.

## How to read this

| Time budget | Start here |
|---|---|
| 30 seconds | **SUMMARY.md** - direction, recent decisions, current state |
| 5 minutes | **GENBA.md** - per-run evidence: what was found, what was done, what changed |
| 15 minutes | **INDEX.md** - every decision with rationale, linked to the session that produced it |
| Full review | **sessions/** - complete reasoning transcripts |

## What each file is

- **SUMMARY.md** - Cross-run executive digest. Updated after each run. Answers: *where is this project headed?*
- **GENBA.md** - Run ledger. One entry per autonomous operation, newest first. Answers: *what happened in each run?*
- **INDEX.md** - Decision index (auto-generated). Every ``[!DECISION]`` from sessions, extracted with rationale. Answers: *what was decided and why?*
- **sessions/** - Full session transcripts. The ground truth. Answers: *what was the agent's complete reasoning?*

## Glossary

- **Kata** - The orchestration skill that runs an improvement cycle: diagnose the target, select a methodology, execute, record, persist.
- **Kaizen** - Incremental improvement. The target's structure is sound; specific things need fixing.
- **Kaikaku** - Radical redesign. The target's structure cannot reach its goals through incremental changes.
- **Hansei** - Reflection on the improvement loop itself, not the target.
- **GENBA** - The place where actual work happens (Japanese: the real place). Here: the ledger of what actually occurred.

## Fidelity levels

Session transcripts are marked with a fidelity level:

- **verbatim** - Exported directly from the chat platform. Exact dialogue preserved. Highest trust.
- **reconstructed** - Recreated from agent context/memory. Captures decisions, reasoning, and outcomes accurately, but exact wording may differ from the original exchange. Typical accuracy: key facts and decisions are reliable; phrasing and sequence may be approximate.
- **mixed** - Contains both verbatim tool outputs and reconstructed narrative.

## Integrity

All summaries and digests in this trail are self-authored by the agent that produced the work. Cross-verify claims against the session transcripts and the actual code changes (git log) for independent confirmation.
"@
    [System.IO.File]::WriteAllText($readmePath, $readmeContent, [System.Text.Encoding]::UTF8)
    Write-Host "Created TRAIL/README.md (observer entry point)"
}

$filepath = Join-Path $trailDir $filename

if (Test-Path $filepath) {
    Write-Warning "Session file already exists: $filepath"
    Write-Host "Use kiroku-decision.ps1 to add entries, or choose a different slug."
    exit 1
}

# Create session file with YAML frontmatter
$content = @"
---
fidelity: $Fidelity
source: agent-memory
date: $date
started: $timestamp
participants: [$Participants]
session-id: $(New-Guid)
project: $Project
status: in-progress
---

# Session: $Slug

**Started:** $timestamp
**Participants:** $Participants
**Fidelity:** $Fidelity - exchanges are captured from agent context, not verbatim platform export.

## Trigger

<!-- What initiated this session? What Intent or goal? -->

## Exchange Log

<!-- The agent maintains this section during the session.
     Mark decisions with [!DECISION], realizations with [!REALIZATION], reversals with [!REVERSAL].
     Include tool calls and results where they constitute evidence. -->

"@

# Write with explicit UTF-8 encoding
[System.IO.File]::WriteAllText($filepath, $content, [System.Text.Encoding]::UTF8)

Write-Host "Session started: $filepath"
Write-Host "Session ID: $(Split-Path $filepath -Leaf)"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  - Fill in the Trigger section"
Write-Host "  - Maintain the Exchange Log during the session"  
Write-Host "  - Run kiroku-close.ps1 when done"
