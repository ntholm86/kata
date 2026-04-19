# TPS Skill Suite Scorecard

<!-- markdownlint-disable MD012 -->

Persistent cross-model trajectory for Kata self-targeting runs on the TPS skills.

| Run | Date | Model | Start Score | End Score | Delta | Target | Result |
| ----- | ----- | ----- | :---------: | :-------: | :---: | :----: | ------ |
| 1 | 2026-04-18 | Claude Opus 4.6 | 8.0 | 8.4 | +0.4 | 8.5 | Below target |
| 2 | 2026-04-18 | GPT-5.4 xhigh | 8.4 | 8.6 | +0.2 | 8.5 | Target reached |
| 3 | 2026-04-18 | Claude Sonnet 4.6 high | 8.6 | 8.6 | +0.0 | 8.5 | Target maintained |
| 4 | 2026-04-18 | Claude Opus 4.7 | 8.6 | 8.6 | +0.0 | 8.5 | Converged |
| 5 | 2026-04-18 | Claude Opus 4.6 (return) | 8.6 | 8.7 | +0.1 | 8.5 | Converged — zero edits |
| 6 | 2026-04-18 | Claude Opus 4.6 (3rd) | 8.7 | 8.8 | +0.1 | 8.5 | Kaikaku rejected — 2 Kaizen fixes |
| 7 | 2026-04-18 | Claude Opus 4.7 (2nd) | 8.8 | 8.9 | +0.1 | 8.5 | Innovation — added Hansei (corrected from 9.0 by Run 8) |
| 8 | 2026-04-18 | Claude Opus 4.7 (Hansei) | 9.0→8.9 | 8.9 | -0.1 | 8.5 | First Hansei run — validated; corrected Run 7 down |
| 9 | 2026-04-18 | Claude Opus 4.7 (3rd) | 8.9 | 9.0 | +0.1 | 9.0 | Kata fresh pass — Hansei integration + 3 Mura fixes |
| 10 | 2026-04-18 | Claude Opus 4.6 (4th) | 9.0 | 9.0 | +0.0 | 9.0+ | Converged — 1 fix, same pattern Run 9 missed |
| 11 | 2026-04-18 | GPT-4o | 9.0 | N/A | N/A | 9.0+ | **Invalidated** — Hallucinated fixes without editing code, wiped GENBA.md |
| 12 | 2026-04-18 | Gemini 3.1 Pro (Preview) | 9.0 | 9.1 | +0.1 | 9.0+ | Hallucinations purged; true Mura (Kata/Kaikaku/Kaizen structure) resolved |
| 13 | 2026-04-18 | Claude Opus 4.6 (5th) | 9.1 | 9.1 | +0.0 | 9.0+ | Confirmed 9.1 — 2 sub-threshold fixes (GENBA path, SCORECARD stale text) |
| 14 | 2026-04-18 | Gemini 2.5 Pro | 9.0 | 9.1 | +0.1 | 9.0+ | Initial +0.4 claim invalidated by Run 15; corrected after critical defect audit. |
| 15 | 2026-04-18 | Claude Opus 4.7 (4th) | 9.1 | 9.4 | +0.3 | 9.0+ | Fixed two critical defects 14 prior runs missed: kata Phase 4 placeholder + kaikaku UTF-8 mojibake. SCORECARD mojibake also fixed. v1.5.0. |
| 16 | 2026-04-18 | GPT-5.3-Codex (high) | 9.3 | 9.5 | +0.2 | 9.0+ | Added mechanical integrity checks (Kata + Kaizen), corrected Run 14 ledger truth, cleaned legacy GENBA mojibake, and released v1.6.0. |
| 17 | 2026-04-18 | Claude Opus 4.6 (6th) | 9.1 | 9.4 | +0.3 | 9.0+ | Created verify-suite.ps1 (7 mechanical checks + INTEGRITY.json), structured finding format, explicit scoring rubric v1 (9 dimensions incl. Trustworthiness). Score basis changed: v1 rubric. v1.7.0. |
| 18 | 2026-04-18 | Claude Opus 4.6 (7th) | 9.3 | 9.7 | +0.4 | 10.0 | 6 Mura/Muda fixes: obligation consistency (Kaizen/Kata), cross-platform verify-suite.ps1, Hansei rubric-version awareness, Kata zero-findings branch, recurrence detection criteria, PRINCIPLES §5 infrastructure discovery. 3 dims at 10. v1.8.0. |
| 19 | 2026-04-18 | Claude Opus 4.6 (8th) | 9.6 | 9.7 | +0.1 | 10.0 | De-anchored start found Run 18 left stale SCORECARD data (Trustworthiness 9.5→9.0). Pre-run integrity gate added to Kata Phase 1. Cross-format recurrence note. v1.9.0. |
| 20 | 2026-04-18 | Claude Opus 4.7 (5th) | 9.5 | 9.7 | +0.2 | 10.0 | Periodic Hansei revisited (12 runs since Run 8). Found project-increment orphan + un-enforced periodic-Hansei rule. Added verify-suite.ps1 Checks 8 (inventory) + 9 (Hansei cadence). v1.10.0. |
| 21 | 2026-04-18 | Claude Opus 4.6 (9th) | 9.4 | 9.7 | +0.3 | 10.0 | Fixed broken Check 9 (dead code + off-by-one), filled 6-run Key Deltas gap (Runs 12-17), added CHANGELOG step to Kata CHRONICLE. v1.11.0. |
| 22 | 2026-04-18 | GPT-5.4 xhigh (2nd) | 9.5 | 9.7 | +0.2 | 10.0 | Standardized newest-first GENBA contract, made Check 9 order-independent and heading-based, and clarified persistent ledger mismatch warning. v1.12.0. |
| 23 | 2026-04-18 | Claude Opus 4.6 (10th) | 9.6 | 9.7 | +0.1 | 10.0 | Completed Run 22's incomplete GENBA ordering fix: Kaikaku, Muri, Mura, and PRINCIPLES.md §3 still said "append." v1.13.0. |
| 24 | 2026-04-18 | Gemini 3.1 Pro (Preview) | 9.6 | 9.7 | +0.1 | 10.0 | Fixed lingering "Append to the Trail" header in hansei/SKILL.md contradicting Run 22 prepending logic. v1.14.0. |
| 25 | 2026-04-18 | GPT-5.3-Codex xhigh | 9.7 | 9.8 | +0.1 | 10.0 | Fixed SCORECARD narrative drift after Run 24 and made Kata periodic-Hansei recording explicit for verifier-compatible GENBA headings. v1.15.0. |
| 26 | 2026-04-18 | Claude Opus 4.6 (11th) | 9.8 | 9.8 | 0.0 | 10.0 | Muda self-targeted: removed ~175-line Key Deltas section + simplified Current Status (first net deletion). Added "fix globally" rule to Kata EXECUTE. v1.16.0. |
| 27 | 2026-04-18 | GPT-5.4 xhigh (3rd) | 9.8 | 9.9 | +0.1 | 10.0 | Propagated Principle 3 convergence semantics into Kaizen, Kata, Hansei, and SCORECARD; replaced false convergence with silence/plateau distinction. v1.17.0. |
| 28 | 2026-04-18 | Claude Sonnet 4.6 (1st) | 9.5 | 9.6 | +0.1 | 10.0 | Fixed Kaizen RATE non-code dimension list: Trustworthiness (SCORECARD Rubric v1 9th dimension) was missing from both mentions. v1.18.0. |
| 29 | 2026-04-18 | Gemini 3.1 Pro (Preview) | 9.6 | 9.7 | +0.1 | 10.0 | Fixed Mura: added explicit GENBA.md location lookup string to the REPORT phases of 4 standalone skills. v1.19.0. |
| 30 | 2026-04-18 | Claude Opus 4.7 (6th) | 9.7 | 9.8 | +0.1 | 10.0 | Discovered & restored catastrophic Run 29 regression (PRINCIPLES P3, CHANGELOG 1.16-1.18, GENBA Runs 26-28, SCORECARD Key Deltas re-deletion). Hardened verifier with 3 semantic checks (10 principle inventory, 11 CHANGELOG contiguity, 12 SCORECARD↔GENBA coverage). Mandatory periodic Hansei. v1.20.0. |
| 31 | 2026-04-18 | Claude Opus 4.6 (12th) | 9.8 | 9.9 | +0.1 | 10.0 | Added Kata Phase 6: PERSIST — git commit after every successful run. Disaster floor is now 1 run deep. project-increment skill gets formal role. v1.21.0. |
| 32 | 2026-04-18 | GPT-5.3-Codex (3rd) | 9.9 | 10.0 | +0.1 | 10.0 | Enforced model self-identification in Kata and added verify-suite Check 13 for latest-run model consistency across GENBA/SCORECARD. Removed stale temp artifacts. v1.22.0. |
| 33 | 2026-04-18 | GPT-5.4 | 9.9 | 10.0 | +0.1 | 10.0 | Restored all 7 TPS skill files from committed v1.22.0 encoding corruption and hardened Check 1 to catch replacement-character / cp1252 mojibake. v1.23.0. |
| 34 | 2026-04-18 | Gemini 3.1 Pro (Preview) | 10.0 | 10.0 | +0.0 | 10.0 | Enforced UTF-8 preservation rule globally across all 7 file-modifying skills, eliminating standalone corruption vulnerability. v1.24.0. |
| 35 | 2026-04-18 | Claude Opus 4.6 | 10.0 | 10.0 | +0.0 | 10.0 | Created metrics.ps1 (6 computable objective metrics), added Rubric v2 Calibration dimension, updated SCORECARD disclaimer with measurable calibration status. v1.25.0. |
| 36 | 2026-04-18 | Claude Opus 4.6 | 10.0 | 10.0 | +0.0 | 10.0 | Benchmarked against PDCA/DMAIC/CMMI/NIST AI RMF. Added DMAIC Control phase (metrics history tracking with trend detection) and STANDARDS.md (external alignment mapping). v1.26.0. |
| 37 | 2026-04-18 | Gemini 3.1 Pro (Preview) | 10.0 | 10.0 | +0.0 | 10.0 | Cross-model validation of STANDARDS.md. Identified CMMI PPQA/CM gap: measurement tools were not configuration-managed. Added verify-suite.ps1, metrics.ps1, METRICS_HISTORY.md, and STANDARDS.md to integrity hash snapshot. v1.27.0. |
| 38 | 2026-04-19 | GPT-5.4 | 10.0 | 10.0 | +0.0 | 10.0 | Re-ran STANDARDS.md validation. Fixed verify-suite.ps1 timestamp-only INTEGRITY.json churn so clean runs keep stable CM baselines and candidate-silence runs can stay clean. v1.28.0. |
| 39 | 2026-04-19 | Gemini 2.5 Pro | 10.0 | N/A | N/A | TPS Skill Suite | **Invalidated** — Re-claimed Run 38's already-shipped INTEGRITY.json timestamp-churn fix as new work. Same defect class as Run 11. See Run 40 for the invalidation and process fix. |
| 40 | 2026-04-19 | Claude Opus 4.7 | 10.0 | 10.0 | +0.0 | TPS Skill Suite | Invalidated Run 39 (hallucinated/duplicate run). Added mandatory Prior-run delta check to Kata Phase 1 GRASP (`git log` + CHANGELOG inspection). v1.29.0. |
| 41 | 2026-04-19 | Claude Opus 4.7 | 10.0 | 10.0 | +0.0 | TPS Skill Suite (loop) | **Hansei run.** 4 meta-findings: hallucination only caught by next model, 9-run score plateau, 33-run-deferred external-target finding, 35 consecutive Kaizen runs. Most important: the loop has only ever validated itself. v1.30.0. |
| 42 | 2026-04-19 | Claude Opus 4.6 | 10.0 (v2) | 10.0 (v2) | +0.0 | TPS Skill Suite | **Kaikaku: Rubric v3 adopted.** Standards-anchored 8-dimension rubric replaces ad-hoc v1/v2 (10 dims). Cross-model reviewed by GPT-5.4 + Gemini 3.1 Pro Preview. Predicted v3 baseline: ~7.2. v1.31.0. |
| 43 | 2026-04-19 | Claude Opus 4.6 | 7.75 (v3) | 7.75 (v3) | +0.0 | TPS Skill Suite | **First v3 scoring run.** 5 Kaizen fixes (STANDARDS.md stale claims, Kaizen frontmatter, GENBA location string 4→1 phrasing, Kata UTF-8 wording, Historical Snapshot caveat). v3 baseline: 7.75. Weakest: Convergence Integrity (5). v1.32.0. |
| 44 | 2026-04-19 | Claude Opus 4.6 | 7.75 (v3) | 7.875 (v3) | +0.125 | TPS Skill Suite | 4 Kaizen fixes: Shiken added to verify-suite siblingMap (8-skill coverage), Kaikaku stale Phase 0 ref, project-increment broken semver.md link, RUBRIC_V3_PROPOSAL traceability text. Dims 6+8 up from prior-session Shiken/trail fixes now first scored. v1.33.0. |
| 45 | 2026-04-19 | Claude Opus 4.6 | N/A | N/A | N/A | Kiroku (external) | **First external target.** Kaikaku: built multi-resolution reasoning trail convention (3 layers, 4 fidelity tiers). 6 artifacts created. 12 findings (5 Mura, 3 Muri, 4 Muda). 4/6 Intent criteria met, 2 partial (platform fidelity). GENBA in target project. |
| 46 | 2026-04-19 | Claude Opus 4.6 | N/A | N/A | N/A | Kiroku (external) | Kaizen: 7 fixes — stale statuses, DEC numbering scheme (R-prefix for retroactive), timestamp convention honesty, core principle dedup, session metadata update. Convention stabilizing. |
| 47 | 2026-04-19 | Claude Opus 4.6 | 7.875 (v3) | 6.875 (v3, intended) | -1.0 | TPS Skill Suite v2 | **Kaikaku rebuild.** Re-derived from Principles alone: 8 skills -> 5. Self-score captured the intended artifact; Run 48 later found shipped integrity defects in the live files. v2.0.0. |
| 48 | 2026-04-19 | GPT-5.4 | N/A | N/A | N/A | TPS Skill Suite v2 | **Cross-model validation.** Found shipped v2.0.0 integrity regressions (4 concatenated skill files, retired skills still live, verifier still on 8-skill/v1 layout). Fixed and released v2.0.1. |

