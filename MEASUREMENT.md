# Measurement Framework

**Version:** 0.1.1
**Status:** Active - first cross-model validation evidence recorded

## Two Tiers

### Tier 1: Skill Quality (Input Metrics)

*"Are the skills well-written?"*

This is what Rubric v3 measures. It stays. The 8 dimensions (Process Completeness, Causal Analysis, Measurement Validity, Configuration Management, Cross-Evaluator Reliability, Instruction Clarity, Convergence Integrity, Autonomous Reasoning Fidelity) measure whether the skill documents are clear, consistent, and well-engineered.

**Role:** Prevent garbage-in. A poorly written skill can't produce good work regardless of the agent.

**Existing infrastructure:** SCORECARD.md, metrics.ps1, verify-suite.ps1, RUBRIC_V3_PROPOSAL.md.

---

### Tier 2: Work Quality (Output Metrics)

*"Does work done under these skills actually succeed?"*

This is what was missing. These dimensions measure whether the skills produce outcomes a human stakeholder would recognize as valuable.

| # | Dimension | What it measures | How to evaluate |
|---|-----------|-----------------|----------------|
| W1 | **Transferability** | Can a model that didn't write the skills follow them and produce comparable results? | Give the skills to a different model family on a task it hasn't seen. Compare output quality to the authoring model. |
| W2 | **External Target Efficacy** | Do the skills improve real projects, not just themselves? | Apply skills to a project the skills weren't designed for. Did the project measurably improve? Would the human accept the changes? |
| W3 | **Reasoning vs. Compliance** | Does the agent reason from objectives or follow a checklist? | Present the same skill to two agents: one with the skill text, one with only the Intent/destination. If outputs are identical, the skill is prescriptive. If the Intent-only agent produces different but valid output, the skill supports genuine reasoning. |
| W4 | **Observer Satisfaction** | Can the trail be understood by someone who wasn't in the room? | Hand the Kiroku trail to a fresh model or human. Can they answer: what happened? what was decided? should I trust it? Rate: fully, partially, or not at all. |
| W5 | **Time to Value** | How long before the skills produce useful output on a new target? | Measure from "agent reads skills" to "first accepted change." Compare against a baseline (agent working without skills, or with a simple checklist). |

**Scoring:** Unlike Tier 1 (1-10 scale), Tier 2 uses pass/fail with evidence:

| Score | Meaning |
|-------|---------|
| **Pass** | Demonstrated with evidence (link to the work, the output, the observer's assessment) |
| **Fail** | Attempted and failed, or not yet attempted |
| **Untested** | Not yet evaluated |

**Why pass/fail, not 1-10:** Output quality on a 10-point scale invites the same ad-hoc scoring problem that plagued Tier 1 for 41 runs. Pass/fail forces binary: either the work succeeded or it didn't. The evidence speaks for itself.

---

## How the Two Tiers Interact

```
Tier 1 (Skill Quality)     Tier 2 (Work Quality)
         |                          |
  "Are they well-written?"  "Do they work?"
         |                          |
  Input metrics              Output metrics
         |                          |
  Internal consistency       External validation
         |                          |
  Can plateau without        Cannot plateau -
  indicating real quality    every new target is fresh
```

**A system is ready when:**
- Tier 1 scores are stable (input quality converged)
- Tier 2 dimensions are all Pass (output quality demonstrated)

**A system is NOT ready if:**
- Tier 1 is 10/10 but Tier 2 is Untested (current state of TPS v1.34.0)
- Tier 2 is Pass but Tier 1 is low (lucky output, fragile skills)

---

## Current State (TPS Skill Suite v2.0.1)

| Tier | Status |
|------|--------|
| Tier 1 (Skill Quality) | **6.875/10 self-score at rebuild (Run 47), then cross-model integrity defects found and corrected in v2.0.1.** Formal post-fix cross-model rescore still pending. |
| W1 (Transferability) | **Pass.** GPT-5.4, acting as a fresh model family after the Claude-authored rebuild, read the v2 skills, found real shipped defects, and corrected them without the authoring model present. Evidence: Run 48 / `TRAIL/sessions/2026-04-19-skills-v2-cross-validation.md`. |
| W2 (External Target Efficacy) | **Partial.** Runs 45-46 targeted Kiroku, but with the same model and the project was designed by that model. Still not a true external-target pass. |
| W3 (Reasoning vs. Compliance) | **Untested.** No Intent-only baseline has yet been compared against the full skill texts. |
| W4 (Observer Satisfaction) | **Pass.** A fresh model reconstructed what happened from the trail alone, identified contradictions between the claimed 5-skill suite and the shipped artifact, and produced repair work from the recorded evidence. |
| W5 (Time to Value) | **Untested.** No baseline measurement of time-to-value with vs. without the skills yet exists. |

**Bottom line:** Tier 2 is no longer zero. The suite now has evidence for transferability and observer comprehension, but external-target efficacy, reasoning-vs-compliance discrimination, and time-to-value remain open.
