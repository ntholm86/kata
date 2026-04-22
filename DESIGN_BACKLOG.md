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

---

## DB-003 — Multi-family × multi-phase + judges as a generalized pattern

**Status:** Parked (recorded 2026-04-22). User flagged as "important thoughts — please note these things so we don't forget."

**Origin:** Conversation 2026-04-22 after building the kiroku Pending Handoff envelope (kiroku v2.5.0). User observation: *"I am starting to see darkness at the end of the tunnel."*

### The pattern (user's own framing, captured)

> Multiple families running on multiple phases + judges = consolidation (applying this pattern everywhere meaningfully, the pool of X families can be big or small — it will only improve quality) + handover to next phase (the handover is also the documentation/proof — argues why this should be in kiroku, but it's still tied to kata so it's hard to solve in a standardized way). This can be applied many many places — one other place it will be valuable to apply is the hansei.

### What this generalizes

DB-001 (per-phase artifacts), DB-002 (cross-family scoring), and the kiroku Pending Handoff section that just shipped are all **instances of the same underlying pattern**:

1. A unit of work (a phase, a scoring round, a Hansei reflection) is performed by **N independent agents from distinct families**.
2. Their outputs are **consolidated by a judge step** (which may itself be multi-family).
3. The consolidated artifact is **handed off** to the next unit of work — and the handoff itself is the **proof/documentation** that the consolidation happened.

The pool size N is variable. N=1 is the current default. N=2 already produces useful divergence/silence signal (this is what the P3 chain demonstrates today, just sequentially over time). N=3+ converts P3 from sequential to parallel and removes the temporal-contamination risk of "evaluator reads prior runs."

### Where this could apply (named examples, non-exhaustive)

- **Scoring** (DB-002): N families score independently → judge consolidates → recorded score preserves divergence.
- **Per-phase Kata work** (DB-001): N families execute the phase → judge consolidates → next phase receives consolidated artifact.
- **Hansei reflection** (newly named): N families reflect on the same trail independently → judge consolidates blind-spots → produces a reflection artifact richer than any single agent could produce. This is particularly valuable because Hansei's failure mode is precisely the agent failing to see its own blind spots — multi-family Hansei is the mechanical answer to that.
- **Shiken probe construction:** N families construct novelty probes independently → judge selects/consolidates → reduces the risk that probes only catch failure modes the probe-author already knew about.
- **Intent interpretation:** N families interpret the user's prompt independently → divergence in interpretation surfaces ambiguity in the prompt itself, which is upstream evidence for Commander's Intent.

### Why the handoff-is-proof claim matters

In the current architecture, handoff content is methodology-shaped (Kata's handoff differs from a Shiken handoff differs from a Hansei handoff). Kiroku owns only the envelope (Pending Handoff section in SUMMARY.md, v2.5.0). The user's point: under the generalized pattern, the consolidated handoff artifact *is* the proof of the multi-family consolidation having happened — there is nothing to prove separately. This strengthens the case that handoff is fundamentally a P2/Kiroku concern, while leaving the payload methodology-specific (preserving the one-skill-one-principle rule).

The friction the user names: "it's still tied to kata so it's hard to solve in a standardized way." The envelope/payload separation we just shipped is a partial answer — kiroku owns the standard envelope; methodology owns the payload — but the *consolidation* step (multiple agents → one artifact) is not yet a kiroku primitive. It would need to be, for the pattern to generalize cleanly.

### Blocker (named honestly)

**Technology.** Full implementation requires programmatic model-family rotation within a single workflow — the ability for a script (or a kiroku command) to invoke "the same task across N distinct families and collect N artifacts." Copilot Chat today does not expose this; the user has to manually open chats in different model pickers. This is an external blocker, not a design defect.

User's own note: *"it will probably come soon — that's one blocker."*

Until then, the pattern is approximated **sequentially** (different families across different sessions, with kiroku Pending Handoff carrying the baton). That is exactly what the P3 silence chains do today. The generalized pattern, parallelized, is what arrives once the orchestration layer matures.

### What to do now

- **Do nothing structural.** This is a future-looking design note, not a current implementation.
- **Watch for instances.** When a new skill or workflow asks "should this run across multiple families?", recognize it as an instance of DB-003 and treat the answer consistently.
- **When the orchestration layer arrives** (Copilot Chat or alternative), the natural first targets are:
  1. Scoring (DB-002 immediately becomes mechanizable).
  2. Hansei (newly named — high value because it directly attacks the single-agent blind-spot problem).
  3. Shiken probe construction.
- **Architectural note for future work:** the consolidation step (judge over N artifacts) should likely live in kiroku as a primitive (`kiroku-consolidate.ps1` or similar), keeping the pattern envelope/payload-clean rather than duplicating it in every methodology skill.

### What this entry is NOT

- Not a current commitment.
- Not a manifesto-level claim. The Manifesto already names "Evaluator independence and diversity" as an open problem in `What Must Be Built on Top`; this entry is one *implementation pattern* candidate for that, not a principle.
- Not blocked on us. Blocked on tooling that is plausibly inbound.