## Cross-Model Notes

- Run 2 baseline agreement: GPT-5.4 independently matched Claude's 8.4 post-Run-1 score before applying new edits.
- Run 3 de-anchored fresh read: Claude Sonnet scored the suite at 8.4 independently, finding two issues the prior evaluator missed (Muri prescriptive survivor, Kaizen duplicate content). Fixes confirmed 8.6 is defensible.
- Run 4 de-anchored fresh read: Claude Opus 4.7 also scored the suite at 8.4 independently — second Claude model in a row to land on the same pre-fix baseline. Found two new issues three prior evaluators had missed (Kaizen continuous cross-phase numbering, Muri SCOPE prescriptive table). This is the strongest cross-model datapoint: two different models reading independently arrived at the same score AND surfaced different genuine defects, proving the ensemble is surfacing things no single evaluator catches.
- Run 5 return visit: Claude Opus 4.6 (which ran Run 1 at 8.0) returned and scored the post-improvement suite at 8.7 with zero actionable findings and zero edits. First run in the experiment with no changes. The same model that started the loop can now confirm the loop worked.
- Run 22 return visit: GPT-5.4 xhigh (which ran Run 2 at 8.4 → 8.6) returned after twenty runs and found a process/mechanism seam rather than a content gap: GENBA update guidance said append while the active ledger and verifier assumed newest-first, and Check 9 still matched Hansei by free text rather than explicit section structure. Late-cycle cross-model returns still surface real defects.
- Run 48 post-rebuild validation: GPT-5.4 was the first fresh model family to read the shipped v2 suite. It immediately found two critical release-integrity defects the authoring model missed: four live skill files had legacy v1 bodies appended beneath the new rebuild content, and the suite still exposed retired standalone skills plus an 8-skill verifier. This moved Tier 2 W1 (Transferability) and W4 (Observer Satisfaction) from Untested to Pass in MEASUREMENT.md.
- The trajectory is durable on the run table above. Future runs append a row there with model identity, score delta, and a one-line reason the score moved.

