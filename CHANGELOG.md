# Changelog

<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to a custom versioning scheme.

## [Unreleased]

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
