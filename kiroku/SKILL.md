---
name: kiroku
version: 1.0.0
description: 'Evidence trail management. Start sessions, record decisions during work, close sessions, index decisions, validate trail integrity. The implementation of Observable Autonomy (Principle 2). USE WHEN: start session, record trail, kiroku, audit trail, evidence, close session, validate trail, begin work, observable autonomy, track decisions.'
argument-hint: 'Specify the target project path where TRAIL/ should be managed'
---

# Kiroku

*The record of what actually happened.*

Kiroku (記録, Japanese: record/documentation) manages the evidence trail that makes autonomous work observable. It is the implementation layer for Principle 2 (Observable Autonomy) — the mechanism by which an agent earns the right to keep acting.

## When to use this

Every session where an agent does substantive work on a target project. If the work produces decisions, changes, or findings, it must produce a trail. No run is invisible.

This includes:
- External runs on target projects (kata, kaizen, kaikaku)
- Design conversations that produce architectural decisions
- Hansei reflections that change the improvement process itself

## Target Resolution

The trail belongs to the target repository, not to the mechanism that invoked kiroku.

- Direct VS Code work on repository `X` writes to `X/TRAIL/`
- Kata targeting repository `X` writes to `X/TRAIL/`
- Self-targeting the skills suite writes to `skills/TRAIL/`

If direct chat work and Kata both act on the same repository during the same period, they share one trail. The session transcript records who initiated the work; the audit trail location is still keyed by the target repository.

## The scripts

Four PowerShell scripts in this folder manage the trail lifecycle:

### `kiroku-start.ps1` — Begin a session

```powershell
.\kiroku-start.ps1 -Slug "fix-parser-precedence" -Project "C:\git\mathkit" -Fidelity reconstructed
```

Creates `TRAIL/sessions/YYYY-MM-DD-{slug}.md` with YAML frontmatter (fidelity, participants, session ID). On first use in a project, also creates `TRAIL/README.md` as the observer entry point.

**Parameters:**
- `-Slug` (required): Short identifier for the session
- `-Project`: Target project path (default: current directory)
- `-Participants`: Who's involved (default: "human, Claude Opus 4.6")
- `-Fidelity`: verbatim | reconstructed | mixed (default: reconstructed)

### `kiroku-close.ps1` — End a session

```powershell
.\kiroku-close.ps1 -Project "C:\git\mathkit"
```

Updates session status to `completed`, adds timestamp, counts decision/realization/reversal markers, rebuilds INDEX.md, and reminds about SUMMARY.md update.

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
7. Decision recording quality (no sparse rationale)

## The TRAIL/ structure

```
target-project/
  TRAIL/
    README.md    — Observer entry point (auto-created on first session)
    SUMMARY.md   — Cross-run executive digest (agent-maintained)
    GENBA.md     — Per-run evidence ledger (agent-maintained)
    INDEX.md     — Decision index (auto-generated from session markers)
    sessions/    — Full session transcripts (one per kiroku session)
```

### Multi-resolution evidence

This structure implements the three evidence resolutions required by Principle 2:

| Resolution | Artifact | Observer time budget |
|---|---|---|
| **Digested** | SUMMARY.md | 30 seconds |
| **Indexed** | TRAIL/INDEX.md + TRAIL/GENBA.md | 5-15 minutes |
| **Full** | sessions/ transcripts | Unlimited |

## During a session

### Intent (required — fill before starting work)

The session template includes an **Intent** section between Trigger and Exchange Log. The agent must fill this before proceeding to work. It has three parts:

- **Human intent (verbatim):** What the human actually said. Quote directly. This is the ground truth that an observer uses to judge whether the agent's work was responsive.
- **Agent interpretation:** How the agent parsed that request into a concrete plan. What assumptions were made? What ambiguities were resolved and how?
- **Scope & constraints:** Boundaries stated by the human ("don't touch config", "make a backup", "this is production") plus any unstated constraints the agent inferred.

The Intent section answers the question no other artifact can: *was the work that was done actually what was asked for?*

### Markers

While working, the agent maintains the session transcript by recording:

- **`[!DECISION]`** — A choice that could have gone differently. Include rationale and alternatives on the following lines.
- **`[!REALIZATION]`** — Something discovered during the work that changed understanding.
- **`[!REVERSAL]`** — A decision that was made and then undone. These are more valuable than decisions — they show the reasoning evolved.

```markdown
[!DECISION] Move GENBA.md into TRAIL/ directory
Rationale: GENBA is evidence, not a project-level artifact. It belongs with the rest of the trail.
Alternatives: Keep at root (rejected — inconsistent with TRAIL/ being the single evidence location).

[!REALIZATION] The debug log captures zero conversation content — only session_start metadata.

[!REVERSAL] Initially recommended kiroku as tooling, not a skill. Reversed after recognizing it has 
a "when" (every session) and a "how" (the scripts), which qualifies it as an evidence management skill.
```

## Fidelity honesty

The platform (VS Code Copilot Chat) does not expose an API for exporting conversation transcripts. All session content is therefore at **reconstructed** fidelity unless tool outputs are pasted verbatim.

This is an honest constraint, not a defect. The SKILL.md, the session template, and the README all mark this explicitly. An observer reading the trail knows exactly what they're looking at.

## After a session

1. Run `kiroku-close.ps1` to finalize the session
2. Update `TRAIL/SUMMARY.md` with current status
3. Update `TRAIL/GENBA.md` with a run entry
4. Run `kiroku-validate.ps1` to check consistency
5. Commit the TRAIL/ changes alongside any code changes
