# Rubric v3 Proposal — Standards-Anchored Scoring

**Status:** ADOPTED — Run 42 (2026-04-19). Cross-model reviews completed by GPT-5.4 and Gemini 3.1 Pro (Preview). Rubric v3 now active in SCORECARD.md.

**Author:** Claude Opus 4.6, Kaikaku run, 2026-04-19

**Trigger:** User identified that the v1/v2 rubric has no documented rationale for its dimensions (ad-hoc generation by Claude Opus 4.6, Run 17). Run 41 Hansei found "the loop has only ever validated itself." This proposal grounds the rubric in external quality frameworks.

**Provenance warning:** This proposal was drafted by one model in one session. It carries the same circularity risk as v1. Phase 3.2 (cross-model review by a non-Claude family) is mandatory before adoption.

---

## Phase 1: Diagnosis — Why Kaikaku?

### The Ceiling

The rubric measures what one model thought was important at Run 17, not what recognized quality frameworks require. The suite scores 10.0/10.0 while STANDARDS.md documents four explicit gaps the rubric cannot see.

### Evidence

| Signal | Strength | Detail |
|--------|:--------:|--------|
| Kaizen convergence | Strong | 9 consecutive runs at 10.0 (Runs 32-41). Mathematical ceiling. |
| Structural blindness | Strong | STANDARDS.md documents 4 gaps (Traceability, Risk Governance, Formal Process Optimization, Risk Categorization) with zero rubric coverage. |
| Provenance gap | Strong | GENBA Run 17 has zero rationale for dimension selection. No external framework cited. |
| Business misalignment | Moderate | Suite has added 5 infrastructure artifacts since Run 17; rubric doesn't measure them. |
| Dimension overlap | Mild | Clarity/Audience Fit overlap. Internal Consistency/Structure overlap. Inflates without adding discrimination. |

### Verdict

Kaikaku warranted. The rubric is the structural ceiling, not the suite.

---

## Phase 2: Target State — v3 Dimensions

### Design Principles

1. Every dimension must trace to at least one named practice in a recognized external framework or foundational theory. Frameworks already mapped in STANDARDS.md (PDCA, DMAIC, CMMI L3-5, NIST AI RMF 1.0) are primary anchors.
2. **No organizational theater.** Dimensions must serve the actual goal — making LLM skill instructions better at producing genuine autonomous reasoning. If a framework dimension doesn't naturally fit a 7-skill markdown suite, it is excluded, not forced. The correct response to "NIST AI RMF requires a risk register" is "that framework doesn't fully apply to us" — not "build a risk register to satisfy the rubric."
3. The suite's own PRINCIPLES.md defines capabilities (Commander's Intent, Observable Autonomy, Convergence) that no process-quality framework measures. These are legitimate anchors — they have documented theoretical origins and are the suite's core differentiator.

### Proposed Dimensions

