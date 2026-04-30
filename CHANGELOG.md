# Changelog

## v3.4.0 — 2026-04-30

### Added
- `tools/record.py history --write`: writes `trail/history.md` as committed markdown — a readable, GitHub-renderable summary of all runs. Closes the actual proof-of-improvement gap from v3.0.0: `record.py history` produced terminal output only, not a committed artifact a colleague could read.
- `trail/SKILL.md`: standard workflow now includes regenerating `trail/history.md` after every session. Documented in the directory tree.

### Changed
- `cmd_history` refactored: rendering split into `_render_history(entries, markdown=...)` so the same parser drives both terminal and markdown outputs.

---

## v3.3.4 — 2026-04-30

### Fixed
- `INSTALLING.md`: fully rewritten to match current truth.
  - Trail section corrected: trail lives in target repo root, not in `.copilot/skills/`. Documents `record.py` and `python trail/record.py history` usage.
  - Removed `PRINCIPLES.md` and `CONVERGENCE_SCOPE_PROTOCOL.md` from required files (they have been optional since v3.3.1).
  - "What each skill needs" table updated to "optional" sibling files only.
  - Minimum install simplified: no sibling files needed.
  - Full install directory tree no longer shows `trail/log.md` and `trail/README.md` inside `.copilot/skills/`.

---

## v3.3.3 — 2026-04-30

### Fixed
- `trail/SKILL.md`: trail initialisation now includes copying `record.py` into `trail/record.py` in the target repo. The history viewer is self-contained per project — no dependency on the global skills install path. Usage: `python trail/record.py history` from the repo root.

---

## v3.3.2 — 2026-04-30

### Fixed
- `trail/SKILL.md`: made trail location explicit — the `trail/` folder lives in the **root of the target repo**, not in the skills install directory. Previous wording was ambiguous and agents defaulted to writing the trail relative to themselves (the skills folder). Each repo now gets its own trail.

---

## v3.3.0 — 2026-04-29

### Added
- `tools/record.py history` subcommand: renders a per-run timeline from `trail/log.md` — date, slug, outcome, delta, decisions. `▸` for change runs, `·` for silence. Closes the proof-of-improvement gap left when the v2 scorecard was removed.
- `INSTALLING.md`: installation guide explaining Copilot's one-level-deep skill discovery rule, minimum vs full install, sibling file requirements, and trail initialisation.

### Changed
- `README.md` opening rewritten to lead with "autonomous self-improving loop" — the first sentence now communicates what this system is, not just what files it contains.
- `README.md` "Using the skills" section links to INSTALLING.md.

---

## v3.2.0 — 2026-04-28

### Added
- `intent/SKILL.md` — Intent as a standalone first-class skill.
- `trail/SKILL.md` — Trail as a standalone first-class skill.

### Changed
- `improve/SKILL.md` — step 1 delegates to Intent when installed; step 7 delegates to Trail when installed.
- `probe/SKILL.md` — step 5 delegates to Trail when installed.
- `README.md` — four-skill description; composable installation progression documented.

---

## v3.1.0 — 2026-04-24

### Changed
- README.md "Versioning and convergence" section updated to reflect convergence achieved.
- CITATION.cff bumped to v3.1.0.

### Evidence
- Skills convergence: 3/3 silence (Anthropic, xAI/Grok, Google/Gemini). Trail slugs: `v3-silence-1`, `v3-silence-2`, `v3-silence-3`.
- Cross-layer coherence: silence. Trail slug: `cross-layer-coherence`.
- All four entries in `trail/log.md`. Verified by `tools/verify.py` (0 failures, 0 warnings).

---

## v3.0.1 — 2026-04-24

### Changed
- trail/README.md corrected to reflect the v3 trail structure and remove the v2 splice tail.

## v3.0.0 — 2026-04-23 (branch `v3-redesign`)

Radical redesign. See [REDESIGN.md](./REDESIGN.md) for the full rationale.

### Changed
- Skill count reduced from 6 to 2: `improve` (Kaizen + Kaikaku + Hansei + Intent + Kata) and `probe` (Shiken).
- Vocabulary changed from Japanese/TPS terms to plain English. Repo name `kata` retained as a historical codename.
- Trail unified from three files (`TRAIL/`, `GENBA.md`, `SCORECARD.md`) into one append-only `trail/log.md`.
- Scripts ported from PowerShell (~66 KB across 5 files) to Python 3 (`tools/verify.py` + `tools/record.py`, no third-party deps).
- `PRINCIPLES.md` is now an explicit copy of the canonical version in the [autonomous-agent-principles](https://github.com/ntholm86/autonomous-agent-principles) repo.

### Removed
- The Tier 1 self-scoring rubric (10 weighted dimensions). Convergence (Principle 3) is now the only honest measure of done.
- `SCORECARD.md`, `METRICS_HISTORY.md`, `INTEGRITY.json`, `STANDARDS.md`, `PATTERNS.md`, `DESIGN_BACKLOG.md` from the live tree (preserved under `archive/v2/`).
- The `kata`, `kaizen`, `kaikaku`, `hansei`, `shiken`, `intent`, `kiroku` skill directories from the live tree (preserved under `archive/v2/`).
- All `.ps1` scripts from the live tree (preserved under `archive/v2/`).

### Convergence chain
- v2's in-progress 2/3 chain (Gemini 3.1 Pro + Grok Code Fast 1 at score 8.83) is invalidated by Principle 3, condition 2 (material change resets the counter). v3 must converge from zero on its own merits.

---

For history prior to v3, see [archive/v2/CHANGELOG.md](./archive/v2/CHANGELOG.md).
