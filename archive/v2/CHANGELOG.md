# Changelog

<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to a custom versioning scheme.

## [Unreleased]

## [2.11.1] - 2026-04-22

### Changed

- **SCORECARD reset to allow the v2.11.0 protocol to be exercised on a clean slate.** The previous Rubric v4 (six dimensions D1–D6, derived in Run 87) was laid by a single evaluator family (Claude) before v2.11.0 existed. With v2.11.0 in place, the immediate next Kata cycle on this target should be by a distinct evaluator family — but if that family reads a fully-populated SCORECARD during Grasp, the cold-derivation hygiene cannot bite and the consolidation outcome is structurally biased toward `convergent (no addition)`. The reset removes the single-family anchor so the next evaluator can derive cold; the run after that is then the first genuine test of additive consolidation against a rubric that itself was laid under the protocol.
- **Pre-reset state preserved.** Rubric v4 dimensions, scoring rationales, Runs 87–88 ledger, and Dimension Trajectory moved verbatim to `TRAIL/SCORECARD_ARCHIVE_v4_pre-protocol.md`. Earlier v3 history (Runs 1–86) remains at `TRAIL/SCORECARD_ARCHIVE_v3.md`. Runs 87–88 marked `**Invalidated**` in the live ledger so verify-suite Check 5 / Check 12 handle them via the existing invalidation path — no script changes needed.
- **No skill behavior changes.** This is a state-of-the-suite change, not a skill-content change. Skill files remain at v2.11.0.

### Why this is a patch and not a major

The reset does not retract or contradict v4's measurement work — it stages the rubric so that the v2.11.0 mechanism (which itself is unchanged) can produce evidence it has never produced. v4 is preserved as a candidate input that the next post-reset run will compare against.

## [2.11.0] - 2026-04-22

### Changed

- **Sequential additive rubric consolidation (Kata Step 1).** Replaced the looser "Re-derivation on evaluator-family change" subsection with an additive consolidation protocol. Re-derivation now produces exactly one of four labelled outcomes — `convergent (no addition)`, `convergent with refinement`, `divergent (additive)`, `divergent (contradictory)` — each with a defined marker convention (`[!DECISION]` for refinements and additions, `[!REVERSAL]` for retirements). Divergent-additive findings must be merged into the rubric **this run**, not deferred to "a future run." Family-vs-version is defined: family change requires re-derivation; same-family different-version recommends but does not require it.
- **Rubric Provenance ledger.** New section in `SCORECARD.md` listing each Rubric v4 dimension with its contributing family-version, originating run, and rationale. Future divergent-additive runs extend the table; divergent-contradictory runs mark rows retired. Makes the rubric's evolution legible to the deployer-class observer who asks *"which families have shaped this rubric?"*
- **Cold-derivation hygiene.** Documented as recommended protocol: derive your own measurement list before studying the existing rubric, then compare. The engine cannot enforce blindfolding; the protocol is what we can ship.
- **Background:** This is the chosen mechanism after a feasibility investigation into the parallel cross-model relay (Intent/Grasp/Measurement rotated across three model families). The relay is achievable today only as a manual human-as-courier protocol — not engine-orchestratable. Sequential additive trades the relay's full upstream-blind-spot protection for ~1× cost vs ~9× cost per evaluation, while still ending the prior single-family-derives-and-others-inherit pattern.

All 6 skills bumped 2.10.0 → 2.11.0. No skill behavior changes outside Kata Step 1.

## [2.10.0] - 2026-04-22

### Changed