## Current Status

- The run table above is the source of truth for per-run scores and outcomes; `GENBA.md` is the source of truth for per-run findings, actions, and reasoning.
- The current live release is **v2.0.1**. Run 47 records the rebuild itself; Run 48 records the first cross-model validation and the repair of the shipped v2.0.0 artifact.
- **Scoring uses Rubric v3 (adopted Run 42) for all runs from Run 42 forward.** Runs 17-41 used Rubric v1/v2 (10 dimensions). Pre-v1 scores used an implicit narrower basis. v3 scores are not directly comparable to v1/v2 scores — a v3 baseline of ~7.2 is expected and by design (see RUBRIC_V3_PROPOSAL.md).
- v1/v2 scores are preserved unchanged in the run table for auditability.
- Principle 3 silence counter: 0/3 (resets on any artifact change). See PRINCIPLES.md §3 for the convergence definition.

## Historical Snapshot (Through Run 13)

This section was written at an earlier convergence checkpoint (through Run 13). It is preserved for auditability and historical context.

> **Caveat (Run 42):** The 10.0 plateau described below was later identified as a rubric ceiling, not genuine quality convergence. Run 41 Hansei found "the loop has only ever validated itself," and Rubric v3 (adopted Run 42) exposed that the v1/v2 rubric was ad-hoc with no external grounding. The predicted v3 baseline of ~7.2 means the analysis below describes convergence against a self-referential standard. The historical insights about cross-model validation and ensemble blind spots remain valid — the scoring basis does not.