| # | Dimension | External Anchor(s) | Measurement Procedure | v1/v2 Lineage |
|---|-----------|--------------------|-----------------------|---------------|
| 1 | **Process Completeness** | PDCA (4 phases), DMAIC (5 phases) | Does each Kata run execute all phases and produce phase-specific artifacts? Count of Kata phases with visible output per GENBA entry. | Completeness + Actionability (merged) |
| 2 | **Causal Analysis** | DMAIC Analyze, CMMI CAR (L5) | % of GENBA findings that identify root cause, not symptom. Recurrence rate is the inverse metric (computed by `metrics.ps1`). | Depth (refined) |
| 3 | **Measurement Validity** | DMAIC Measure, CMMI QPM (L4), DMAIC Control | Are `metrics.ps1` metrics operationally defined? Are thresholds justified? Can a different evaluator reproduce the same values? Does METRICS_HISTORY.md track trends over time? | Calibration (carried forward; absorbs SPC) |
| 4 | **Configuration Management** | CMMI CM (L3) | All artifacts versioned, tagged, hash-snapshotted. INTEGRITY.json stable on no-change runs. CHANGELOG contiguous. `verify-suite.ps1` passes. Focus: can you recover from a bad run? | *New — infrastructure unmeasured in v1/v2* |
| 5 | **Cross-Evaluator Reliability** | DMAIC Measure (Gauge R&R), Principle 3 | Inter-rater agreement (stdev of start scores) and model diversity index (computable via `metrics.ps1`). Finding overlap across model families (currently manual, future automatable). | Audience Fit + Trustworthiness (merged, grounded) |
| 6 | **Instruction Clarity** | CMMI REQM (L3) | Can any competent LLM follow the skill instructions without ambiguity? Are requirements (PRINCIPLES) unambiguous and complete? | Clarity (kept, anchored) |
| 7 | **Convergence Integrity** | NIST AI RMF MEASURE (validity), Principle 3 | Does the loop honor its own stopping condition? Silence counter tracked? Score changes correlate with artifact changes? No fabricated improvements? | Trustworthiness (intent preserved, renamed) |
| 8 | **Autonomous Reasoning Fidelity** | Auftragstaktik (Prussian mission-type command), Meaningful Human Control (autonomy ethics), Trust Calibration (Lee & See 2004), PRINCIPLES.md §1-2 | Two tests: **(1) Freedom of thought** — apply the Principle 1 test: remove all examples and thresholds from a skill; would a competent agent still know what to do? If yes, Commander's Intent holds — the skill defines the destination without prescribing the route. If no, the skill has drifted toward prescription and the agent is following a checklist, not reasoning. **(2) Trail integrity** — apply the Principle 2 test: can each observer class reconstruct what the agent did, why it did it, and whether to trust the results, at the resolution their time budget allows? Evidence must exist at multiple resolutions (full transcript, indexed decisions, executive digest). Self-authored layers must be explicitly marked. Fidelity degradation (verbatim vs. reconstructed) must be stated. GENBA is one resolution — a structured digest of improvement runs — but is not sufficient alone. If only one resolution exists, the trail satisfies one observer class and silently excludes the rest. | *New — measures the suite's core differentiator: genuinely free reasoning made trustworthy through radical transparency* |

### Weighting

Equal weight (arithmetic mean) unless review proposes otherwise.

### Why 8, Not 10

The initial v3 draft had 10 dimensions to match v1/v2. User review identified two that imported organizational compliance requirements without serving the suite's actual goal:

