# TPS Skill Suite Scorecard — v4 Pre-Protocol Archive

> **Archived 2026-04-22.** This file preserves the Rubric v4 dimensions, scoring rationales, Run Ledger, and Dimension Trajectory as they stood at the end of Run 88, before the v2.11.0 sequential additive consolidation protocol was exercised.
>
> **Reason for archive:** Rubric v4 (Runs 87–88) was derived by a single evaluator family (Claude) before the v2.11.0 additive consolidation protocol existed. To exercise the protocol cleanly — without the next evaluator family anchoring on dimensions a prior single family declared — the live `SCORECARD.md` was reset to a stub. The next Kata cycle by a distinct evaluator family will derive the rubric cold under the v2.11.0 protocol; subsequent runs will then perform genuine additive consolidation against that derivation.
>
> **What this archive is for:** post-hoc comparison only. Scores in this file are NOT directly comparable to scores produced under any post-reset rubric.
>
> See live [SCORECARD.md](../SCORECARD.md) for current state and [CHANGELOG.md](../CHANGELOG.md) v2.11.1 for the reset rationale.

---

## TPS Skill Suite Scorecard

<!-- markdownlint-disable MD012 -->

**Target:** `C:\Users\admin\.copilot\skills\` — TPS skill suite as a tooling implementation.
**Commander's Intent:** `C:\git\manifesto\PROBLEM.md` and `C:\git\manifesto\PRINCIPLES.md` (external, versioned separately).
**Measurement scheme:** Rubric v4 (derived Run 87, 2026-04-21).

## Scheme rationale

The v3 rubric governed Runs 1–86 over a conflated artifact (theory + implementation) and measured both. With the Manifesto extracted, the suite is purely a tooling implementation and must be scored as such. v4 is derived by walking the four delegability questions a deployer would ask of a tool, then back to Manifesto principles. It is **not** a rename of v3 dimensions — D2 Cause, D3 Measurement, and D6 Clarity from v3 do not appear because they measured theory quality, not tool quality.

The v1–v3 history — 86 runs — is preserved at [TRAIL/SCORECARD_ARCHIVE_v3.md](TRAIL/SCORECARD_ARCHIVE_v3.md). Evidence, not inheritance.

## Rubric Provenance

The rubric evolves additively across evaluator families per the Kata Step 1 consolidation protocol. Each row records which family-version contributed each dimension and in which run. New runs that surface novel dimensions (Re-derivation: divergent additive) extend this table; runs that retire dimensions (Re-derivation: divergent contradictory) mark the row retired and reference the retiring run.

| Dimension | Contributed by | Run | Status | Rationale |
|---|---|---|---|---|
| D1 Intent Fidelity | Claude (TPS suite, Run 87 derivation) | 87 | active | Direct expression of Manifesto P1; tests whether skills force interpretation. |
| D2 Resolution Coverage | Claude (TPS suite, Run 87 derivation) | 87 | active | Direct expression of Manifesto P2 resolution requirement. |
| D3 Convergence Integrity | Claude (TPS suite, Run 87 derivation) | 87 | active | Direct expression of Manifesto P3; checks the stopping condition is computable. |
| D4 Transferability | Claude (TPS suite, Run 87 derivation) | 87 | active | Tests the framework's "implementation-agnostic" claim against external targets. |
| D5 Artifact Integrity | Claude (TPS suite, Run 87 derivation) | 87 | active | Trail trustworthiness; defect classes caught by mechanical check, not next-model inspection. |
| D6 ARF Evidence | Claude (TPS suite, Run 87 derivation) | 87 | active | The framework's emergent property must be probe-evidenced, not asserted. |

*Future runs by other families (GPT, Gemini, etc.) extend this table when their independent re-derivation surfaces additional dimensions. See [kata/SKILL.md § Step 1](kata/SKILL.md) for the protocol.*

## Rubric v4 — Six Dimensions

Each dimension is scored 1–10 against the anchors below. Score the anchor that most closely matches observed evidence; halves (e.g., 7.5) are allowed when evidence sits cleanly between two anchors. If no anchor fits, the evidence is ambiguous — record a finding, not a guess.

### D1 Intent Fidelity (Manifesto P1)

*Do skill prompts force the agent to interpret, or do they hand out a checklist?*

- **Test:** Remove all specific examples, thresholds, and enumerated lists from a skill prompt. Can an intelligent agent still know what to do?
- **3:** Skill is a checklist with the word "reasoning" sprinkled on top. Removing examples breaks it.
- **5:** Skill mixes questions and prescriptions. Some phases teach; some instruct.
- **7:** Skill is structured around questions and vocabulary. Examples exist but are illustrative, not load-bearing.
- **9:** Skill is derivation-driven throughout. Examples can be removed without loss of operability. Agent must reason to use the skill.
- **10:** As 9, plus empirical evidence (Shiken probe, cross-family use) that agents using the skill produce situated — not generic — findings under the current rubric.

### D2 Resolution Coverage (Manifesto P2, shape)

*Can all five observer classes consume the trail at their own time budget, with fidelity marked?*

- **Test:** Pick any recent run. Can a regulator (afternoon), a deployer (2 minutes), and the next agent (seconds) each get what they need from the artifacts? Are agent-authored summaries marked as such?
- **3:** Single-resolution trail (only raw logs, or only a summary). Fidelity not marked. Observer-class coverage is accidental.
- **5:** Two resolutions exist (e.g., session + SUMMARY) but one observer class is silently excluded.
- **7:** Full / indexed / digested all present; fidelity marked where manual; observer-class coverage documented.
- **9:** Resolutions are enforced mechanically (tool checks, not just convention). Digests point to disagreements, not just outcomes.
- **10:** As 9, plus independent evidence that two or more distinct observer classes actually used the trail for their intended purpose.

### D3 Convergence Integrity (Manifesto P3)

*Is the stopping condition computable from artifacts, not self-asserted? Does re-derivation by distinct families actually happen?*

- **Test:** A fresh reviewer reading only SCORECARD + `metrics.ps1` output arrives at the same P3 counter. Same-family evaluators are visibly discounted. Measurement-scheme re-derivation is recorded per Run.
- **3:** P3 counter is a claim in prose. No mechanical check. No re-derivation rule.
- **5:** Counter is recorded per run but not independently computable. Same-family discounting is documented but not enforced.
- **7:** Counter is computable from SCORECARD data. Same-family discounting enforced by convention. Re-derivation rule exists.
- **9:** Counter is computed mechanically with divergence detection. Re-derivation happens and is recorded (`inherited` / `convergent` / `divergent`). Silence runs are marked in a machine-parseable way.
- **10:** As 9, plus at least one completed 3/3 chain across three distinct evaluator families on the current rubric, with at least one re-derivation marked convergent.

### D4 Transferability (Out-of-scope claim made testable)

*Has the tool been demonstrated on non-self targets, producing trails legible to those targets' stakeholders?*

- **Test:** Count of external-target Kata runs on distinct repos; quality of trail artifacts in those repos; whether those repos' maintainers (or a proxy) could act on the findings.
- **3:** Zero external targets. Tool has only been self-applied.
- **5:** 1 external target, trail in the suite's repo rather than the target's.
- **7:** ≥2 external targets, trails in the target repos, demonstrable artifacts shipped (tests added, defects fixed, releases tagged).
- **9:** ≥3 external targets across distinct domains (language, stack, size) with trail artifacts their own stakeholders could use.
- **10:** As 9, plus at least one external target's maintainers (not the agent operator) engaged with the trail and found it useful.

### D5 Artifact Integrity (Manifesto P2, trustworthiness)

*Are the trail artifacts themselves trustworthy? Do `verify-suite.ps1` and `metrics.ps1` catch the classes of defect that have actually appeared?*

- **Test:** Run the checks. Do they detect mojibake, silent row drops, concatenated files, timestamp churn, regex false-positives in silence detection, etc.? For each defect class historically found by a later run, is there now a mechanical check?
- **3:** Some checks exist but known defect classes are only caught by next-model inspection. Many false-positives.
- **5:** Checks cover structural defects but miss encoding / semantic classes.
- **7:** All historically-found defect classes have mechanical checks. Known false-positive patterns are fixed. Clean runs stay clean.
- **9:** As 7, plus checks themselves are version-controlled, CM-hashed, and proven stable across ≥3 evaluator families.
- **10:** As 9, plus an external defect (one introduced by a later change, not caught by prior runs) is detected by a check before human escalation.

### D6 ARF Evidence (Manifesto emergent property)

*Has the tool been subjected to novelty probes and survived? Is situational discrimination evidenced, not claimed?*

- **Test:** Count of successfully-passed Shiken probes; diversity of probe types (dual-case, anti-compliance, adversarially underspecified); recency of last probe under the current rubric.
- **3:** ARF is asserted in the rubric but no probe has been run.
- **5:** One probe has been run and passed, but within the authoring family.
- **7:** Multiple probes have been run by at least one evaluator family, including at least one that could have revealed pattern-matching and didn't.
- **9:** Probes by ≥2 distinct evaluator families, across ≥2 probe types, all passing, all under the current rubric.
- **10:** As 9, plus a probe has found a real gap and driven a fix (proving the probe mechanism is not just self-confirming).

## Derived measurements vs Rubric v4

Every run may add one-off derived measurements alongside Rubric v4 (e.g., a Kata scoped to a single skill file may derive bespoke dimensions for that file). These go in the `Derived` column of the Dimension Trajectory. Rubric v4 dimensions stay in the named columns.

## Target Condition

*The TPS suite is a delegable Manifesto implementation — validated by a P3 convergence chain of three distinct evaluator families on the suite itself AND sustained by demonstrated efficacy on ≥2 distinct external targets with trails legible to those targets' stakeholders.*

Formal decomposition:

- D3 Convergence Integrity ≥ 9 AND a current 3/3 P3 chain exists on Rubric v4.
- D4 Transferability ≥ 7 AND at least one external-target maintainer (or proxy) has engaged with a trail.
- D6 ARF Evidence ≥ 7 AND the last Shiken probe was under Rubric v4.
- No dimension below 7.

## Run Ledger

| Run | Date | Model | Start Score | End Score | Delta | Target | Result |
| --- | ---- | ----- | :---------: | :-------: | :---: | :----: | ------ |
| 87  | 2026-04-21 | Claude Opus 4.7 | N/A (first v4 run) | 6.67 | N/A | TPS Skill Suite | **Kata — Rubric v4 derivation.** First derivation after Manifesto extraction. Six dimensions derived from deployer delegability test anchored to Manifesto P1/P2/P3 + ARF. Scheme recorded as `[!DECISION]` in session. Baseline scored. P3 chain begins at 0/3 pending distinct-family re-derivation. |

## Dimension Trajectory (Rubric v4)

Format: `start→end` per cell. `Scheme` column records `derived` / `inherited` / `inherited (same family)` / `convergent` / `divergent` per Kata Step 1. `Derived` column lists one-off measurements beyond Rubric v4 for scoped runs.

| Run | D1 Intent | D2 Resolution | D3 Convergence | D4 Transfer | D5 Integrity | D6 ARF | Mean | Scheme | Derived |
| --- | :-------: | :-----------: | :------------: | :---------: | :----------: | :----: | :--: | ------ | ------- |
| 87  | N/A→8     | N/A→6         | N/A→7          | N/A→6       | N/A→8        | N/A→5  | 6.67 | derived | — |
| 88  | 8→9       | 6→10          | 7→9            | 6→6         | 8→8          | 5→5    | 7.83 | convergent | — |

### Run 87 scoring rationale

- **D1 Intent Fidelity = 8.** Skills (v2.9.0) are structured around questions and vocabulary; examples are illustrative. Run 57 + Run 70 Shiken passes indicate situated findings, but under the v3 rubric. Under v4, the evidence bar is "Shiken under current rubric" — not yet met → capped below 9.
- **D2 Resolution Coverage = 6.** Full (sessions) + indexed (INDEX.md) + digested (SUMMARY.md) all exist. Fidelity marked (session frontmatter). Observer-class coverage is documented in PROBLEM.md but not mechanically enforced in the suite — a regulator-oriented digest variant does not exist, and there is no mechanical check that a deployer-time-budget view exists.
- **D3 Convergence Integrity = 7.** P3 counter is computable (`metrics.ps1` Metric 7, with the silence-marker fix from Runs 72/79/80). Re-derivation rule exists (Run 83). Divergence-as-finding rule exists. Not yet 9 because re-derivation has not actually happened on v4 — this is the first v4 run.
- **D4 Transferability = 6.** Multiple external-target runs exist (Run 62 leifoglenedk, Run 66 apikit, Run 67 evo, Runs 45/46 kiroku, Runs 76/77 SupplementPlanner). Trails live in target repos. No maintainer engagement evidenced. Sits between 5 and 7 — closer to 7 on artifacts, but missing the maintainer-engagement floor.
- **D5 Artifact Integrity = 8.** `verify-suite.ps1` has 14 checks covering mojibake, row-drops, CHANGELOG contiguity, per-run coverage, hash snapshots, and score-artifact correlation. Known false-positive classes (Run 72, Run 79, Run 80) have been fixed. Not yet 9 because the checks are not CM-hashed against distinct evaluator families' independent audits — the check script is itself evaluator-dependent.
- **D6 ARF Evidence = 5.** Run 57 and Run 70 Shiken probes exist, both passed. Both were self-administered within the Claude family. No cross-family probe under v4. Meets 5 ("one probe, authoring family"); does not reach 7.

**Mean: 6.67.** Baseline for v4. The gap from the prior v3 mean (~9.1) reflects the honest cost of resetting the rubric to measure what actually matters for a tool, rather than inheriting flattering scores from a conflated measurement.

## Hand-off to Run 89

Run 89 should preferably focus on generating Tier 2 Transferability (D4) evidence by deploying the suite against an external target and engaging open-source maintainers.