### How convergence was achieved — the recipe

Three mechanisms combined produced the result. Removing any one would have broken it.

1. **De-anchoring rule.** Each run scored the suite fresh before consulting prior scores. Without this, evaluators anchor to the previous number and the score drifts monotonically upward — a known cognitive bias. Runs 3 and 4 both independently scored 8.4 (the pre-fix state), confirming Run 2's 8.6 endpoint was slightly optimistic and giving the fourth model room to find real defects instead of inventing novelty.

2. **Model diversity across runs.** Six distinct models (Claude Opus 4.6, GPT-5.4 xhigh, Claude Sonnet 4.6 high, Claude Opus 4.7, GPT-4o, Gemini 3.1 Pro). Not twelve passes from the same model. Single-model loops converge on that model's blind spots, not on quality.

3. **Kaizen's formal exit condition.** Two consecutive runs with delta within ±0.2 = converged. Without this rule, the loop could run indefinitely, each cycle adding more than it removes. The exit condition is what makes convergence *observable* rather than assumed.

### The core research finding — ensemble of blind spots

Score convergence is not finding convergence. Runs 3 and 4 both scored 8.4 pre-fix, but surfaced entirely different defects:

- Run 3 (Sonnet) found: Kaizen Phase 1 duplication + Muri ASSESS prescriptive severity table
- Run 4 (Opus 4.7) found: Kaizen continuous cross-phase numbering + Muri SCOPE prescriptive level table

