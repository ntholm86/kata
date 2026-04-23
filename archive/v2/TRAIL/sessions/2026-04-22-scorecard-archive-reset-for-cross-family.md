---
fidelity: reconstructed
source: agent-memory
date: 2026-04-22
started: 2026-04-22T06:52:16+02:00
participants: [human, Claude Opus 4.6]
session-id: 492b6e85-ccf3-4ff8-b09c-41d4df02d471
project: C:\Users\admin\.copilot\skills
status: closed
closed: 2026-04-22T06:55:24+02:00
---

# Session: scorecard-archive-reset-for-cross-family

**Started:** 2026-04-22T06:52:16+02:00
**Participants:** human, Claude Opus 4.6
**Fidelity:** reconstructed - exchanges are captured from agent context, not verbatim platform export.

## Trigger

User asked, after v2.11.0 shipped: *"Should the scoreboard be retired for this? — or archived/reset (we don't want to lose history) but we want the new mechanism in play to run without the previous declared derived measurements impact."*

## Intent

**Human intent (verbatim):** *"we want the new mechanism in play to run without the previous declared derived measurements impact"* — combined with explicit non-loss of history.

**Agent interpretation:** The v2.11.0 additive consolidation protocol just shipped but has never been exercised. The Rubric Provenance ledger has six rows all attributed to one family (Claude, Run 87) — a single-family anchor laid before the protocol existed. If the next evaluator reads a fully-populated SCORECARD during Grasp, the cold-derivation hygiene cannot bite, and the consolidation outcome is structurally biased toward `convergent (no addition)`. The user wants the next evaluator to operate without that anchor while preserving the work as archive.

**Scope & constraints:**
- Apply to the TPS skill suite SCORECARD only (not the manifesto SCORECARD — that has only Runs 1–3 of v4 history and is a separate target with its own derivation context).
- Preserve all pre-reset content verbatim in a TRAIL archive file.
- No skill behavior changes (skills stay at v2.11.0).
- Do not edit verify-suite.ps1 — use the existing `**Invalidated**` row marker so the per-run-coverage check handles archived runs gracefully.

## Exchange Log

### Step 0 — Acknowledge protocol

[!DECISION] DEC-001: SCORECARD reset on TPS skill suite only; manifesto SCORECARD untouched this run. Rationale: skill suite is the immediate target where v2.11.0 was just shipped and the single-family anchor is largest (6 rows by Claude). Manifesto's v4 has only 3 runs and may benefit from direct score continuity through Run 4; reset there is a separate decision the user can call later.

### Step 1 — Grasp

Read live SCORECARD.md (143 lines, 13.5 KB). Confirmed contents: header + scheme rationale + Rubric Provenance (6 Claude rows) + Rubric v4 dimensions + Run Ledger (Runs 87, 88) + Dimension Trajectory + Run 87 scoring rationale + hand-off section.

Read verify-suite.ps1 SCORECARD-related checks. Confirmed:
- Check 5 (line 184) compares GENBA run count to SCORECARD-tracked rows; already a `Warn` not `Fail`; tolerates `**Invalidated**` rows via `$invalidatedRows` counter.
- Check 12 (line 454) checks SCORECARD rows → GENBA; uses `Get-ScorecardRunRows` which filters out `**Invalidated**` rows (line 469).

[!REALIZATION] REAL-001: The `**Invalidated**` row marker convention already exists in verify-suite for exactly this situation. No script changes are needed — marking Runs 87 & 88 as `**Invalidated**` in the live ledger keeps both checks green while the archive holds the actual content.

### Step 2 — Diagnose

The single-family-anchor problem has three components:

1. **Rubric definitions present** in live SCORECARD → next evaluator reads them during Grasp → derivation is contaminated.
2. **Provenance table populated by one family** → "additive consolidation" with one prior contributor structurally invites convergent-no-addition (cheapest outcome).
3. **Score history under that rubric** → comparability gravity pulls next run toward scoring against the same dimensions.

All three must be removed from the live file simultaneously; partial reset (e.g., empty Provenance but keep Rubric section) leaves the anchor in place.

### Step 3 — Decide

[!DECISION] DEC-002: Move full pre-reset content (rubric definitions + Provenance + Run Ledger entries + Dimension Trajectory + scoring rationales) verbatim to `TRAIL/SCORECARD_ARCHIVE_v4_pre-protocol.md`. Prepend an archive header explaining the reset. Live SCORECARD becomes a stub: header, reset notice, archive pointer, empty Provenance table, empty Rubric section, Run Ledger with Runs 87 & 88 marked `**Invalidated**`, hand-off pointing to Run 89 with cold-derivation requirement.

[!DECISION] DEC-003: Version bump is patch (v2.11.0 → v2.11.1). Rationale: skills are unchanged; the reset is a state-of-the-suite change. v2.11.0's mechanism is what enables this reset to be coherent; this run stages it for first use. Skill SKILL.md files do NOT bump (they stay at 2.11.0).

### Step 4 — Design

Edits required:
1. Copy live SCORECARD.md → TRAIL/SCORECARD_ARCHIVE_v4_pre-protocol.md (verbatim).
2. Prepend archive header to the archive file (reset rationale + archive purpose + pointer back to live).
3. Rewrite live SCORECARD.md as stub.
4. CHANGELOG.md gets [2.11.1] entry explaining the reset, the no-skill-version-bump rationale, and the patch-vs-major reasoning.
5. Update TRAIL/SUMMARY.md.
6. Run verify-suite + kiroku-validate.
7. Close session, commit, tag v2.11.1.

### Step 5 — Execute

Done in order:
- Archive copy: `Copy-Item SCORECARD.md TRAIL/SCORECARD_ARCHIVE_v4_pre-protocol.md` (13554 bytes preserved).
- Archive header prepended (reset notice + purpose + back-pointer).
- Live SCORECARD removed and rewritten as stub: empty Provenance table, empty Rubric section, Runs 87 & 88 marked `**Invalidated**` with archive pointers, hand-off section requires distinct evaluator family for Run 89.
- CHANGELOG.md [2.11.1] entry added between [Unreleased] and [2.11.0].

### Step 6 — Validate (in progress)

Will run verify-suite and kiroku-validate next.

## Outcome

Pending validation + commit. Expected: 0 verify-suite failures, 0 kiroku-validate failures, v2.11.1 tagged.

## Marker conventions

- `[!DECISION]` — irreversible-ish choices (3 in this session)
- `[!REALIZATION]` — insight that changed the plan (1 in this session)
- `[!REVERSAL]` — none in this session
     Include tool calls and results where they constitute evidence. -->
