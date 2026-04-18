# Changelog

<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to a custom versioning scheme.

## [Unreleased]

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
