---
name: kiroku
version: 2.0.0
description: 'Evidence trail management. Start sessions, record decisions during work, close sessions, index decisions, validate trail integrity. The implementation of Observable Autonomy (Principle 2). USE WHEN: start session, record trail, kiroku, audit trail, evidence, close session, validate trail, begin work, observable autonomy, track decisions.'
argument-hint: 'Specify the target project path where TRAIL/ should be managed'
---

# Kiroku

*The record of what actually happened.*

Kiroku (記録, Japanese: record/documentation) manages the evidence trail that makes autonomous work observable. It is the implementation layer for Principle 2 (Observable Autonomy).

## Why this exists

Autonomy without evidence is not delegation — it is abdication. When an agent (human or AI) does work autonomously, the question is never "did it do something?" but "can someone who wasn't there reconstruct what happened, why, and whether to trust it?"

A trail that answers this question earns the right to more autonomy. A trail that doesn't answer it — or doesn't exist — means autonomy must be constrained regardless of how competent the work was.

This is the core dependency:

```
Evidence → Trust → Autonomy
```

More evidence → more trust → more autonomy earned. Less evidence → trust decays → autonomy must be constrained. Zero evidence → zero trust → autonomy must be revoked.

## What good evidence looks like

### Multi-resolution

Not everyone has the same time budget. A 50-page transcript is unreadable to the person with 2 minutes. A 1-paragraph summary is insufficient for the person with an afternoon. Good evidence exists at multiple resolutions simultaneously:

| Resolution | What it answers | Time budget |
|---|---|---|
| **Digested** | Where are we? What just happened? Should I be concerned? | 30 seconds |
| **Indexed** | What decisions were made? What was the reasoning? What changed? | 5–15 minutes |
| **Full** | What exactly happened, step by step? | Unlimited |

A single-resolution trail satisfies one observer while silently excluding the rest. That exclusion violates the principle even when the trail itself is honest.

### Honest about its own limitations

Evidence has a fidelity level. A verbatim tool output and a reconstructed-from-memory summary are both evidence, but they are different trust levels. Conflating them is dishonest. The trail must mark its fidelity explicitly so observers can calibrate their trust.

Where the agent authors its own summary, this must be marked. A summary written by the audited party is evidence, but it is not independent evidence.

### Records reasoning, not just results

"Removed 1 file" is a result. "Removed `utils/helpers.py` because no module imports it and its tests are orphaned" is reasoning. The *why* is what makes the action observable and challengeable. Without it, an observer can see what happened but cannot judge whether it was correct.

Three markers capture the most valuable moments in autonomous reasoning:

- **`[!DECISION]`** — A choice that could have gone differently. Always include rationale and alternatives considered.
- **`[!REALIZATION]`** — Something discovered during the work that changed understanding.
- **`[!REVERSAL]`** — A decision that was made and then undone. Reversals are more valuable than decisions — they show the reasoning evolved.

```markdown
[!DECISION] Move GENBA.md into TRAIL/ directory
Rationale: GENBA is evidence, not a project-level artifact. It belongs with the rest of the trail.
Alternatives: Keep at root (rejected — inconsistent with TRAIL/ being the single evidence location).

[!REALIZATION] The debug log captures zero conversation content — only session_start metadata.

[!REVERSAL] Initially recommended kiroku as tooling, not a skill. Reversed after recognizing it has
a "when" (every session) and a "how" (the scripts), which qualifies it as a skill.
```

### Traces intent

The most important question a trail can answer is: *was the work that was done actually what was asked for?* Every session captures intent before work begins:

- **Human intent (verbatim):** What was actually asked for. Quote directly.
- **Agent interpretation:** How that request was parsed into a plan. What assumptions were made.
- **Scope & constraints:** Boundaries stated or inferred.

## The trail structure

Every target project gets one `TRAIL/` directory. All evidence lives there:

```
target-project/
  TRAIL/
    README.md    — Observer entry point (what is this, how to read it)
    SUMMARY.md   — Cross-run executive digest (digested resolution)
    GENBA.md     — Per-run evidence ledger (indexed resolution)
    INDEX.md     — Decision index, auto-generated (indexed resolution)
    sessions/    — Full session transcripts (full resolution)
```

The observer looks at one directory. Everything is there.

## When to use this

Every session where substantive work happens on a target. If the work produces decisions, changes, or findings, it produces a trail. No run is invisible.

This includes:
- Improvement runs on target projects (kata, kaizen, kaikaku)
- Design conversations that produce architectural decisions
- Reflections that change the improvement process itself

## Target resolution

The trail belongs to the **target**, not to the mechanism that invoked kiroku.

- Work on repository `X` → writes to `X/TRAIL/`
- Kata targeting repository `X` → writes to `X/TRAIL/`
- Self-targeting the skills suite → writes to `skills/TRAIL/`

If different activities target the same repository, they share one trail. The session records who initiated the work; the trail location is keyed by the target.

## The scripts

Four PowerShell scripts manage the trail lifecycle:

### `kiroku-start.ps1` — Begin a session

```powershell
.\kiroku-start.ps1 -Slug "fix-parser-precedence" -Project "C:\git\mathkit" -Fidelity reconstructed
```

Creates `TRAIL/sessions/YYYY-MM-DD-{slug}.md` with YAML frontmatter. On first use in a project, also creates `TRAIL/README.md` as the observer entry point.

**Parameters:**
- `-Slug` (required): Short identifier for the session
- `-Project`: Target project path (default: current directory)
- `-Participants`: Who's involved (default: "human, Claude Opus 4.6")
- `-Fidelity`: verbatim | reconstructed | mixed (default: reconstructed)

### `kiroku-close.ps1` — End a session

```powershell
.\kiroku-close.ps1 -Project "C:\git\mathkit"
```

Updates session status to `closed`, adds timestamp, counts markers, rebuilds INDEX.md. Use `-All` to close all orphaned in-progress sessions at once:

```powershell
.\kiroku-close.ps1 -Project "C:\git\mathkit" -All
```

### `kiroku-index.ps1` — Rebuild the decision index

```powershell
.\kiroku-index.ps1 -Project "C:\git\mathkit"
```

Scans all session files for `[!DECISION]` markers. Extracts decision text, rationale, and alternatives. Generates `TRAIL/INDEX.md`. Preserves manually-maintained retroactive entries (DEC-R prefix).

### `kiroku-validate.ps1` — Check trail consistency

```powershell
.\kiroku-validate.ps1 -Project "C:\git\mathkit"
```

Validates 7 checks:
1. Trail structure (SUMMARY, INDEX, sessions/, GENBA, README exist)
2. Session fidelity headers present
3. Decision count consistency (sessions vs INDEX)
4. Summary freshness and self-authorship warning
5. No unclosed sessions (except current)
6. Fidelity honesty (verbatim claims have verbatim markers)
7. Decision recording quality (rationale present on decisions)

## Fidelity honesty

VS Code Copilot Chat does not expose an API for exporting conversation transcripts. All session content is at **reconstructed** fidelity unless tool outputs are pasted verbatim. This is an honest constraint, not a defect. The session template, SKILL.md, and README all mark this explicitly.

## After a session

1. Run `kiroku-close.ps1` to finalize the session
2. Update `TRAIL/SUMMARY.md` with current status
3. Update `TRAIL/GENBA.md` with a run entry
4. Run `kiroku-validate.ps1` to check consistency
5. Commit the TRAIL/ changes alongside any code changes