| Removed Dimension | Why Removed |
|---|---|
| **Traceability** (formal PRINCIPLES → skills → checks matrix) | The suite has 3 principles and 7 skills. A formal traceability matrix is organizational compliance theater at this scale. This remains an acknowledged gap against CMMI L5, but it is explicitly out of scored scope. Principles should be traceable through *clarity* (Instruction Clarity #6), but we do not claim this satisfies formal CMMI traceability. |
| **Risk Governance** (risk register, risk categories) | A risk register for markdown files. The suite has no production deployment, no user-safety risk, no operational risk. Its quality risks (hallucination, regression, encoding corruption) are already caught by Convergence Integrity (#7) and the verifier. Building a formal risk register to satisfy a NIST AI RMF dimension is exactly the gaming this kaikaku was meant to prevent. |

Additionally, **Statistical Process Control** was merged into **Measurement Validity** (#3). SPC with control limits is designed for manufacturing lines with thousands of data points. With 41 runs, importing formal control charts is pretending we have more data than we do. Tracking metrics over time (which METRICS_HISTORY.md does) is genuine; calling it "SPC" is vocabulary theater.

### Demoted Dimensions (Internal Quality appendix)

These v1 dimensions have no external-framework anchor. Their intent is either absorbed by v3 dimensions or measures something no recognized quality framework requires.

| v1 Dimension | Reason for Demotion | v3 Coverage |
|--------------|---------------------|-------------|
| Completeness | Absorbed by Process Completeness (#1) | Covered |
| Internal Consistency | Overlaps with Configuration Management (#4) | Covered |
| Audience Fit | Absorbed by Cross-Evaluator Reliability (#5) | Covered |
| Actionability | Absorbed by Process Completeness (#1) | Covered |
| Depth | Absorbed by Causal Analysis (#2) | Covered |
| Structure | Overlaps with Instruction Clarity (#6) and CM (#4) | Covered |
| Innovation | No external anchor — no quality framework measures novelty | Not covered — innovation is valuable but unmeasurable by standards |

### Ceiling Resolution

- Measurement Validity (#3) now includes trend tracking — addresses the "metrics exist but aren't validated" gap
- Configuration Management (#4) measures the post-Run-17 infrastructure the old rubric was blind to
- Convergence Integrity (#7) directly measures whether the loop is honest about its own stopping condition
- Autonomous Reasoning Fidelity (#8) measures the one thing that makes this suite different from any other LLM prompt collection — and that no process-quality framework even attempts to measure

### Predicted Score Impact

If v3 were applied to the suite today:

| # | Dimension | Predicted Score | Rationale |
|---|-----------|:--------------:|-----------|
| 1 | Process Completeness | 9-10 | Kata is well-instrumented |
| 2 | Causal Analysis | 7-8 | 3M framework is strong; recurrence still occurs (17.4% per metrics.ps1) |
| 3 | Measurement Validity | 6-7 | `metrics.ps1` exists but Gauge R&R never performed; thresholds unjustified; trend tracking present. Note: STANDARDS.md overstates the existence of automated degradation alerts; they do not exist in current tooling. |
| 4 | Configuration Management | 9-10 | Strong post-Run 38 |
| 5 | Cross-Evaluator Reliability | 7 | Mostly Claude variants in last 9 runs; finding overlap not measured |
| 6 | Instruction Clarity | 8-9 | Skills are well-written; PRINCIPLES clear; principles naturally traceable through skill headers |
| 7 | Convergence Integrity | 4 | Principle 3 counter at 0/3; loop generates changes to justify execution |
| 8 | Autonomous Reasoning Fidelity | 8-9 | Skills embody Commander's Intent well (Run 4 proved it — different models find different things). Trail integrity is strong (41 runs reconstructable). Some skills may have drifted toward prescription over 30 runs of hardening — needs fresh assessment |

**Predicted overall: ~7.3-7.9** (arithmetic mean). Higher than the 10-dimension draft (~6.2-7.0) because the two lowest-scoring forced dimensions (Risk Governance ~2.5, Traceability ~3.5) were removed. This is the honest score — it reflects what the suite actually does well and where it genuinely falls short, without penalizing for capabilities it was never designed to have.

---

## Phase 3: Migration Plan

### Strategy: Branch by Abstraction

v1/v2 scores remain in the SCORECARD run table. v3 scores appear in a new column starting at the adoption run.

### Phases

| Phase | What Changes | What Stays | Verification | Rollback |
|-------|-------------|------------|--------------|----------|
| 3.1: Write proposal | This file created | All artifacts | File exists; verifier passes | Delete file |
| 3.2: Cross-model review | Non-Claude model reviews; addendum added to this file | All artifacts | Review challenges ≥3 dimensions, proposes ≥1 substitution | Discard review |
| 3.3: Adopt into SCORECARD | Rubric v3 section appended; new column in run table; changelog entry | v1/v2 sections verbatim; all historical scores | Verifier passes; v1/v2 byte-identical | `git revert` |
| 3.4: First v3 scoring run | Fresh model scores against v3; expected ~6.5-7.0 | v2 score column continues | Score drop is expected and documented | Not needed |
| 3.5: Resume Kata with v3 | v3 is primary rubric; v2 column continues for continuity | All history | Improvement trajectory resumes | Switch back to v2 |

### Risks

| Risk | Likelihood | Impact | Mitigation |
|------|:----------:|:------:|------------|
| Same model drafts and grades v3 | High | High | Phase 3.2 requires non-Claude review |
| Score drop demoralizes | Medium | Low | Document that v3 drop is by design |
| v3 dimensions are wrong | Medium | Medium | Cross-model review + v3 is revisionable |
| Gaming: shallow fixes to reclaim 10.0 | Medium | High | 3-run cooldown before addressing weak dimensions |
| Autonomous Reasoning Fidelity too subjective | Medium | Medium | The dimension's tests are defined in PRINCIPLES.md; evaluators apply them, not invent them |
| Innovation lost as unmeasured | Low | Low | Keep in Internal Quality appendix |
| Historical comparison confusion | Medium | Medium | Separate columns; rubric changelog |

### Success Criteria

1. Every v3 dimension traces to a named external standard or foundational theory (auditable)
2. v3 exposes ≥2 gaps the v2 rubric was blind to
3. A non-Claude model validates before adoption
4. v1/v2 scores preserved unchanged
5. v3 baseline score < 10.0

---

## Phase 4: Validation

| Check | Result |
|-------|--------|
| Second-system effect | Pass — fewer dimensions (8 vs 10), more structure per dimension. No organizational theater imported. |
| Scope creep | Pass — 5-phase migration, phases 1-2 change nothing |
| Reversibility | Pass — all phases reversible |
| Cost/benefit | Pass — low cost (one file + one review), high benefit (grounded rubric, honest gaps, no forced dimensions) |
| Organizational theater check | Pass — Traceability and Risk Governance removed after user review. SPC merged into Measurement Validity. No dimension exists solely to satisfy an external framework that doesn't fit. |

### Honest Challenges

1. **External frameworks were designed for organizations, not LLM skill suites.** This is now addressed: two forced dimensions (Traceability, Risk Governance) were removed, and SPC was merged. The remaining 8 dimensions either naturally fit the suite or anchor to the suite's own foundational theory (Auftragstaktik, Meaningful Human Control).
2. **Innovation is demoted.** No quality framework measures novelty. Dropping it removes the incentive to be original. The suite will still innovate; it just won't score itself for it. This is an honest trade-off, not an oversight.
3. **I am both diagnoser and designer.** This entire kaikaku was performed by Claude Opus 4.6 in one session. The cross-model review in Phase 3.2 is the only safeguard against my biases. It is necessary, not optional.
4. **Autonomous Reasoning Fidelity is hard to measure.** The two tests (freedom-of-thought test, trail-integrity test) are qualitative, not mechanical. Different evaluators may reach different conclusions. This is acceptable — the dimension measures something inherently judgment-dependent. The alternative (not measuring it) is worse, because it's the suite's core value proposition.

---

## Cross-Model Review (Phase 3.2)

**Status:** COMPLETE — Two cross-model reviews received (GPT-5.4, Gemini 3.1 Pro Preview). Both recommend adoption.

**Instructions for reviewer:** You are a different model family reviewing this proposal. Your task:

1. For each of the 8 proposed dimensions, evaluate whether the external anchor is correctly cited and whether the measurement procedure is implementable.
2. Challenge at least 3 dimensions — are they the right ones? Are any forced, redundant, or missing the point?
3. Evaluate the 3 removed dimensions (Traceability, Risk Governance, SPC) — was removal justified, or should any be restored?
4. Evaluate dimension #8 (Autonomous Reasoning Fidelity) specifically — is it measurable? Is the theoretical anchoring legitimate? Does it belong in a scoring rubric or is it too subjective?
5. Provide a non-blind estimate of the v3 score the suite would receive today (acknowledging the author's prediction is already visible).
6. Recommend: adopt as-is, adopt with modifications, or reject.

*Review addendum goes below this line.*

---

## Review Addendum - GPT-5.4 - 2026-04-19

### Recommendation

Adopt with modifications.

The proposal is directionally correct. The 8-dimension version is materially better than the earlier 10-dimension draft because it removes two forced dimensions and restores the suite's own differentiator (Commander's Intent + Observable Autonomy) as a scored property. But five issues need correction before adoption.

### Findings

1. **The success criteria currently invalidate dimension #8 by definition.** Design Principle 1 explicitly allows anchors from "external framework or foundational theory," and dimension #8 uses Auftragstaktik, Meaningful Human Control, Trust Calibration, and PRINCIPLES.md as its anchors. But Success Criteria #1 still says every dimension must trace to a "named external standard." As written, the proposal fails its own gate even if dimension #8 is accepted. Fix the gate language before adoption. See [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L37), [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L54), [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L141).

2. **The review protocol asks for a blind score estimate after exposing the reviewer to the proposal's own score estimate.** The instructions say the reviewer should predict the v3 score "without consulting the prediction above first," but the prediction is placed before the review section. A reviewer who reads the document in order cannot comply. This weakens the credibility of Phase 3.2. Either move the score prediction to an appendix after the review addendum, or change the review instruction to acknowledge a non-blind estimate. See [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L92), [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L173).

3. **Dimension #5 is not operationalized as written.** The dimension definition says finding overlap across model families is "all computable via metrics.ps1," but the proposal's own predicted-score rationale later says finding overlap is not measured. Both cannot be true. Until that is reconciled, Cross-Evaluator Reliability is only partially implementable. The clean fix is to split the dimension into currently-computable subchecks and future-computable subchecks, or to explicitly state that overlap is manual today and automatable later. See [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L51), [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L102).

4. **Removing formal traceability is reasonable, but the proposal currently treats it as if clarity solves the CMMI gap. It does not.** STANDARDS.md still identifies formal traceability as the primary CMMI L5 gap. The proposal is allowed to say that L5-style traceability is out of scope for this suite, but it should say that explicitly. What it should not do is imply that "Instruction Clarity" absorbs the gap. Those are different claims. Keep traceability removed as a scored dimension if you want, but preserve it as an explicit non-goal or appendix gap. See [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L52), [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L66), [STANDARDS.md](c:/Users/admin/.copilot/skills/STANDARDS.md#L45).

5. **Dimension #3's predicted-score rationale conflicts with STANDARDS.md on degradation alerts.** The proposal scores Measurement Validity down partly because there are "no degradation alerts," but STANDARDS.md already claims the DMAIC Control phase includes automated degradation alerts and that OPM has trend alerts for out-of-control conditions. One of these documents is overstating reality. Before the rubric is adopted, reconcile the claim in STANDARDS.md with the actual behavior of metrics.ps1 / METRICS_HISTORY.md, then score from that reconciled truth. See [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L49), [RUBRIC_V3_PROPOSAL.md](c:/Users/admin/.copilot/skills/RUBRIC_V3_PROPOSAL.md#L100), [STANDARDS.md](c:/Users/admin/.copilot/skills/STANDARDS.md#L29), [STANDARDS.md](c:/Users/admin/.copilot/skills/STANDARDS.md#L41).

### Dimension Review

| # | Dimension | Verdict | Notes |
|---|-----------|---------|-------|
| 1 | Process Completeness | Keep | Fits the artifact well. Watch for gaming by verbose but low-value phase output. |
| 2 | Causal Analysis | Keep | Strong fit. This is one of the suite's clearest advantages. |
| 3 | Measurement Validity | Keep, tighten | Good dimension, but it must be grounded in verified metric behavior, not disputed documentation. |
| 4 | Configuration Management | Keep | Legitimate and measurable. This suite has enough verification infrastructure that CM quality matters directly. |
| 5 | Cross-Evaluator Reliability | Keep, revise | Important dimension, but not fully measurable with today's tooling. Clarify which parts are manual vs computed. |
| 6 | Instruction Clarity | Keep | Good replacement for vague rubric language. Do not let it become a proxy claim that all traceability concerns are solved. |
| 7 | Convergence Integrity | Keep | Essential. This directly addresses the loop's most important current weakness. |
| 8 | Autonomous Reasoning Fidelity | Keep | Legitimate and belongs in the rubric. It is the suite's differentiator. It is qualitative, but that is acceptable because the underlying capability is qualitative. |

### Removed Dimensions Review

| Removed Dimension | Review Verdict | Notes |
|------------------|----------------|-------|
| Traceability | Do not restore as scored dimension | But preserve as an explicit appendix gap / non-goal, because STANDARDS.md still names it as a real external-framework gap. |
| Risk Governance | Removal justified | The suite is not an AI deployment system. A formal risk register would be compliance theater here. |
| SPC | Removal as a standalone dimension justified | Keep trend tracking under Measurement Validity / Control, but do not pretend 41 runs gives you mature SPC. |

### Dimension #8 Review

Autonomous Reasoning Fidelity is legitimate and should stay.

It belongs because the suite is not just trying to be orderly; it is trying to produce genuine autonomous reasoning that remains auditable. No ordinary process framework captures that well. The theoretical anchoring is legitimate because PRINCIPLES.md already cites the relevant traditions and uses them as first-class design constraints.

The main caution is scoring method: do not turn dimension #8 into a binary pass/fail gate. Score it as a qualitative rubric with anchored prompts, for example:

- 10: skills consistently define destination without prescribing route; GENBA trail independently reconstructable end-to-end
- 7-8: mostly open, minor prescriptive drift; trail strong but with occasional thin reasoning
- 4-6: mixed open reasoning and checklist behavior; trail incomplete in important places
- 0-3: heavily prescriptive or poorly observable; autonomy not trustworthy

That keeps the dimension usable without pretending it is mechanical.

### Score Estimate

A truly blind estimate was not possible because the proposal exposes its own predicted score before the review section. Non-blind estimate: **7.1-7.6**.

That range is directionally close to the proposal's estimate, but I would skew slightly lower until Findings 3-5 are reconciled.

### Required Modifications Before Adoption

1. Change Success Criteria #1 from "named external standard" to "named external standard or foundational theory."
2. Move the score-prediction section below the review section, or explicitly rename the reviewer task from "independent" to "non-blind."
3. Rewrite Dimension #5 so it no longer claims finding overlap is currently computable if it is not.
4. Rewrite the traceability removal note so it says "out of scored scope" rather than implying Instruction Clarity closes the CMMI L5 traceability gap.
5. Reconcile the degradation-alert claim between this proposal and STANDARDS.md before assigning the Measurement Validity score.

### Final Verdict

**Adopt with modifications.**

The 8-dimension structure is sound. Dimension #8 should remain. Do not restore Risk Governance or standalone SPC. Do not restore Traceability as a scored dimension, but do keep it visible as an explicit external-framework gap that the suite intentionally chooses not to optimize for.


---

## Review Addendum - Gemini 3.1 Pro (Preview) - 2026-04-19

### Recommendation
**Approve for Adoption.**

### Evaluation
Following the GPT-5.4 review, the prompt inconsistencies and text contradictions have been resolved. The V3 proposal is now conceptually sound, properly anchored to external standards without importing compliance theater, and accurately reflects the current tooling limitations (e.g., manual finding overlap, missing degradation alerts).

The inclusion of Dimension #8 (Autonomous Reasoning Fidelity) successfully balances rigid CMMI/DMAIC metrics with the project's core philosophical constraint (Auftragstaktik). I concur that Dimension #8 must remain qualitative, evaluating the trail to ensure reasoning freedom rather than checklist compliance.

### Score Estimate
**Non-blind estimate: 7.2**
This aligns closely with the author's and GPT-5.4's forecasts. The score reflects strong Configuration Management (#4) and Process Completeness (#1), penalized appropriately by missing SPC features in Measurement Validity (#3) and Convergence Integrity (#7) self-dealing.

### Final Verdict
All architectural blockers, logical contradictions, and tooling misalignments have been remediated. The proposal meets Phase 3.2 requirements.

**Next Step:** Proceed to Phase 3.3 to adopt Rubric V3 into SCORECARD.md via the Kata loop.