- **Manifesto Externalization:** The theoretical foundation of the framework (`PROBLEM.md` and `PRINCIPLES.md`) has been extracted to an external, independent repository (`c:\git\manifesto\`). The previous architecture forced the TPS suite's tool-specific scorecard to evaluate the framework's overarching theory, conflating implementation details with constitutional principles. The suite now consumes the Manifesto as external Commander's Intent rather than owning it.
- **Rubric v4 (Derived Scheme):** The SCORECARD has been reset and thoroughly re-derived using the new external Manifesto as ground truth. The conflated Rubric v3 has been archived (`TRAIL/SCORECARD_ARCHIVE_v3.md`). 
  - **Six New Dimensions:** D1 Intent Fidelity, D2 Resolution Coverage, D3 Convergence Integrity, D4 Transferability, D5 Artifact Integrity, D6 ARF Evidence.
  - **Anchored to Delegability:** The new dimensions directly assess the four-question deployer delegability test from the Manifesto.
  - **Metrics Alignment:** P3 counter reset to 0/3.

All 6 skills bumped 2.9.0 → 2.10.0. No skill-behavior changes. Minor version bump for major architectural decoupling and measurement substrate reset.

## [2.9.0] - 2026-04-21

### Changed

- **`PROBLEM.md` rewritten from intent.** Structural rewrite, substance preserved. Six divergences from the previous architecture, actioned:
  1. **Front-loaded the two-sentence problem statement.** "The Problem In Two Sentences" is no longer buried at the bottom — moved into the Digest at the top, along with the rest of a 60-second summary. A reader now sees the destination before the route.
  2. **Applied Principle 2's resolution requirement to the document itself.** Added Digest (full, indexed summary) and an Index section, so practitioner/deployer/regulator/liability-bearer reading budgets are all served by the same file. The document now practices what it prescribes.
  3. **Promoted "Who the Evidence Must Serve" (the five observers) earlier.** Previously deep inside the document; now directly after Delegability. The five-observer taxonomy is the clearest expression of what "earned autonomy" means operationally, and it belongs before the "what existing work solves" comparison, not after.
  4. **Sharpened "delegability" with a four-part operational test.** Previously named but semi-circular ("the operational discipline of converting demonstrated, visible, situated reasoning into bounded, revocable authority"). Now paired with four questions each observer class asks from the trail: visibility at my resolution, situatedness, bounded scope, revocability. A single "no" narrows scope — the framework functioning correctly, not failing.
  5. **ARF defined canonically in PROBLEM.md; PRINCIPLES.md cross-references it.** ARF had overlapping definitions in both files. PROBLEM.md is now the conceptual home ("what the framework measures"); PRINCIPLES.md holds the operational definition (preconditions, situational discrimination, validation test) with a cross-reference up.
  6. **Tightened prose throughout.** Removed repetition between "How the Principles Address Both Problems" and later ARF sections. No substance removed; same claims, fewer passes through them.

- **`PRINCIPLES.md` rewritten from intent.** Same preserve-substance, restructure-architecture discipline:
  1. **Digest at top.** One-paragraph summary of all three principles + ARF. Same multi-resolution logic as PROBLEM.md.
  2. **Principle 3 re-symmetrized to match Principles 1 and 2.** Previously P3 opened with a compound operational paragraph while P1 and P2 opened with single statements. Now P3 opens with one sentence at the same abstraction level, and the three operational conditions are pushed into a "The test" subsection — matching P1's "The test" and P2's resolution requirement structure.
  3. **ARF section reframed as operational definition.** Cross-references PROBLEM.md for the conceptual definition. Content preserved: theoretical anchors (Auftragstaktik, Meaningful Human Control, Lee & See), preconditions (freedom of thought, trail integrity), situational discrimination, P3 validation, implementation note, why-this-matters-for-scoring.
  4. **Tool prescriptions moved to STANDARDS.md.** "For skill authors" item 5 previously listed `verify-suite.ps1`, `INTEGRITY.json`, `SCORECARD.md` as part of a document that opens with "they are not guidelines — they are architectural constraints." Tool prescriptions are neither architectural nor constraints; they are this suite's implementation of the constraints. They now live in a new "Suite tooling — when and how" section at the top of STANDARDS.md. PRINCIPLES.md "For skill authors" closes with a pointer to STANDARDS.md.
  5. **Context pointer to PROBLEM.md added at top.** The document previously stood alone; in practice it requires PROBLEM.md context. Now explicit.

- **`STANDARDS.md`: new "Suite tooling — when and how (for skill authors)" section.** Consolidates the tool-prescription content removed from PRINCIPLES.md. Lists `verify-suite.ps1`, `INTEGRITY.json`, `metrics.ps1`, `METRICS_HISTORY.md`, `SCORECARD.md`, `GENBA.md`, `kiroku/` — when to run, what they check, fidelity level. Includes the "these are one implementation, not the specification" framing.

All 6 skills bumped 2.8.2 → 2.9.0. No skill-behavior changes. Minor version (not major) — substance of principles unchanged, only the architecture of the documents was restructured.

### Rationale

The prompting context for this run: user's previous turn asked whether, understanding the intent behind PROBLEM.md and PRINCIPLES.md, the agent would write them the same way. Agent answered no and named 6 divergences. User (this turn) asked for the rewrite, explicitly to enable cross-model verification (Principle 3). Kata was the correct discipline — doctrinal change to the constitutional layer — but Step 0 (Intent) and Step 2 (Diagnose) were already done from the prior turn, so the cycle compressed to Execute → Record → Persist → Verify.

### Verification pending

This release exists primarily to be evaluated by a different model family. The human explicitly stated the intent to verify with another model. Principle 3 convergence is not yet claimed — only an intent rewrite ready for independent assessment. The next cross-family evaluator should re-derive the measurement scheme from the rewritten artifacts and report convergence or divergence with the inherited scheme, per P3's independent-assessment condition.



### Changed

- **`intent/SKILL.md`: Kata-on-intent Run 85 refinements.** First Kata cycle scoped to the newborn intent skill. Five findings actioned:
  - **Frontmatter `argument-hint` updated.** Previously claimed "Automatic — not invoked explicitly," which contradicted the Kata Step 0 and standalone-invocation paths documented in v2.8.1. Now reflects the three actual invocation modes.
  - **"Extract" section de-checklisted.** Previous phrasing "answer three questions" framed the probes as a fixed list — the exact shape Principle 1 warns against. Rewritten so the three probes are presented as vocabulary and examples, not required items, with explicit "these are probes, not a checklist" framing. The skill teaching P1 now embodies P1 in its own structure.
  - **"Narrate" redundant checklist removed.** The "minimum content" list partially overlapped with Extract's probes and risked compliance-shaped narration. Replaced with a destination-level statement: enough content for the user to catch a wrong interpretation cheaply.
  - **Naming collision resolved.** "Standalone invocation" (within TPS, outside Kata) and "Standalone Use (outside TPS)" (porting) shared the word "standalone" for two different concepts. Renamed to "Inside Kata" / "Outside Kata, inside TPS" / "Porting Outside TPS" for sharp disambiguation.
  - **"Porting Outside TPS" expanded.** Previously two sentences. Now operational: lists the specific cross-references to replace, what the "kiroku session's Intent section" maps to in non-TPS environments, and which sections can be dropped without loss of meaning.

All 5 skills bumped 2.8.1 → 2.8.2 for suite-version alignment. No other skill behavior changes.

## [2.8.1] - 2026-04-21

### Changed

- **`kata/SKILL.md`: Intent integrated as Step 0 of the cycle.** Before "Grasp the Situation," every Kata run now begins with Intent extraction applied to the triggering prompt. Interpretation goes into the kiroku session's Intent section verbatim. If the interpretation changes what the target is, Step 1 operates on the corrected target. Closes the gap where Kata would operate on the literal target name without first verifying what the requester actually wanted.
- **`intent/SKILL.md`: explicit standalone invocation path.** Documents that Intent can be invoked independently of Kata — any substantive conversation benefits from the extract/narrate/check-gap sequence, with the narration going into the conversation rather than a session file. Same pattern as kiroku being usable outside a Kata cycle.

## [2.8.0] - 2026-04-21

### Added

- **New skill: `intent/SKILL.md`.** A meta-skill that applies Commander's Intent (Principle 1) in reverse: the agent interprets the user's prompt rather than executing it literally. Operationalizes what was previously implicit — Principle 1 covered how skills should address the agent, but not how the agent should address imprecise user prompts. The skill requires three things before work begins: extract what the user actually wants (not the verb they used), narrate the interpretation visibly, and name the divergence between literal and interpreted. Designed to be shareable standalone — references the TPS Principles for grounding but does not require the other skills to be present. Does not participate in the cross-reference sibling requirements because it operates above the other skills, not alongside them. Added to verify-suite Check 1/2/4/6/8 (same mechanical integrity as other TPS skills) but not Check 3 (cross-references).

### Changed

- All skills bumped to v2.8.0 to reflect the suite addition.

## [2.7.1] - 2026-04-21

### Fixed

- **`TRAIL/GENBA.md`: 249-line mojibake block repaired.** The runs 51-60 era contained UTF-8 double-encoded em-dashes, arrows, en-dashes, and a handful of less common sequences. Deferred through Runs 82 and 83 as "pre-existing, scope-limited." Repaired in Run 84 via targeted Unicode sequence replacement: 208 em-dashes (`0x00E2 0x20AC 0x201D` → `—`), 56 arrows (`0x00E2 0x2020 0x2019` → `→`), 7 en-dashes, and 4 single-instance artifacts (↑, ↔, ‰, ≥). Two remaining occurrences on line 57 were backtick-quoted literal examples describing the mojibake itself — rewritten as prose so the documentation of the bug no longer reproduces the bug. verify-suite Check 1 now reports 0 encoding failures (was 249).

### Changed

- **`kata/SKILL.md` Step 2 (Diagnose): holistic-scan discipline added.** Previously the Diagnose phase's default scope was implicitly the current change. After three consecutive change-scoped runs (typical pattern for a loop that's finding small incremental fixes), the next run must treat the whole artifact as the target. Two explicit signals for this: sustained plateau combined with active external criticism, and tooling results the loop has stopped interrogating (persistent warnings, deferred findings, ignored metrics). Root cause: Run 83's near-convergence score was partly built on Kata evaluating what it changed rather than what accumulated. The 249-line mojibake block and other structural debt were not seen because no run's scan included them — each run verified its own change was clean and moved on. A holistic scan that finds nothing is still a valid diagnosis; a change-scoped scan that finds nothing is not.

All 5 skills bumped to v2.7.1 to reflect the Kata behavior change.

## [2.7.0] - 2026-04-21

### Changed

- **`PRINCIPLES.md` Principle 3: independence now extends to measurement-scheme derivation, not just scoring.** Previously, Condition 3 required each evaluator to score independently, but the measurement scheme itself was derived by the first run and silently inherited by all subsequent runs. This left a single-point-of-failure: if the deriving family had a blind spot in choosing *what to measure*, subsequent scoring convergence would reflect that blind spot rather than artifact quality. New requirement: a genuinely independent evaluator re-derives the measurement scheme from the target before scoring. Re-derivation convergence validates the scheme; divergence is itself a finding. Pre-agreed externally anchored rubrics are exempt from re-derivation but not from the divergence-as-finding rule. The minimum convergence bar updated accordingly: 3 runs, 3 distinct evaluator families, same score, zero changes, **and at least one re-derivation that converged**.
- **`kata/SKILL.md` Step 1: re-derivation protocol.** When the current evaluator family differs from the family that derived the inherited scheme, re-derive independently and compare. Three recorded outcomes: `Re-derivation: convergent` (validates the scheme), `Re-derivation: divergent` (records the blind spot as a finding), `Re-derivation: inherited (same family)` (no cross-family validation this run — defers the check). External rubrics remain inheritable.
- **`kata/SKILL.md` Convergence section: aligned with the new P3.** Condition 3 now requires that at least one of the three evaluators have re-derived the measurement scheme and found it convergent with the inherited scheme.

Root cause for the gap: P3 originally treated the measurement scheme as fixed infrastructure ("what is being measured") rather than as an evaluator-dependent derivation ("what this family decided to measure"). For externally anchored rubrics this distinction was invisible; for derived schemes it meant one family's framing propagated unchallenged through the convergence chain. The fix closes the loop without breaking existing runs on external rubrics.

## [2.6.3] - 2026-04-21

### Added

- **`kaizen/SKILL.md`: per-phase output narration requirements.** Three additions make Observable Autonomy explicit at the phase level rather than only at the run level (GENBA):
  - **Diagnose:** Agent must narrate per-lens before moving on — state each lens name, what was examined under it, and what was found. Additional context-specific lenses beyond the three canonical ones (Unevenness, Overburden, Waste) are explicitly encouraged and must also be named and reported.
  - **Challenge Blind Spots:** Agent must surface each blind-spot question and answer it explicitly before moving to Prioritize. "I asked X; it revealed nothing" is more trustworthy than silence.
  - **Prioritize:** Agent must show the ranked findings with a one-sentence rationale for each rank position before implementing.
  Root cause for the gap: the Evidence section captured what *should be in the session record* but did not require phase-by-phase visible output during execution. A human observing a live run could not see the reasoning at each phase transition.

## [2.6.2] - 2026-04-21

### Fixed

- **`kata/SKILL.md` Step 1: inheriting-scheme example de-prescripted.** The short-form example previously read `"Inheriting Rubric v3 — no revision."` — a target-specific rubric name hardcoded as the canonical form, implying it is the universal default. Replaced with `"Inheriting [target's scheme name] — no revision."` and added a clarifying parenthetical naming Rubric v3, M1–M7, and bespoke schemes as equivalent, target-derived examples. Root cause: example was written when the suite self-targeted only; became prescriptive by implication once external targets were added. P1 (Commander's Intent) compliance. (Run 81)
- **`PRINCIPLES.md` Principle 3 Condition 1: added causal reasoning for same-family independence rule.** After "Same-family evaluators count as one," added the root-cause explanation: each model family develops habituated blind spots from prior runs; a different family does not share them. This is why the value is independent reviews, not more reviews. Ports the clearest normative clarification from the public manifesto into the canonical specification. (Run 82)
- **`TRAIL/GENBA.md`: removed two duplicate Run 79 entries.** Three identical Run 79 entries accumulated from separate conversation passes. Kept the first (backtick-formatted) entry; removed the two duplicates that followed. (Run 82)

## [2.6.1] - 2026-04-21

### Fixed

- **`metrics.ps1` Metric 7: Require `(silence)` Result marker in addition to zero delta for P3 silence chain.** Metric 7 previously used `delta=0` as the only criterion for P3 silence. Zero-delta action runs (e.g., CM fixes, sub-threshold housekeeping with no score movement) were counted as silence votes, generating a false DRIFT warning. Root cause: P3 requires zero artifact changes in addition to zero score delta; `(silence)` in the SCORECARD Result column is the SCORECARD-detectable proxy for "zero artifact changes." Fix: walk now breaks on zero-delta rows without the `(silence)` marker, treating them as chain-breakers rather than silence votes. Updated Metric 7 comment to document the two-criterion requirement. (Run 72)
- **`kata/SKILL.md` Step 5: Document `(silence)` Result convention for silence SCORECARD entries.** Added a "Silence run convention" note to the SCORECARD Dimension Trajectory bullet in Step 5. States that silence runs (P3-advancing) must include `(silence)` in parentheses in the main run table's Result column (e.g., `Kaizen (silence). ...`), and that bare occurrences without parentheses (e.g., "not a silence run") do not qualify. Closes the gap where the convention was practiced (Run 63) but not documented. (Run 72)

## [2.6.0] - 2026-04-21

### Added

- **`kata/SKILL.md`: "Record the measurement scheme" paragraph in Step 1.** Kata Step 1 ("Grasp the Situation") now requires recording the measurement scheme before moving to Diagnosis. Specifies: what is being measured and why, whether the scheme is inherited or revised (inherited = one sentence; revised = `[!DECISION]`), and the observer test — reading only the GENBA entry should answer "what was this run measured against?" without consulting prior runs. Closes the gap where derived measurements were done but not deposited in the trail. (Run 69)
- **`SCORECARD.md` Dimension Trajectory: `start→end` format + `Derived` column.** Dimension Trajectory table now uses `start→end` per cell from Run 69 forward (e.g., `8→9`). New `Derived` column captures any measurements beyond Rubric v3 D1–D8 with their own `start→end` scores. Historical rows (Runs 43–68) retain end-only format with `*(end-only)*` annotation; start scores for those runs are in `TRAIL/GENBA.md`. (Run 69)

### Changed

- **`kata/SKILL.md` Step 5 Record: SCORECARD Dimension Trajectory guidance updated.** Now specifies `start→end` format for all measurements (rubric + derived) and the `Derived` column requirement. Observer reading the Dimension Trajectory row alone should be able to verify the run's claimed delta without consulting GENBA. (Run 69)
- All 5 skill files bumped from v2.5.0 → v2.6.0 to maintain version alignment (Check 4). (Run 69)

## [2.5.0] - 2026-04-21

### Added

- **`kaizen/SKILL.md`, `kaikaku/SKILL.md`, `hansei/SKILL.md`, `shiken/SKILL.md`: `## Evidence` sections.** Each individual skill now specifies what an observer should be able to find in the kiroku session after the skill completes — observable output categories, not process steps. Kaizen Evidence: what was examined, what was selected, what was changed/verified, the score. Kaikaku Evidence: evidence marshaled, ceiling assessment, recommendation, bias checks. Hansei Evidence: what was examined, recurring patterns, blind spots, trajectory characterization, recommendations. Shiken Evidence: probe design, execution trace, ARF assessment. All framed observer-centric (what observers can find), not agent-prescriptive (what agents must do). Closes D1 ceiling at 8 since Run 51. (Run 68)

### Fixed

- **`metrics.ps1` Metric 11: false POOR eliminated.** (a) Date format in `TRAIL/SUMMARY.md` corrected from `20-04-2026` (DD-MM-YYYY, rejected by regex) to `2026-04-20` (YYYY-MM-DD). (b) Assessment logic now gives GOOD when checkbox is checked AND date is ≤ 7 days old, even when Review Log has no rows, with a note prompting the reviewer to populate the Review Log for a full audit trail. Metric 11 flipped POOR → GOOD. (Run 68)

### Changed

- All 5 skill files bumped from v2.4.0 → v2.5.0 to maintain version alignment (Check 4). (Run 68)

## [2.4.0] - 2026-04-20

### Scope

- **Framing narrowed from "trust model" to "evidence substrate".** `PRINCIPLES.md` now carries an explicit "Scope clarification: evidence substrate, not trust manufacturing" subsection. The principles produce the conditions under which trust can form on observable grounds; they do not manufacture trust, guarantee correctness, or solve organizational adoption. (trust-substrate-reframe session)
- **PROBLEM.md: Out-of-Scope section added.** Eight scope boundaries named explicitly, covering reviewer engagement, reasoning correctness, human-intent stability, organizational willingness, social-layer trust, domain measurability, legal liability, and adoption psychology. Item 1 (reviewer engagement) is identified as the framework's deepest unresolved gap — structurally unfixable from inside the framework, but now at least observable. (trust-substrate-reframe session)

### Added

- **TRAIL/SUMMARY.md: Human Review Checkpoint.** Checkbox + last-reviewed date + reviewer field at the top of the digest, plus a Review Log table that accumulates over time. Makes human review activity observable so non-engagement is at least visible. (trust-substrate-reframe session)
- **metrics.ps1 Metric 11: Reviewer Engagement.** Parses SUMMARY.md for checkbox state, last-reviewed date, and Review Log rows. Reports days-since-review and runs-behind the active ledger. GOOD only when the checkbox is `[x]` and the last review covers the latest run; POOR when no review exists or the trail is ≥5 runs stale. Baseline POOR is the honest starting state. (trust-substrate-reframe session)
- **TRAIL/GENBA_ARCHIVE.md: archived GENBA ledger (Runs 1–50).** GENBA split into active (15 most recent entries, 41 KB) + archive (48 older entries, 135 KB). Every Kata run previously paid the full read cost of a 178 KB ledger; active read is now 77% smaller. (genba-archival session)
- **verify-suite.ps1 reads active + archive GENBA where full history is needed.** Checks 5, 9, and 12 now combine both files for run-count and Hansei detection. Check 13 reads only the active file (latest run is always there). Check 7 tracks the archive's hash alongside the active file. (genba-archival session)
- **metrics.ps1 Metric 10 reports active + archive sizes separately.** Scores on active size only — archive cost is one-time, not per-run. Metric 10 flipped POOR (178 KB) → GOOD (41 KB active) after archival. (genba-archival session)
- **metrics.ps1 Metrics 8-10: Session Elapsed Time, Transcript Size, GENBA Growth Rate.** Three operational metrics derived from existing trail data. Session elapsed time uses Kiroku frontmatter timestamps; transcript size measures per-session KB; GENBA growth rate tracks ledger scaling. All include CMMI-anchored thresholds. (Design discussion, consolidated)
- **hansei/SKILL.md: Intent Drift section.** Detects when goals, metrics, or system behavior drift from original intent. Asks whether the loop is optimizing for its own metrics rather than the human's actual goal. (Design discussion)
- **hansei/SKILL.md: Retirement section.** Formal process for retiring goals, metrics, constraints, or checks that no longer provide signal. Keeps the loop lean over time. (Design discussion)
- **kata/SKILL.md: Assumption surfacing + constraint identification in Phase 1 (Grasp).** Two bullets requiring explicit surfacing of unstated assumptions and mapping of hard/soft constraints before deriving measurements. (Design discussion)
- **kata/SKILL.md: Operational metrics as improvement targets in Phase 1 (Grasp).** The loop's own efficiency metrics (elapsed time, transcript size, artifact growth) are now explicitly part of the measurement scheme. If they trend poorly, the loop diagnoses and addresses its own resource consumption rather than having efficiency tactics coded into skill logic. (Design discussion)
- **metrics.ps1 Metric 7: P3 Convergence Silence Counter.** Computes consecutive zero-delta runs and distinct evaluators in the silence chain from SCORECARD data. Detects drift between the asserted counter and the computed value. Convergence is now derivable from data instead of self-asserted. (Run 59)
- **kaizen/SKILL.md: explicit silence-valid guidance.** After the three diagnostic lenses: "Silence is a valid outcome." In Self-Evaluate: silence recorded as convergence evidence, not failure. Addresses Hansei Run 60 F#1 (incentive structure incompatible with stopping condition). (Run 61)
- **kata/SKILL.md: pre-flight CM check in Execute step.** Agents now verify the latest GENBA entry's claims before modifying files, catching inter-run drift proactively instead of reactively. Addresses Hansei Run 60 F#2 (CM drift structural). (Run 61)

### Changed

- **kata/SKILL.md Convergence section tightened.** "produce the same assessment" → "produce the same score (within a defined tolerance)" — mirrors PRINCIPLES.md §3 precisely. Added explicit reference to `metrics.ps1` as the computation source for the silence counter. (Run 59)
- **kata/SKILL.md Periodic Hansei restructured from cadence to signal-based.** Fixed 10-run cadence replaced with 4 signal-based triggers: recurring-class findings (3+), sustained plateau (3+ zero-delta), methodology doubt, human request. Addresses Hansei Run 60 F#4. (Run 61)
- **verify-suite.ps1 Check 9 restructured from cadence to signal-based.** Fixed 5-run Hansei cadence check replaced with sustained-plateau detection: walks SCORECARD rows backward, counts consecutive zero-delta runs, warns at ≥3. Uses `Get-ScorecardRunRows` object model. (Run 61)
- **metrics.ps1 Metric 7 now skips non-scoring rows when computing the P3 silence chain.** External-target rows and explicitly excluded follow-up audits no longer falsely reset the computed counter; invalidated and non-zero scored runs still break the chain. (Run 64)

### Fixed

- **verify-suite.ps1 Check 5 now counts suite-GENBA-tracked rows instead of excluding every `*external*` target row.** Kiroku external runs that live only in their target trails remain excluded, while methodology-validation runs intentionally recorded in the suite GENBA (for example Run 62) are included. This removes the stale false-warning state and returns the suite to 0 failures, 0 warnings. (Run 65)
- **kiroku-validate.ps1 Check 7 now counts only real missing evidence fields, not arbitrary narrative mentions of `*not recorded*`.** This prevents false positives when a decision honestly discusses historical `*not recorded*` gaps in prose. Genuine missing `Rationale:` or `Alternatives:` fields are still warned. (Run 65)

### Reflection

- **Run 60 Hansei (no skill behavior changes).** Periodic loop reflection. 4 new findings: incentive structure incompatible with stopping condition; inter-run CM drift recurring as structural pattern; external-target finding now 19 runs deferred (Run 41 F#3 still open); cadence-driven Hansei risks compliance shape. Most Important Finding unchanged from Runs 41 and 54. Recommendations queued for Runs 61 (silence test) and 62 (external target). See `TRAIL/GENBA.md` Run 60 entry. (Run 60)
- **Run 62 external target (leifoglenedk).** First genuine external-target run. Kata→Kaizen on C# ASP.NET MVC driving school platform. Added 16 business logic tests (60/60 pass). Security findings flagged. Addresses Run 41 F#3 (20-run-deferred external target). Methodology validated: no skill modifications needed. See `TRAIL/GENBA.md` Run 62 entry and `C:\git\leifoglenedk\TRAIL\`. (Run 62)
- **Run 63 silence (no changes).** First genuine silence run. Read all 5 skill files + PRINCIPLES + README + SCORECARD rubric + CHANGELOG. Found 6 observations — all design tensions inherent in principle-first systems, none actionable. Zero artifact changes. P3 silence counter: 0 → 1. (Run 63)
- **Run 64 non-independent cross-model follow-up.** Different model family, but prior scores were visible in the same conversation, so the run does not qualify for Principle 3 convergence accounting. Fixed stale `TRAIL/SUMMARY.md` counter text, repaired `metrics.ps1` Metric 7 so non-scoring rows do not reset the silence chain, and clarified in `PRINCIPLES.md` + `kata/SKILL.md` that same-conversation model switches are not independent assessment. P3 remains 1/3. (Run 64)
- **Run 65 non-independent GPT-5.4 file-read follow-up.** Fresh read of the live suite artifacts surfaced two tool defects rather than ledger defects: `verify-suite.ps1` Check 5 still excluded all `*external*` target rows even though the suite GENBA intentionally records Run 62 for methodology validation, and `kiroku-validate.ps1` Check 7 counted any raw `*not recorded*` substring in the index, including explanatory prose. Both parser rules were fixed. `verify-suite.ps1` now passes with 0 failures, 0 warnings, and `kiroku-validate.ps1` warns only on the 4 genuine historical alternatives gaps. P3 remains 1/3 because the run was not an independent convergence evaluation. (Run 65)
- **External critique folded into self-description.** An 8-point external critique (governance vs trust, audit-trail-as-noise, reviewer-bottleneck, transparency ≠ correctness, etc.) was accepted as legitimate scope clarification rather than rebutted. Items 3, 4, 5, and 7 identified as hitting real framework limits. The reframe and Out-of-Scope section in this release are the response. The reviewer-engagement gap (critique item 4) is explicitly named as structurally unfixable from inside the framework. (trust-substrate-reframe session)

## [2.3.0] - 2026-04-20

### Added

- **Dimension Trajectory table in SCORECARD.md.** Per-dimension end-of-run scores for all v3-scored runs, showing which dimensions drove each delta. Populated from GENBA for Runs 43–57. Scheme column tracks measurement methodology changes across runs. (Run 55)
- **Kata Step 5: Dimension Trajectory instruction.** Agents now populate the Dimension Trajectory table when recording a scored run. Directly addresses P2 (Observable Autonomy) at indexed resolution. (Run 55)
- **verify-suite.ps1 Check 14: score-change/artifact-change correlation.** Catches fabricated improvements by verifying score increases correlate with artifact diffs. Supports Principle 3 convergence infrastructure. (Run 52)

### Changed

- **metrics.ps1 threshold rationale documented inline.** All 5 metric thresholds now carry CMMI QPM L4, ICC psychometrics, or Six Sigma 3σ anchors, making scores reproducible and defensible. (Run 52)
- **SCORECARD v1/v2 historical narrative extracted to v1_archive/SCORECARD_HISTORY.md.** Reduces SCORECARD to the active scoring record only, improving 2-minute observer readability. (Run 56)

### Fixed

- **metrics.ps1 SCORECARD parser rewritten (regex → field split).** Recovered 11 silently-dropped run rows; model diversity and fix durability now computed on the full dataset. (Run 51)
- **SCORECARD version string corrected v2.1.0 → v2.2.0.** Stale version label from pre-release draft. (Run 51)
- **Scoped SCORECARD parsing in `metrics.ps1` to the main run table.** Dimension Trajectory and rubric tables no longer inflate run counts or distort derived metrics. (Run 55)
- **Hardened `verify-suite.ps1` SCORECARD and correlation checks.** Run-consuming checks now read the main run table instead of numeric tables generally, GENBA run counting is anchored to top-level headings, and Check 14 is snapshot-aware so clean re-verification of an already-recorded scored run does not warn spuriously. (Run 55)
- **README.md verify-suite check count corrected 13 → 14.** Stale count after Check 14 was added. (Run 53)
- **METRICS_HISTORY.md cleaned.** Removed 1 duplicate row and 1 garbage row from the history file. (Run 52)
- **SCORECARD.md orphan rows removed.** Three main-run-table rows (2× Run 57, 1× Run 56) that escaped into the Dimension Trajectory section via insertion error removed. (Run 58)

## [2.2.0] - 2026-04-20

### Added

- **Root README.md created.** Suite now has an entry point: 6-skill table, principles summary, directory structure, getting-started guide.

### Changed

- **7 journey documents archived to v1_archive/.** REBUILD_INTENT.md, SUITE_TRANSFORMATION.md, PLAIN_LANGUAGE_THESIS.md, DELEGABILITY_CONTRACT.md, WORKED_EXAMPLE_DATAKIT.md, RUBRIC_V3_PROPOSAL.md, and MEASUREMENT.md moved via `git mv` (history preserved). Root files reduced from 17 to 10.
## [2.1.0] - 2026-04-20

### Changed

- **Kiroku rewritten principle-first for colleague adoption.** Domain-agnostic evidence trail management. GENBA ownership separated to Kata.
- **Indexer and validator `[!DECISION]` matching anchored to line start.** Eliminates false positives from narrative references to the marker.
- **Kata GENBA wording sharpened.** GENBA is for suite-level evaluation runs only, not skill-level development work.
- **Trail routing canonicalized.** Direct chat work and Kata runs on the same target share one `TARGET_REPO/TRAIL/`. Suite ledger moved from root to `TRAIL/GENBA.md`.

## [2.0.1] - 2026-04-19

### Fixed

- **Cross-model validation repaired the shipped v2 artifact.** `kata`, `kaizen`, `kaikaku`, and `hansei` had been committed with legacy v1.34.0 bodies appended beneath the new v2 content. The live files were rewritten cleanly as v2.0.1.
- **Retired legacy skill files removed from the live suite.** `mura`, `muri`, `muda`, and `project-increment` no longer exist in the suite root as runnable skills. v1 reference material remains under `v1_archive/`.
- **project-increment reference material preserved before retirement.** Its semver reference was archived to `v1_archive/project-increment-semver.md`.
- **Mechanical verification aligned to the 5-skill suite.** `verify-suite.ps1` now validates the live v2 inventory (`kata`, `kaizen`, `kaikaku`, `hansei`, `shiken`) instead of the retired 8-skill layout.
- **Ledger checks now ignore external-target rows when verifying the skill-suite trail.** SCORECARD rows for Kiroku no longer masquerade as missing GENBA history for the suite itself.

## [2.0.0] - 2026-04-19

### Changed

- **Skills rebuilt from PRINCIPLES.md and PROBLEM.md alone.** The suite was re-derived from the constitutional layer rather than incrementally patched from v1.34.0.
- **8 skills became 5.** The live suite is now `kata`, `kaizen`, `kaikaku`, `hansei`, and `shiken`.
- **Mura, Muri, and Muda were absorbed into Kaizen as diagnostic vocabulary.** They are no longer intended to be invoked as standalone workflows.
- **project-increment was retired as a reasoning skill.** Release/versioning guidance became archived reference material rather than part of the live autonomous-reasoning suite.
- **Kiroku trail and measurement framework added for the rebuild.** `REBUILD_INTENT.md`, `MEASUREMENT.md`, and TRAIL artifacts document the rebuild rationale, constraints, and outcomes.

## [1.34.0] - 2026-04-19

### Changed

- **Principle 2 (Observable Autonomy): resolution requirement added.** Evidence must exist at multiple resolutions (full transcript, indexed decisions, executive digest) so each observer class can verify at the depth their time budget allows. Self-authored layers must be explicitly marked. Fidelity degradation (verbatim vs. reconstructed) must be stated.
- **GENBA's role clarified in Principle 2.** GENBA is "one resolution of the trail — a structured digest of improvement runs — not the entire trail."
- **Dim 8 (Autonomous Reasoning Fidelity) trail integrity test updated.** "From the GENBA trail alone" replaced with multi-resolution, multi-observer test aligned with the P2 refinement. Scoring guidance updated accordingly.

### Added

- **SCORECARD Runs 45-46.** First external target (Kiroku). Kaikaku greenfield + Kaizen polish. Scores N/A (external target, no self-scoring).

## [1.33.0] - 2026-04-19

### Fixed

- **verify-suite.ps1 `$siblingMap` now includes Shiken.** Check 3 validates cross-references for all 8 TPS skills (was 7). Each skill checked against 7 siblings (was 6). Pass message updated.
- **Kaikaku Phase 5 stale reference corrected.** "kaizen Phase 0-3" → "Phases 1-3" — Kaizen has no Phase 0.
- **project-increment broken semver.md link removed.** `./references/semver.md` never existed; semver rules already inlined in the table.
- **RUBRIC_V3_PROPOSAL Dim #6 traceability re-absorption removed.** Measurement procedure text no longer partially absorbs the Traceability gap, per GPT-5.4 Finding #4.

## [1.32.0] - 2026-04-19

### Fixed

- **STANDARDS.md stale claims corrected (W1).** Removed "automated degradation alerts" from DMAIC Control and "trend alerts detect out-of-control conditions" from CMMI OPM. Both were overstated — `metrics.ps1` does not implement automated alerts. OPM status changed from "Meets" to "Partial."
- **Kaizen frontmatter now includes Hansei (M1/W3).** The TPS family listing in kaizen/SKILL.md was missing Hansei for 35 runs since it was added at Run 7.
- **GENBA location string standardized (M3).** 4 variant phrasings across 7 skills reduced to 1 canonical format. Kaikaku, Mura, Muri, and Hansei now match the Kaizen/Muda format. Recurrence from Run 29's incomplete fix.
- **Kata UTF-8 rule wording aligned (M2).** "Japanese glyphs" → "non-ASCII glyphs" to match all other skills.
- **Historical Snapshot caveat added (W2).** SCORECARD's Run 13 convergence analysis now notes that the 10.0 plateau was a rubric ceiling, not genuine convergence, per Run 41 Hansei and Rubric v3 Kaikaku.

### Added

- **First v3 baseline score: 7.75.** Scored against 8-dimension standards-anchored rubric. Strongest: Configuration Management (10). Weakest: Convergence Integrity (5).

## [1.31.0] - 2026-04-19

### Changed

- **Kaikaku: Rubric v3 adopted (Run 42).** Replaced ad-hoc 10-dimension rubric (v1/v2) with standards-anchored 8-dimension rubric grounded in PDCA, DMAIC, CMMI L3-5, NIST AI RMF, and foundational theory (Auftragstaktik, Meaningful Human Control). Two organizational-theater dimensions removed (Traceability, Risk Governance). SPC merged into Measurement Validity. New dimension: Autonomous Reasoning Fidelity — measures Commander's Intent and Observable Autonomy.
- **Cross-model reviewed before adoption.** GPT-5.4 reviewed ("Adopt with modifications" — 5 fixes applied) and Gemini 3.1 Pro Preview reviewed ("Approve for Adoption"). Three model families participated in design/review.
- **SCORECARD.md updated.** Rubric v3 section appended with 8 dimensions, external anchors, scoring guidance, and explicit non-goals. Rubric changelog updated. Current Status notes v3 as active from Run 42 forward. All v1/v2 content preserved unchanged.

### Added

- **RUBRIC_V3_PROPOSAL.md.** Full Kaikaku proposal documenting diagnosis, design principles, dimension rationale, migration plan, cross-model review addenda, and adoption status.

## [1.30.0] - 2026-04-19

### Documentation / Reflection

- **Hansei pass (Run 41).** First Hansei run since Run 36. Surfaced 4 meta-findings about the loop: (1) hallucination invalidations have always been caught by the *next* model, never the failing one, with `verify-suite.ps1` reporting 0 failures both times (Runs 11 and 39); (2) the score has plateaued at 10.0 for 9 consecutive runs because every recent improvement is verifier-on-verifier; (3) Run 8's deferred "self-targeting only" finding has now been deferred for 33 runs and is the suite's central blind spot; (4) 35 consecutive Kaizen runs — Kaikaku has not been evaluated since Run 6 despite the loop's own "consider Kaikaku at plateau" rule. **Most important finding:** the loop is closed — the suite has been improving how it improves itself but never improving anything else. Concrete recommendations recorded in GENBA Run 41 entry for future runs to action.
- **No skill behavior changes.** Per `hansei/SKILL.md` "one reflection per cycle" rule, the four findings are surfaced as recommendations only. Acting on them is the responsibility of subsequent Kata or Kaikaku runs.

## [1.29.0] - 2026-04-19

### Changed

- **Kata Phase 1 GRASP — mandatory prior-run delta check.** `kata/SKILL.md` now requires the agent to run `git log --oneline -5` and read the latest `CHANGELOG.md` entry before diagnosing, so findings already shipped in the prior run cannot be re-claimed as new work. This closes the loophole that produced Run 11 (GPT-4o hallucinated fixes) and Run 39 (Gemini 2.5 Pro re-claimed Run 38's shipped INTEGRITY.json fix).

### Fixed

- **Run 39 invalidated.** Marked as `**Invalidated**` in `SCORECARD.md` and annotated as `STATUS: INVALIDATED` in `GENBA.md` with prose preserved per the Run 11 precedent. The integrity-snapshot fix attributed to Run 39 was already shipped in v1.28.0 / Run 38 and is not re-released here.

## [1.28.0] - 2026-04-19

### Changed

- **Stable integrity snapshots on clean runs:** `verify-suite.ps1` no longer rewrites `INTEGRITY.json` when tracked hashes and suite version are unchanged. This removes timestamp-only churn, keeps no-change verification runs clean, and strengthens the suite's configuration-management baseline semantics.
- **STANDARDS.md revalidated by GPT-5.4:** The external-standard mapping now explicitly reflects that configuration-management evidence includes stable no-change baselines, not just broad snapshot coverage.

## [1.27.0] - 2026-04-18

### Changed

- **CMMI L3 Configuration Management/PPQA Gap Resolved:** Expanded `verify-suite.ps1` hash snapshot coverage (`INTEGRITY.json`) to include explicitly: `verify-suite.ps1` itself, `metrics.ps1`, `METRICS_HISTORY.md`, and `STANDARDS.md`. The suite now provides mechanical integrity validation over its own measurement and validation infrastructure.
- **STANDARDS.md Revalidated:** Cross-model validation confirmed existing frameworks adherence, while closing the identified Traceability/PPQA verification gap for process tools.

## [1.26.0] - 2026-04-18

### Added

- **Metrics history tracking (DMAIC Control phase):** `metrics.ps1` now appends a timestamped row to `METRICS_HISTORY.md` each time it runs, creating a time-series record for statistical process control. Includes automated trend detection that flags degradation between snapshots.
- **External standard mapping (`STANDARDS.md`):** Explicit alignment analysis against PDCA, DMAIC, CMMI L3-5, and NIST AI RMF. Documents where the suite meets, exceeds, or falls short of each standard with specific gap analysis.

## [1.25.0] - 2026-04-18

### Added

- **Computable metrics infrastructure (`metrics.ps1`):** New script computes 6 objective, reproducible metrics from SCORECARD.md and GENBA.md data: inter-rater agreement (start score standard deviation), defect recurrence rate, invalidation rate, regression frequency, model diversity index, and fix durability. Produces a summary calibration assessment (HEALTHY/FAIR/WEAK).
- **Scoring Rubric v2:** Added 10th dimension "Calibration" — asks whether the computable metrics from `metrics.ps1` are healthy. The scoring system now has an objective, reproducible component alongside its 9 semantic dimensions.
- **Version field for project-increment:** Added missing `version` frontmatter field to project-increment/SKILL.md, aligning it with the other 7 skills.

### Changed

- **SCORECARD disclaimer updated:** Replaced the permanent "not calibrated against any external standard" limitation with a measurable calibration status that `metrics.ps1` can assess. The gap between internal and external calibration is now quantified rather than unknowable.

## [1.24.0] - 2026-04-18

### Added

- **Global UTF-8 enforcement:** Added the mandatory Preserve UTF-8 on bulk edits rule to kaizen, kaikaku, mura, muri, muda, hansei, and project-increment. Previously, only the orchestrator (kata) possessed this rule, leaving standalone runs vulnerable to codebase corruption via PowerShell's default non-UTF8 encoding in bulk text replacements.


## [1.23.0] - 2026-04-18

### Changed

- **`kata/SKILL.md`:** Re-applied the Run 32 model self-identification contract after restoring the file from the last clean tag, and added an explicit UTF-8 bulk-edit rule so shell-based markdown rewrites do not silently corrupt arrows, em dashes, or Japanese glyphs.
- **`verify-suite.ps1` Check 1:** Expanded mojibake detection to catch the Unicode replacement character and the `ù` cp1252 artifact seen in corrupted TPS skill files.

### Fixed

- **All 7 TPS `SKILL.md` files:** Restored from the encoding-corrupted `v1.22.0` state to clean UTF-8 text using the last clean tag (`v1.21.0`) as the recovery source, then rebased forward to `v1.23.0`.
- **`v1.22.0` regression class:** The suite can no longer pass mechanical integrity with committed replacement-character / cp1252 mojibake in skill files.

## [1.22.0] - 2026-04-18

### Added

- **`verify-suite.ps1` Check 13 — Latest-run model identity consistency:** Validates that the latest run's model string is present and non-placeholder in `GENBA.md`, that `SCORECARD.md` has a row for the same run number, and that both model strings match exactly. Fails on mismatch.

### Changed

- **`kata/SKILL.md` Phase 1:** Added mandatory model self-identification at run start and explicit requirement to write the same model string in both `GENBA.md` and `SCORECARD.md`.
- **`kata/SKILL.md` Rules:** Added "Self-identify every run" rule to prevent cross-ledger model drift.

### Fixed

- **Suite root cleanup:** Removed lingering temporary recovery artifacts (`GENBA.md.bak`, `run29.md`, `run29.py`) so working-tree status and run persistence are not polluted by stale files.

## [1.21.0] - 2026-04-18

### Added

- **`kata/SKILL.md` Phase 6: PERSIST:** New phase after REFLECT that commits the suite state to git after a successful run (0 verify-suite.ps1 failures). Commit message format: `TPS Skill Suite vX.Y.Z — Run N: <summary>`. Creates annotated tag. Does not push without explicit user consent. Prevents the Run 29 failure class where 5 runs of uncommitted work were lost to a single `git checkout .`.
- **`kata/SKILL.md` Rules:** Added "Persist every run" rule referencing Phase 6.

### Changed

- **`kata/SKILL.md` description:** Updated to include "persist to git" in the skill purpose line.
- **`kata/SKILL.md` opening line:** Changed from "Diagnose, decide, execute, chronicle" to "Diagnose, decide, execute, chronicle, persist."
- **`project-increment` skill:** Now formally referenced by Kata Phase 6: PERSIST for git commit/tag conventions. No longer an orphan in the suite — it has a defined role as the authority for version-format conventions.

## [1.20.0] - 2026-04-18

### Added

- **`verify-suite.ps1` Check 10 — Governing-document integrity:** Asserts that `PRINCIPLES.md` contains all three expected principles by heading (`## Principle 1: Commander's Intent`, `## Principle 2: Observable Autonomy`, `## Principle 3: Convergence Is Silence`). Fails if any are missing.
- **`verify-suite.ps1` Check 11 — CHANGELOG version contiguity:** Parses `## [X.Y.Z]` release headings newest-first and asserts each step is exactly +1 patch, +1 minor (resetting patch to 0), or +1 major (resetting minor and patch). Fails on any gap, catching silently lost release entries.
- **`verify-suite.ps1` Check 12 — SCORECARD↔GENBA per-run coverage:** For every non-`**Invalidated**` SCORECARD row, asserts a matching `## Run N` heading exists in GENBA. Warns on mismatches (does not fail, since older runs may be legitimately archived).

### Fixed

- **`PRINCIPLES.md`:** Restored Principle 3 (Convergence Is Silence) section, three-principle interaction diagram, and "all three principles" phrasing in the "For skill authors" lead. These were silently reverted during Run 29 when a `git checkout .` recovery shortcut undid Run 26's work.
- **`CHANGELOG.md`:** Restored v1.16.0, v1.17.0, and v1.18.0 entries (silently lost during Run 29's git revert).
- **`GENBA.md`:** Restored Run 26, Run 27, and Run 28 entries in newest-first order between Run 29 and Run 25 (silently lost during Run 29's git revert).
- **`SCORECARD.md`:** Re-applied Run 26's deletion of the ~175-line "Key Deltas By Run" section (which Run 29's git revert had restored). Re-simplified "Current Status" to three stable bullets and removed the stale per-run delta-trajectory line from Cross-Model Notes (the run table is the source of truth).
- **`kaizen/SKILL.md`:** Restored Run 28's `trustworthiness` in both non-code dimension lists (RATE phase weighting guide + "For non-code targets" paragraph) and Run 27's CHECK exit-condition rewrite (Principle 3 local-plateau vs true-convergence distinction).
- **`kata/SKILL.md`:** Restored Run 27's zero-findings rewrite (candidate silence + Principle 3 silence counter), Run 27's REFLECT trend-analysis update (silence signal in place of convergence estimate), and Run 26's "Fix globally, not locally" rule in Phase 3 EXECUTE.
- **`hansei/SKILL.md`:** Restored Run 27's meta-stop rewrite ("meta-level plateau pending Principle 3 confirmation") and Run 29's `~/.copilot/skills/GENBA.md` path lookup string in Phase 6 RECORD.
- **`mura/SKILL.md`, `muri/SKILL.md`, `kaikaku/SKILL.md`:** Restored Run 29's `~/.copilot/skills/GENBA.md` path lookup string in REPORT phase.
- **All 7 SKILL.md frontmatter versions:** Restored from regressed `1.15.0` to `1.20.0` (Runs 16-19 release tags retained in this CHANGELOG since their content is restored in this same release; v1.20.0 supersedes them all).

### Documentation

- **`GENBA.md` Run 30 entry:** Includes the mandatory periodic Hansei block (5 runs since Run 25). Hansei records the loop's primary blind spot — *mechanical verification cannot protect content it does not read* — and adds a binding operational rule: `git checkout .` / `git restore .` are forbidden as recovery shortcuts.

## [1.19.0] - 2026-04-18

### Fixed

- **`mura`, `muri`, `kaikaku`, `hansei` skills REPORT/RECORD phase:** Added explicit `GENBA.md` location lookup string (`~/.copilot/skills/GENBA.md` or project root) to the prepend instructions. Without this path explicitly stated, these standalone tools orphan their ledgers when run without an orchestrator like Kata or Kaizen.

## [1.18.0] - 2026-04-18

### Fixed

- **`kaizen` skill RATE phase:** Non-code target dimension lists (weighting guide and "For non-code targets" paragraph) now include `trustworthiness` as the 9th dimension, matching SCORECARD.md Scoring Rubric v1. The two prior mentions listed only 8 dimensions, omitting Trustworthiness — the dimension added in Run 17 specifically to capture verification infrastructure.

## [1.17.0] - 2026-04-18

### Changed

- **`kaizen` skill CHECK exit condition:** Replaced the old `±0.2 for two cycles = converged` rule with the Principle 3 distinction between local plateau and true convergence. Kaizen now requires 3 consecutive runs, 3 distinct evaluators, same score, and zero artifact changes before using the word "converged."
- **`kata` skill:** Zero-findings handling and REFLECT trend analysis now distinguish candidate silence from convergence and track a Principle 3 silence counter rather than a score-only convergence estimate.
- **`hansei` skill:** Meta-level stopping guidance now treats repeated no-finding reflections as a plateau signal pending Principle 3-style cross-evaluator confirmation, rather than declaring meta-convergence after two same-pattern runs.

### Fixed

- **`SCORECARD.md`:** Added explicit pre-Principle-3 labeling to historical convergence language so the live ledger no longer contradicts the current "Convergence Is Silence" rule.

## [1.16.0] - 2026-04-18

### Added

- **`kata` skill EXECUTE phase:** "Fix globally, not locally" rule — when a finding targets a pattern, search the entire target for all instances before marking it fixed. Prevents the multi-run recurrence pattern seen in Runs 22–24.

### Removed

- **`SCORECARD.md` Key Deltas By Run section:** ~175 lines of per-run narrative that duplicated `GENBA.md` at lower fidelity. Every run this section existed, it required manual synchronization and repeatedly drifted (Runs 19, 21, 25). The run table and `GENBA.md` are the authoritative records.
- **`SCORECARD.md` Current Status narrative:** Replaced 4 run-specific bullets (which drifted every run) with 2 stable bullets pointing to source-of-truth locations. First net deletion in the suite's history — directly addresses Hansei Run 8 Finding 2 ("suite only grows").

## [1.15.0] - 2026-04-18

### Changed

- **`kata` skill:** Periodic-Hansei guidance now explicitly requires recording Hansei with verifier-compatible GENBA headings (`### Hansei` / `### Hansei Pass`) so cadence checks remain machine-verifiable.

### Fixed

- **`SCORECARD.md`:** Corrected stale narrative metadata after Run 24 (`Delta trajectory` run range and `Current Status` heading/state text) so summary prose matches the authoritative run table.

## [1.14.0] - 2026-04-18
- **`hansei` skill:** Fixed the Phase 6 heading from "Append to the Trail" to "Prepend to the Trail" to finally complete the prepending vs appending methodology conflict originated in Run 22 and continued in Run 23.

## [1.13.0] - 2026-04-18

### Fixed

- **`kaikaku`, `muri`, `mura` skills:** GENBA recording guidance still said "append" after Run 22 fixed only Kata, Kaizen, Muda, and Hansei. Now all 7 skills consistently say "prepend... newest-first."
- **`PRINCIPLES.md` §3:** Still said "appends to the ledger" — now says "prepends to the ledger (newest-first)," matching the actual suite practice and all 7 skill files.

## [1.12.0] - 2026-04-18

### Changed

- **`kata`, `kaizen`, `muda`, `hansei` skills:** GENBA recording guidance now states the active ledger is newest-first, so new entries are prepended rather than appended. This aligns the written procedure with the actual suite practice and with verifier expectations.

### Fixed

- **`verify-suite.ps1` Check 9:** Replaced position-based Hansei detection with order-independent run-block parsing keyed by run number. The check now counts only explicit `### Hansei` / `### Hansei Pass` sections, so narrative mentions of Hansei no longer falsely reset cadence.
- **`verify-suite.ps1` Check 5:** Ledger mismatch warning now reports invalidated row count and explicitly notes archived/lost history as another legitimate source of mismatch, instead of implying invalidated rows are the whole story.

## [1.11.0] - 2026-04-18

### Added

- **`kata` skill CHRONICLE phase:** Step 2b — explicit CHANGELOG.md update step. Previously every run updated CHANGELOG but the procedure didn't say to, relying on models to remember.
- **`SCORECARD.md` Key Deltas:** Added entries for Runs 12, 13, 14, 15, 16, and 17 — filling a 6-run gap in the trail that covered the suite's breakthrough from 9.1 to 9.4.

### Fixed

- **`verify-suite.ps1` Check 9:** Removed dead code (`$latestRun`, `$runsSinceHansei` variables computed but never used). Fixed off-by-one: the check was counting the run containing the Hansei marker itself, reporting "1 run since Hansei" when the correct answer was 0. Used `$hanseiMatches[0]` (newest match in newest-first file) instead of `[$Count-1]` (oldest match).

## [1.10.0] - 2026-04-18

### Added

- **`verify-suite.ps1` Check 8 — Suite skill inventory.** Detects skill directories under suite root that are not part of the TPS family. Reports as INFO (not failure) so non-TPS skills like `project-increment` are explicitly visible rather than silently orphaned.
- **`verify-suite.ps1` Check 9 — Periodic-Hansei cadence.** Warns when ≥5 Kata runs have occurred since the last Hansei reference in `GENBA.md`. Enforces Hansei's own "periodic, every N runs (default 5)" rule mechanically. Catches the failure mode where a discipline becomes ceremonial.
- **`kata` skill REFLECT phase:** "Periodic Hansei (mandatory cadence)" paragraph — invoke Hansei when ≥5 runs have passed since last invocation, even when no recurring patterns are visible. References `verify-suite.ps1` enforcement.
- **First Hansei record in current GENBA** (since Run 11 wipe lost the Run 8 entry). Revisits Run 8 backlog Findings 2 and 3.

### Fixed

- **`SCORECARD.md` Current Status:** collapsed redundant phrasing "Five at 9.5 (...) and one at 9.5 (...)" into "Six at 9.5".

## [1.9.0] - 2026-04-18

### Added

- **`kata` skill:** Pre-run integrity gate in Phase 1 GRASP — run `verify-suite.ps1` before diagnosing to confirm the current state is known-good. Prevents wasting a cycle on corrupted or tampered state.
- **`kata` skill:** Cross-format recurrence matching note — recurrence detection guidance now accounts for pre-Run 17 prose-format GENBA entries alongside post-Run 17 structured tables.

### Fixed

- **`SCORECARD.md`:** Delta trajectory and validated score in Cross-Model Notes were stale after Run 18 (said "Runs 1-17" and "9.4"). Updated to Runs 1-19 and 9.7.

## [1.8.0] - 2026-04-18

### Added

- **`kata` skill:** Zero-findings branch in Phase 2 CHALLENGE — distinguishes convergence from shallow audit with decision tree.
- **`kata` skill:** Recurrence detection guidance in GENBA findings template — concrete matching criteria (same lens + same component/dimension, cross-rubric-version).
- **`hansei` skill:** Rubric-version-transition awareness in PATTERN phase — prevents misleading cross-run score comparisons when rubric changes.
- **`PRINCIPLES.md` §5:** Verification infrastructure section — surfaces `verify-suite.ps1`, `INTEGRITY.json`, and `SCORECARD.md` so models discover them without reading Kata Rules.
- **`verify-suite.ps1`:** Cross-platform documentation — notes PowerShell Core 7+ compatibility on Linux/macOS, install link, fallback guidance.

### Changed

- **`kaizen` skill:** CHECK phase verify-suite.ps1 obligation changed from optional ("When available") to required with manual fallback — consistent with Kata Rules.

## [1.7.0] - 2026-04-18

### Added

- **`verify-suite.ps1`:** New mechanical integrity verification script. Checks encoding (mojibake), placeholder text, cross-reference completeness, version alignment, ledger consistency, frontmatter validation, and writes file-hash snapshots to `INTEGRITY.json` for diff-based run validation. Inspired by evo's hash-chained proof ledger — adapted for markdown-based skill files.
- **`kata` skill:** Structured findings table (`### Findings`) added to GENBA entry template — machine-readable format with Finding/Lens/Severity/Fixed/Recurred columns for automated trend analysis.
- **`kata` skill:** Step 3 in CHRONICLE phase now requires running `verify-suite.ps1` before recording a run as complete.
- **`SCORECARD.md`:** Added explicit Scoring Rubric (v1) with 9 named dimensions including Trustworthiness. Versioned so future rubric changes are traceable.

### Changed

- **`kata` skill:** "Run integrity checks before scoring" rule replaced with "Run verify-suite.ps1 after every run" — mechanical enforcement replaces manual scanning.

## [1.6.0] - 2026-04-18

### Added

- **`kata` + `kaizen` skills:** Added mandatory mechanical integrity scan guidance in CHECK/Rules (placeholder + mojibake detection) to prevent recurring invisible-text defects.

### Fixed

- **`GENBA.md`:** Repaired legacy mojibake in Run 11 (`â€”`, `â†’`, `æ”¹å–„`) so historical entries are human-readable and machine-searchable.
- **`SCORECARD.md`:** Corrected Run 14 score row from claimed `9.4 (+0.4)` to validated `9.1 (+0.1)` per Run 15 correction audit.

### Changed

- **`SCORECARD.md`:** Reframed stale "Experiment Conclusion" as a historical snapshot and added a current-status section so post-Run-13 updates cannot conflict with archived narrative blocks.

## [1.5.0] - 2026-04-18

### Fixed

- **`kata` skill (CRITICAL):** Phase 4 CHRONICLE contained an unresolved placeholder (`//... existing code ...`) where the GENBA entry-format template should live. The chronicling instruction was unfollowable. Restored the full GENBA + SCORECARD entry templates.
- **`kaikaku` skill (CRITICAL):** Entire file was UTF-8 mojibake — `(改革)` rendered as `(æ”¹é©)` (with embedded control char `C2 9D`), and every em-dash rendered as `â€"`. Rewrote file with correct UTF-8 byte sequences. 14 prior runs missed this defect; surfaced by Run 15 fresh-read.

### Changed

- **GENBA template consistency:** Added `Regression vs prior run` line to the GENBA append templates of `mura`, `kaikaku`, and `hansei` to match the templates already in `muri`, `muda`, and `kaizen`.

## [1.4.0] - 2026-04-18

### Added

- **Versioning:** All skill files now include a `version` field in their frontmatter.
- **Changelog:** This `CHANGELOG.md` was created to track the evolution of the skill suite.
- **`kata` skill:** Added a `## Rules` section for consistency.
- **`mura` skill:** Added a `## Rules` section for consistency.
- **`kata` skill:** Now responsible for updating `SCORECARD.md`.

### Changed

- **`kaizen` skill:** Responsibility for `SCORECARD.md` was moved to the `kata` skill to reduce overburden.
- **`kaikaku` skill:** Added reference to `SCORECARD.md`.
- **`hansei` skill:** Added reference to `SCORECARD.md`.

### Removed

- **`kaizen` skill:** Removed the "lightweight mode" (Phase 0) to simplify the skill, eliminating overproduction waste.