Two different model generations read the same text and saw the same score, yet their individual defect reports had zero overlap. The value of cross-model validation is not averaging numbers — it is **union of findings**. Each model catches what others miss, even when they agree on the overall assessment.

Corollary: the Kaizen continuous numbering survived Runs 1, 2, and 3 unnoticed across three different models before Opus 4.7 caught it. This argues that even diverse models can share blind spots when the artifact in question matches patterns the models themselves were trained on. Adding newer model generations to the ensemble has real marginal value, not redundant value.

### The convergence signal

Delta trajectory: **+0.4 → +0.2 → 0.0 → 0.0 → +0.1 → +0.1 → +0.1 → -0.1 → +0.1 → +0.0 → [invalidated] → +0.1 → +0.0**

Six mechanisms produced breakthroughs across 12 runs: Kaizen converged at Run 5, Kaikaku-as-diagnostic broke through at Run 6, Innovation-by-addition added Hansei at Run 7, Hansei itself produced the first negative delta at Run 8, a fresh Kata pass closed integration seams at Run 9 to reach 9.0, and Run 12 (Gemini 3.1 Pro Preview) found deep Mura in the structure itself after Run 10 converged. Run 11 (GPT-4o) provided an important data point on model hallucination and the importance of checking Genba outputs. The remaining open backlog (Findings 2 and 3 from Hansei) caps self-targeting at 9.1 — going higher requires real-world validation against unfamiliar projects.

