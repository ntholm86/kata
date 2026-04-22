# Design Backlog

Parked design ideas for the skills suite. Not commitments. Each entry records the idea, the problem it would address, the open questions, and explicitly that it is **unscored, untested, and not adopted**.

Entries here are *implementation-layer* candidates. Manifesto-level changes belong in `c:\git\manifesto`, not here.

---

## DB-001 — Standardized per-phase artifacts

**Status:** Parked (recorded 2026-04-22). Not scheduled. Schema sketched below to preserve design intent.

**Origin:** Conversation 2026-04-22 following Run 7 on `c:\git\manifesto`. User-proposed.

### The idea

Each Kata phase (Intent, Grasp, Diagnose / Measurements, Decide, Execute, Hansei when applicable) emits a small standardized markdown artifact in addition to its contribution to the kiroku session log. The artifact has a fixed shape: `Input` / `Work` / `Output` / `Next`. The agent fills the shape; the shape does not dictate content.

The same artifact is consumed by the next phase as its declared input. Phases become contracted hand-offs rather than implicit context inheritance.

### The three problems it would address

1. **Reviewer engagement (the named gap in `c:\git\manifesto\PROBLEM.md` § Out of Scope #1).** Current trail resolutions (full session / INDEX / SUMMARY) are AI-shaped at every level. A per-phase artifact written for a human reader is a fourth resolution targeting non-AI-fluent observers — colleagues, deployers evaluating adoption, regulators wanting to see what the agent "thinks" before it acts.

2. **Real phase separation via artifact-as-contract.** Today, Grasp inherits Intent implicitly because both run in one agent context. With explicit artifact hand-off, a phase could be re-run against a frozen prior artifact without redoing upstream work — and a phase could be implemented by a different runtime/model than its neighbors. (This is what would unlock the parked triangulation idea, if it ever gets validated.)

3. **Analysis-only adoption mode.** Skeptical evaluators want to see what the suite *says about their project* without it touching anything. A pipeline of "Intent → Grasp → Measurements → Diagnosis (stop)" produces a complete analytical artifact bundle with zero risk to the target codebase. Currently no clean "pure analysis" mode exists; Kata is full-cycle by default.

### Sketched schema (structure-only, no content prescribed)

Every phase artifact is a markdown file with this front matter and these four sections. Field semantics are described; field *content* is the agent's to determine.

```markdown
---
phase: <intent|grasp|measurements|diagnosis|decision|execute|hansei>
run: <run number>
target: <repo or artifact under evaluation>
agent: <model identity>
upstream: <relative path(s) to artifact(s) this phase consumed, or "user-prompt">
fidelity: <verbatim|reconstructed>
timestamp: <ISO-8601>
---

# <Phase> — Run <N>

## Input
What this phase received. If upstream is a prior artifact, summarize what was taken from it
(not a copy — a statement of which parts mattered for this phase). If upstream is the user's
raw prompt, quote it.

## Work
What the agent did, narrated. The reasoning, not just the result. This section is where
Commander's Intent shows: the agent explains how it interpreted the inputs and what it
considered and rejected.

## Output
The phase's actual deliverable. For Intent: the interpretation. For Grasp: the situation
description and assumptions. For Measurements: the rubric (with provenance). For Diagnosis:
findings with root causes. For Decision: methodology + rationale. For Execute: what was
changed and why. For Hansei: the reflection finding.

## Next
What the next phase needs. Pointer to this artifact. Open questions. Anything the next
phase should know about that the Output doesn't already say.
```

### What this would replace, not pile on

Artifact bloat is real. To earn its place, this scheme should *consolidate* rather than add:

- The kiroku session log's `Intent` / `Exchange Log` / `Outcome` sections become **derived** from the per-phase artifacts (concatenation + framing), not separately authored. One source of truth.
- The session file remains the indexed-resolution view. The per-phase bundle is the new human-narrative resolution.
- GENBA, SCORECARD, SUMMARY remain unchanged — they are aggregate views over runs, not phase records.

### Open questions (to address before any prototype)

- **Schema vs checklist.** Where is the line? Test: remove every example from the schema spec. Would a competent agent still produce useful artifacts? If no, the schema has drifted into prescription. The four sections (Input/Work/Output/Next) are deliberately vague; tightening field semantics further would risk the slide.
- **Storage location.** Per-run subdirectory under `TRAIL/sessions/<session-id>/phases/`? Or flat with naming convention? Affects discoverability vs noise.
- **Analysis-only mode mechanics.** Probably a `-AnalysisOnly` flag on `kata` invocation that runs Steps 0–3 and stops before Execute. No file writes outside the artifact bundle. This is the cheapest empirical test of whether the artifacts actually help a human reader.
- **P2 resolution requirement.** PRINCIPLES.md P2 currently lists three resolutions (full / indexed / digested). A per-phase human-narrative resolution is a fourth. If this is ever adopted, P2 wording is *implementation-friendly* enough that it doesn't need to change — but the skills-suite README would need to acknowledge the new resolution explicitly.
- **Cost.** Five-to-seven artifacts per Kata run is non-trivial. Need to verify they're actually consumed (by humans or by next phases) before treating the cost as justified. The reviewer-engagement metric (Metric 11) is the right signal.

### What this idea is NOT

- Not a manifesto change. PRINCIPLES.md and PROBLEM.md remain unchanged regardless.
- Not a triangulation prerequisite, but a triangulation *enabler*: artifact-as-contract is what would make per-phase model rotation mechanically clean if and when that becomes worth doing.
- Not a checklist. The schema is structural. Content is the agent's reasoning.
- Not adopted. This is parked. No skill files change.

### Decision on this entry

Do nothing now. Revisit when (a) a colleague actually evaluates the suite and the gap in legibility becomes concrete, (b) an empirical reviewer-engagement signal suggests current resolutions are insufficient, or (c) the triangulation pattern needs a clean phase boundary to operate over.

---

## DB-002 — Cross-family scoring consolidation

**Status:** Parked (recorded 2026-04-22). User explicitly deferred during the same conversation that produced DB-001.

**The idea:** Each scoring run produces N independent scores from N evaluator families; a panel-of-judges step consolidates them into a single recorded score with the divergence preserved.

**Why parked:** Same constraints as triangulation generally — Copilot Chat lacks model-rotation automation, and the empirical question of whether cross-family scoring divergence is large enough to justify the cost has not been answered. Belongs to the same downstream validation track as the triangulation pattern.

**Not adopted. No skill files change.**
