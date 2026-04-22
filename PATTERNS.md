# Implementation Patterns

Validated, optional, recommended implementation patterns that satisfy the [Manifesto principles](../../git/manifesto/PRINCIPLES.md) without claiming principle status themselves.

**Distinction from other documents:**
- **PRINCIPLES.md** (manifesto) — theory, mandatory, evidence-anchored.
- **PROBLEM.md** (manifesto) — gaps the framework targets.
- **PROOF.md** (manifesto) — empirical evidence backing principle-level claims.
- **DESIGN_BACKLOG.md** (this repo) — parked ideas, unscored, unvalidated, not adopted.
- **PATTERNS.md** (this repo) — implementation patterns with at least one validated instance, optional to adopt, no principle-level claim.

A pattern is promoted from DESIGN_BACKLOG when at least one validated instance exists. A pattern can be referenced by a skill but is never required by one — skills satisfy principles, not patterns.

**Promotion path:** principle-level claims about a pattern (i.e., the pattern reveals or refines a principle) belong in a manifesto refinement, not here. PATTERNS.md is implementation-layer.

---

## PT-001 — Sequential Cross-Family Convergence with Handoff

**Status:** Validated (2026-04-22). Recorded as the first formalized Pattern.

**Validated instances:**
- TPS skills suite SCORECARD Runs 96 (Gemini) and 97 (Grok) reproducing 8.83 baseline against Rubric v5.
- `c:\git\manifesto` Runs 4–6 (Grok / Gemini / GPT) silence-convergence chain at 36.5/40.0.

### The pattern

When P3 (Convergence Is Silence) requires diverse independent evaluator scrutiny but parallel multi-family orchestration is unavailable (current Copilot Chat limitation), run evaluations **sequentially** across distinct model families. Each peg is performed by a different family in a fresh session with cold re-derivation. State is carried between pegs by the kiroku Pending Handoff envelope in `TRAIL/SUMMARY.md`. The handoff itself — what the closing agent wrote, what the opening agent read — is the audit trail of the consolidation.

### Mechanics

- **Pool:** N ≥ 3 distinct model families (e.g., Claude / Gemini / Grok / GPT). N can grow as more families become available; the pattern is monotone in N.
- **Per-peg discipline:** cold derivation from source documents (PRINCIPLES.md, PROBLEM.md, PROOF.md), then comparison to existing rubric. Reading prior runs' session logs **before** independent derivation contaminates the peg.
- **Carrier:** the Pending Handoff envelope convention (PT-002). Envelope is methodology-agnostic; payload (target family, reading order, do-not-read list, verbatim task statement) is methodology-specific.
- **Silence outcome:** convergence chain advances when N consecutive pegs reproduce the same dimensions and score with no additive or contradictory finding.
- **Divergence outcome:** legitimate signal that the rubric or scored artifact has changed materially; recorded as such, not reconciled away.
- **Contamination disclosure:** any prior conversation context (the agent having read the target in the same chat, the agent having authored prior-turn prescriptions on the same proposal) must be disclosed and the run excluded from the chain.

### Why this is a pattern, not a principle

The pattern *operationalizes* P3 — it does not extend it. The abstract claim ("diverse independent evaluators arriving at the same finding without coordinating is the strongest external evidence of validity") is P3 itself. PT-001 says *here is one mechanically achievable way to produce that evidence given today's tooling constraints.*

If parallel multi-family orchestration becomes available and produces strictly stronger signal, the natural successor pattern (currently DB-003, parallel form) may be promoted to PT-002, and at that point a P3 *refinement* may be justified.

### When NOT to use

- When fewer than N distinct families are available with comparable competence on the target.
- When the target is changing fast enough between pegs that re-derivation is measuring drift rather than convergence (re-anchor the chain instead).
- When the cost of N sequential evaluations exceeds the consequence of acting on a single-family finding.

### Skills that reference or implement this pattern

None. The pattern is satisfied by data convention (PT-002), not by skill behavior. Any methodology (kata, per-skill-convergence runs, shiken probe authorship across families) can use it.

---

## PT-002 — Pending Handoff Envelope in Trail Summary

**Status:** Validated (2026-04-22). Used by PT-001 instances on this repo and on `c:\git\manifesto`.

**Validated instances:**
- `C:\Users\admin\.copilot\skills\TRAIL\SUMMARY.md` carrying the GPT peg-3 brief between sessions.
- `c:\git\manifesto\TRAIL\SUMMARY.md` carrying the closed-chain sentinel after Runs 4–6.

### The pattern

When work spans multiple sessions and the next session may run in a different model family or after context loss, the closing agent writes a **Pending Handoff** envelope into `TRAIL/SUMMARY.md`. The opening agent of the successor session reads only `TRAIL/SUMMARY.md`, finds the envelope, and follows it. No skill, no methodology, no tooling enforcement is required — the convention is a data convention layered on top of the existing trail.

### Envelope schema

A `## Pending Handoff` section in `TRAIL/SUMMARY.md` containing **either** the sentinel:

> `None — work complete.`

**or** the following fields:

- **Target model family:** which family the next session should use (or "any").
- **Important context:** what changed since the prior peg that the successor must know.
- **Reading order:** ordered list of files the successor reads first, with rationale.
- **Do NOT read:** files that would contaminate cold derivation.
- **Task statement:** verbatim prompt to paste into the fresh session.
- **Closed by:** the session log that authored this envelope.

### Why this is a separable pattern

The envelope is **data**, not skill behavior. It does not interpret, score, derive, or reason — it is a structured note left in a file the next agent will read anyway. Embedding it in a skill would (a) bind a methodology-agnostic convention to a specific skill's lifecycle, and (b) require bumping the skill artifact every time the envelope schema changes, which disturbs principle-level convergence chains scored against that skill.

The convention is enforceable mechanically (regex on the SUMMARY section) but the enforcement is optional and lives outside the skill suite — for example, a project-local pre-commit hook or a methodology's own validator. The skill suite itself takes no position on whether a project must use this pattern.

### When NOT to use

- Single-session work with no successor.
- Work where the successor will be the same agent in the same context (no handoff actually occurs).
- Projects whose trail layer is not `TRAIL/SUMMARY.md` (the pattern is specific to that file location; an analogue could be defined for other layouts but is a different pattern).

### Skills that reference or implement this pattern

None. By design.

---

## Pattern lifecycle

1. **Idea** → DESIGN_BACKLOG.md (DB-NNN).
2. **First validated instance** → promoted to PATTERNS.md (PT-NNN).
3. **Repeated validated instances** → may inform a manifesto refinement or remain implementation-layer indefinitely.
4. **Superseded** → marked deprecated; reasons recorded.

A pattern that fails to validate further or is contradicted by later evidence is **demoted** back to DESIGN_BACKLOG with the contrary evidence noted.