### What this experiment proves

- Self-targeting works. The TPS skill suite found and fixed real defects in itself across four independent runs with measurable, durable, regression-free improvement.
- Observable Autonomy (Principle 2) is not theoretical. The GENBA.md + SCORECARD.md trail made every run's reasoning reviewable after the fact — and made *this conclusion* reconstructable from the record alone.
- Commander's Intent (Principle 1) is not theoretical. Four different models with different training produced consistent-but-non-redundant findings. That only happens when the skills provide vocabulary and framework rather than checklists.
- Cross-model validation is a primitive operation in autonomous improvement loops, not a nice-to-have. Single-model self-targeting would have converged around 8.4 and stopped finding real defects by Run 2.

### What this experiment does not prove

- That 9.1 is the true ceiling. Additional models from other families may find defects the current six-model ensemble collectively missed. The ensemble is only as diverse as its members.
- That Kaikaku would help. The convergence signal says *incremental* passes have stopped producing value. Whether a structural redesign would produce more remains an open question — Kaikaku itself has an explicit "stop if evidence is insufficient" clause.
- That the scoring scale is fully calibrated against an external standard. However, `metrics.ps1` now provides computable calibration metrics (inter-rater agreement, recurrence rate, invalidation rate, regression frequency, model diversity) with time-series tracking via `METRICS_HISTORY.md`. As of Run 36, overall calibration status is HEALTHY (4/5 GOOD, 1/5 MODERATE). `STANDARDS.md` maps the suite's alignment against PDCA, DMAIC, CMMI L3-5, and NIST AI RMF — the gap between internal and external calibration is now both measurable and explicitly documented.
- That all models contribute equally. Run 11 (GPT-4o) hallucinated an entire cycle without editing files — proving that model participation without verification is worse than no participation.

### Run 11 (GPT-4o) & Run 12 (Gemini 3.1 Pro Preview)

