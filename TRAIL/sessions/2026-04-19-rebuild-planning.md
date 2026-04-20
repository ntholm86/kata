---
fidelity: reconstructed
source: agent-memory
date: 2026-04-19
started: 2026-04-19T17:10:16+02:00
participants: [human, Claude Opus 4.6]
session-id: 2f320071-1d52-475b-a931-e71049512b25
project: C:\Users\admin\.copilot\skills
status: closed
---

# Session: rebuild-planning

**Started:** 2026-04-19T17:10:16+02:00
**Participants:** human, Claude Opus 4.6
**Fidelity:** reconstructed - exchanges are captured from agent context, not verbatim platform export.

## Trigger

User directive: "Make Kiroku real (tooling, not just convention). Design measurement that a human stakeholder would recognize as meaningful. Let the system rebuild itself from the Principles alone, with full trail, under correct measurement."

Context: After 46 Kata runs on the TPS Skill Suite (v1.34.0), the user recognized that (1) the skills accumulated prescriptive drift from iterative patching, (2) Kiroku exists as convention but has no tooling, (3) the rubric measures skill quality but not whether the skills produce useful work, and (4) starting over is cheaper than archaeological repair. The dependency chain is: Kiroku tooling -> measurement redesign -> skills rebuild from Principles.

See also: Kiroku INTENT.md, PRINCIPLES.md, PROBLEM.md

## Exchange Log

### Part 1: Kiroku Tooling Built

Created four PowerShell scripts in c:\git\kiroku\:
- `kiroku-start.ps1` - creates session files with YAML frontmatter (fidelity, participants, status)
- `kiroku-index.ps1` - scans session files for [!DECISION] markers, rebuilds INDEX.md
- `kiroku-close.ps1` - marks session complete, triggers index rebuild
- `kiroku-validate.ps1` - 6 checks for three-layer consistency

Created `AGENT_PROTOCOL.md` - tells agents how to maintain trails during work.

Fixed PowerShell 5.1 compatibility (Join-Path doesn't accept 3+ arguments).

[!DECISION] Kiroku tooling is PowerShell scripts + agent protocol, not a VS Code extension or Python package.
Rationale: Target environment is Windows with PowerShell 5.1. No dependency installation. Scripts handle mechanical validation; the agent handles capture. The agent IS the primary tool - scripts support it.
Alternatives: VS Code extension (requires extension development, violates INTENT constraint), Python CLI (requires venv management), manual-only convention (current state, proven insufficient)

### Part 2: Measurement Redesign

The current Rubric v3 measures skill quality (process completeness, causal analysis, instruction clarity, etc.). These are input metrics - they measure whether the skills are well-written, not whether they produce good work.

A human stakeholder asks different questions:
1. "Did the agent produce better work using these skills than without them?"
2. "Could I hand this to a different team/model and get similar results?"
3. "Can I see what happened and why?"
4. "Did it stop when it should have?"

[!REALIZATION] The rubric measures the recipe, not the meal. A perfectly scored skill set that nobody can use and that produces mediocre output is a perfectly measured failure.

[!DECISION] Split measurement into two tiers: Skill Quality (input) and Work Quality (output). Rubric v3 becomes the input tier. A new output tier measures what matters to stakeholders.
Rationale: You need both. Input quality (are the skills well-written?) prevents garbage-in. Output quality (does work done under these skills actually succeed?) prevents vanity metrics. Neither is sufficient alone. The current system has only input metrics.
Alternatives: Replace rubric v3 entirely (loses 46 runs of calibration data), keep rubric v3 only (perpetuates the blind spot), merge into one rubric (conflates different measurement targets)

Created MEASUREMENT.md with:
- Tier 1 (Skill Quality) = existing Rubric v3, kept as-is
- Tier 2 (Work Quality) = 5 new output dimensions (Transferability, External Target Efficacy, Reasoning vs. Compliance, Observer Satisfaction, Time to Value)
- Pass/fail scoring for Tier 2 to avoid ad-hoc 1-10 scoring
- Current state assessment: strong Tier 1, zero validated Tier 2

[!DECISION] Use pass/fail for Tier 2 (output metrics), not 1-10 scales.
Rationale: The v1/v2 rubric proved that 1-10 scales invite ad-hoc scoring that converges to the ceiling without meaning. Pass/fail forces binary evidence: the work succeeded or it didn't.
Alternatives: 1-10 scale (same failure mode as v1/v2), 3-point scale (marginal improvement over binary, adds complexity without clarity)

### Part 3: Skills Rebuild Intent

Created REBUILD_INTENT.md - Commander's Intent for the skills rebuild.

Key decisions embedded in the Intent:

[!DECISION] The system determines what skills exist, not the human. The rebuild starts from PRINCIPLES.md and PROBLEM.md only.
Rationale: The current 8-skill structure was invented by one model in one session. The number and nature of skills should be derived from what the Principles require, not from what happened to be created on day one.
Alternatives: Prescribe the same 8 skills with cleaner content (perpetuates the structure problem), let the human specify which skills (violates Commander's Intent)

[!DECISION] No human edits to skill files. All changes through Intents.
Rationale: This makes the audit trail honest - every change has a traceable origin. It also enforces Commander's Intent: the human defines what, the system determines how.
Alternatives: Human edits with trail documentation (partial audit trail, mixed authorship), collaborative editing (muddies the P1 test)

[!DECISION] Existing v1.34.0 is reference material, not a template. No copy-paste.
Rationale: The goal is to test whether fresh reasoning from Principles produces the same, different, or better skills than 44 runs of iterative patching. Copy-pasting would defeat the experiment.
Alternatives: Start from v1.34.0 and simplify (incremental, not a rebuild), ignore v1.34.0 entirely (loses lessons learned)

## Session Summary

- Decisions made: 6
- Key outcomes: Kiroku tooling built (4 scripts + agent protocol), Measurement framework designed (Tier 1 + Tier 2), Rebuild Intent written
- Open items: Execute the rebuild (separate session), commit Kiroku tooling, commit skills repo changes
- Status: Ready to execute. Kiroku captures. Measurement defines success. Intent defines the destination.
