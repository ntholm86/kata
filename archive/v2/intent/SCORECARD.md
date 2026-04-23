# Intent Skill Scorecard

The Intent skill is evaluated against **Principle 1 (Commander's Intent) only**. Per the one-skill-one-principle architectural rule, Intent's P2 compliance (visibility of its interpretation) is delegated to the Kiroku skill and is not measured here.

This scorecard is **per-skill**, distinct from the suite-level `SCORECARD.md`. The suite-level scorecard measures the skills suite as a whole; this one measures Intent against its assigned principle.

## Measurement Dimensions (Scale 1–10)

Cold-derived from `c:\git\manifesto\PRINCIPLES.md § Principle 1` and `c:\git\manifesto\PROBLEM.md § Problem 1` before re-reading `intent/SKILL.md` in this evaluation. (Contamination disclosure for peg 1 is recorded in the run row.)

### D1. Destination Extraction Discipline

Does the skill produce a stated *destination* (what the user is trying to achieve and why), distinguishable from a paraphrase of the literal prompt? Does it require the agent to name alternatives it considered and rejected — the operational test for "did interpretation actually happen vs pattern-match"?

- **10**: Extraction is mandatory, structured, and distinguishable from restatement. Rejected alternatives are required output when they exist.
- **1**: The skill produces only restated literal prompts; no decompression of compressed intent.

### D2. Anti-Prescription Discipline

Does the skill itself avoid prescribing the route to the agent running it? It must *embody* P1, not just describe it. Test: remove every example from the skill text — does the agent still know what to do?

- **10**: Skill is structurally vocabulary + thinking framework; passes the remove-all-examples test trivially.
- **1**: Skill is a checklist of specific probes/thresholds the agent must execute.

### D3. Visible Interpretation (the gap check)

Does the skill require the interpretation to be *narrated* before action and the *gap* against the literal prompt to be explicitly checked? The narration must enable the user to catch a wrong interpretation cheaply.

- **10**: Narration is mandatory, gap-check is a load-bearing step with a precise taxonomy (minor/material/contradiction), the secondary test ("can an observer identify what the agent took the user to mean *before* seeing the work?") is explicit.
- **1**: Interpretation is implicit; no narration requirement; no gap check.

### D4. Honest Failure Modes

Does the skill acknowledge what it is *not*, where it should *not* fire, and what failure modes it must avoid? A P1 skill that always fires is a ticketing system; one that never fires is silent compliance.

- **10**: Failure modes named explicitly (over-firing, under-firing, after-the-fact justification). Boundary drawn in skill front-matter (SKIP WHEN) and reinforced in body.
- **1**: No acknowledgment of failure modes or non-applicable cases.

---

## Dimension Trajectory

| Run | Date | Model | D1 | D2 | D3 | D4 | Total | Delta | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 (Peg 1, contaminated) | 2026-04-22 | Claude Opus 4.6 | 9.5 | 9.0 | 9.5 | 9.0 | 37.0 | — | First per-skill evaluation. Cold derivation attempted but contaminated: same-conversation derivation of one-skill-one-principle rule, plus prior read of `intent/SKILL.md` in same session for unrelated work. Peg 1 of P3 chain; pegs 2 and 3 require fresh sessions in different families. |

*Trajectory is newest-last. Each run's pre-action score is the starting point; the post-action score is the entry.*
*Per-skill convergence requires 3 consecutive zero-delta evaluations by 3 distinct evaluator families with cold re-derivation of this rubric, per `c:\git\manifesto\PRINCIPLES.md § Principle 3`.*

## Convergence Status

- Peg 1/3: Claude Opus 4.6 (this run, contaminated) — 37.0/40.0
- Peg 2/3: not yet evaluated — fresh session required, family ≠ Claude
- Peg 3/3: not yet evaluated — fresh session required, family ≠ {Claude, peg 2's family}

## Rubric Provenance

| Dimension | Contributing Family | Run | Rationale |
| --- | --- | --- | --- |
| D1 Destination Extraction | Claude Opus 4.6 | 1 | Cold-derived from P1 "ask, don't tell" + the operational test of distinguishable interpretation from paraphrase. |
| D2 Anti-Prescription | Claude Opus 4.6 | 1 | Cold-derived from P1's own self-test ("if you removed all the specific examples and thresholds, would an intelligent agent still know what to do?"). Applied to the skill itself, not the agent it teaches. |
| D3 Visible Interpretation | Claude Opus 4.6 | 1 | Cold-derived from PROBLEM.md Problem 1's framing of interpretation as the operational mechanism + P1's "trust the interpretation" sub-point. The visibility requirement here is *of the interpretation by the user*, not the broader P2 evidence trail. |
| D4 Honest Failure Modes | Claude Opus 4.6 | 1 | Cold-derived from P1's "What this is not" clause (vagueness ≠ Commander's Intent) + the implicit need for boundary conditions on when the skill applies. |
