# Retired

The contents of `archive/v2/` are **retired**. They are kept as historical evidence and for rollback, not as a credential or score that carries forward.

## What is retired

- **`SCORECARD.md`** (this directory). The v2.4.1 score of **8.83** at chain position **2/3** does not transfer to v3. v3 is a different artifact; Principle 3 (condition 2) requires the convergence counter to reset on material change.
- **`METRICS_HISTORY.md`** (this directory). The 11 metrics tracked across runs 1\u201397 measured the v2 substrate; most do not exist in v3 (no SCORECARD parser, no GENBA file, no run numbers, no Tier 1 dimensions).
- **`INTEGRITY.json`** (this directory). v2 integrity snapshots refer to file paths that no longer exist in the live tree.
- **`STANDARDS.md`** and **`PATTERNS.md`** (this directory). v2-specific operational standards, superseded by the v3 layout.
- **The Tier 1 self-scoring rubric** in all its versions (v3, v4, v5). v3 uses no Tier 1 rubric; convergence (Tier 2) is the only measure of done.
- **The 6-skill structure** (kata, kaizen, kaikaku, hansei, shiken, intent, kiroku). Replaced by `improve` and `probe` plus `tools/`.
- **All `.ps1` scripts** in this directory. Replaced by `tools/verify.py` and `tools/record.py` in the live tree.

## What this directory still provides

- **Rollback target.** `git checkout v2.4.1` restores the v2 tree as it was before the redesign.
- **Provenance.** The v2 trail (`archive/v2/TRAIL/`) is the empirical record of how the framework was developed and tested. The principles in [PRINCIPLES.md](../../PRINCIPLES.md) and the convergence protocol they encode were forged through those 97+ runs.
- **Comparison.** A reader who wants to understand *why* v3 dropped what it dropped can compare v2's `kaizen/SKILL.md` against v3's `improve/SKILL.md`, or v2's `verify-suite.ps1` against v3's `tools/verify.py`. The redesign is documented in [REDESIGN.md](../../REDESIGN.md).

## Reading the v2 trail responsibly

The v2 trail is a record of work done under v2's principles and tooling. Where it cites scores, dimensions, or run numbers, those refer to v2's measurement scheme \u2014 not v3's. v3 has no run numbers (entries are dated, not numbered), no dimension scores (no Tier 1), and no scorecard counter (chain state is read from `trail/log.md`).

If a future observer wants to validate the v3 framework, the right approach is to start from `PRINCIPLES.md` and `improve/SKILL.md` in the live tree and disregard everything under `archive/v2/`. The archive is corroborating context, not evidence about v3.