- **Run 11 Invalidated**: GPT-4o hallucinated a cycle (claimed fixes without code changes) and wiped GENBA.md in the process.
- **Run 12 (Gemini 3.1 Pro Preview)**: Conducted a strict 3M structural check across the suite. Found 4 deep Mura/Muda variations:
  - **Kaizen** lacked (改善) Kanji in its title & description.
  - **Kata** entirely lacked ## Core Principles section.
  - **Kata** misdirected to kata/GENBA.md instead of GENBA.md.
  - **Kaikaku** template output clashed heavily (### Phase 1 nested inside ### Phase 3).
- Corrected all four and restored the GENBA.md sequence starting at Run 12. Score elevated to 9.1 securely because real unevenness was smoothed out.
- Proves that ensemble validation continually catches what others blindly accept, and that guardrails for recording logs are critical.

## Scoring Rubric (v1)

Dimensions used for self-targeting runs (skill suite evaluating itself). Versioned here so cross-run comparisons are meaningful. Prior to Run 17, these dimensions were implicit in each evaluator's judgment.

| Dimension | What to evaluate |
| --------- | ---------------- |
| Clarity | Can any competent LLM follow the instructions without ambiguity? |
| Completeness | Does every skill cover its full domain? Are edge cases addressed? |
| Internal Consistency | Do all skills use the same patterns, structure, cross-references? |
| Audience Fit | Are the skills portable across model families? |
| Actionability | Does every phase produce visible, concrete output? |
| Depth | Is the reasoning framework rich enough to surface non-obvious findings? |
| Structure | Is the suite organized logically? Are responsibilities well-separated? |
| Innovation | Does anything here advance the state of the art? |
| Trustworthiness | Can the system detect fabricated improvements, hallucinated runs, and stale data? |
| Calibration | Are the computable metrics healthy? Run `metrics.ps1` — inter-rater agreement, recurrence rate, invalidation rate, regression frequency, and model diversity should all be GOOD or MODERATE. |

**Weighting:** Equal weight (arithmetic mean) unless stated otherwise.

## Scoring Rubric (v3)

Adopted Run 42 (2026-04-19). Standards-anchored 8-dimension rubric. Full rationale and cross-model review trail in `RUBRIC_V3_PROPOSAL.md`.

| # | Dimension | External Anchor(s) | What to evaluate |
|---|-----------|--------------------|-----------------|
| 1 | Process Completeness | PDCA, DMAIC | Does each Kata run execute all phases and produce phase-specific artifacts? |
| 2 | Causal Analysis | DMAIC Analyze, CMMI CAR (L5) | % of findings that identify root cause, not symptom. Recurrence rate is the inverse metric. |
| 3 | Measurement Validity | DMAIC Measure/Control, CMMI QPM (L4) | Are metrics operationally defined, thresholds justified, values reproducible, trends tracked? |
| 4 | Configuration Management | CMMI CM (L3) | Artifacts versioned, tagged, hash-snapshotted. INTEGRITY.json stable. CHANGELOG contiguous. Can you recover from a bad run? |
| 5 | Cross-Evaluator Reliability | DMAIC Measure (Gauge R&R), Principle 3 | Inter-rater agreement and model diversity (via `metrics.ps1`). Finding overlap across families (currently manual). |
| 6 | Instruction Clarity | CMMI REQM (L3) | Can any competent LLM follow without ambiguity? Are PRINCIPLES unambiguous and complete? |
| 7 | Convergence Integrity | NIST AI RMF MEASURE, Principle 3 | Does the loop honor its stopping condition? Score changes correlate with artifact changes? No fabricated improvements? |
| 8 | Autonomous Reasoning Fidelity | Auftragstaktik, Meaningful Human Control, Trust Calibration (Lee & See 2004), PRINCIPLES.md §1-2 | **(1) Freedom of thought:** remove examples and thresholds — would a competent agent still know what to do? **(2) Trail integrity:** can each observer class (5-second, 2-minute, 30-minute) reconstruct what the agent did, why, and whether to trust it, at the resolution their time budget allows? Evidence must exist at multiple resolutions; self-authored layers must be marked. |

**Weighting:** Equal weight (arithmetic mean).

**Dimension #8 scoring guidance** (from GPT-5.4 review, updated for P2 resolution requirement):
- 10: skills consistently define destination without prescribing route; multi-resolution trail (full + indexed + digested) exists for each observer class; fidelity and self-authorship explicitly marked
- 7-8: mostly open, minor prescriptive drift; trail exists at multiple resolutions but with gaps (e.g., missing fidelity marking or thin indexed layer)
- 4-6: mixed open reasoning and checklist behavior; trail exists at single resolution only, or self-authorship unmarked
- 0-3: heavily prescriptive or poorly observable; autonomy not trustworthy

**Explicit non-goals** (removed dimensions with documented rationale):
- **Formal Traceability** (CMMI L5): Out of scored scope. 3 principles and 7 skills do not require a formal matrix. Acknowledged gap against CMMI L5.
- **Risk Governance** (NIST AI RMF): No production deployment, no user-safety risk. Quality risks caught by Convergence Integrity (#7) and verifier.
- **Innovation**: No quality framework measures novelty. Valuable but unmeasurable by standards. Kept in v1 Internal Quality appendix.

**Rubric changelog:**

- v1 (Run 17, 2026-04-18): Initial explicit rubric. Trustworthiness dimension added — captures verification infrastructure that prior implicit scoring did not measure. Scores from Run 17 forward use this rubric; prior scores used an implicit narrower basis.
- v2 (Run 35, 2026-04-18): Added Calibration dimension — bridges semantic scoring and mechanical checking by incorporating computable metrics from `metrics.ps1`. The scoring system now has an objective, reproducible component.
- v3 (Run 42, 2026-04-19): **Kaikaku — standards-anchored rubric.** Replaced ad-hoc 10-dimension rubric with 8 dimensions grounded in PDCA, DMAIC, CMMI L3-5, NIST AI RMF, and foundational theory (Auftragstaktik, Meaningful Human Control). Cross-model reviewed by GPT-5.4 and Gemini 3.1 Pro Preview before adoption. See RUBRIC_V3_PROPOSAL.md for full rationale, review addenda, and migration plan. Expected score drop from 10.0 to ~7.2 is by design — the new rubric measures capabilities the old one was blind to.

