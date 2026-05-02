# Changelog

## v3.15.0 — 2026-05-02

### Changed — all skills: explicit target-repo anchor for `.trail/` reads and writes

Every skill that reads or writes `.trail/` now explicitly states that `.trail/` is in the **target repo root** — never in the skills install directory. This closes a structural ambiguity: an agent running from the skills install directory could misinterpret bare `.trail/` references as relative to the install location rather than the target.

- `intent/SKILL.md` (v1.1.0 → v1.2.0) — "Read the accumulated context" now opens with the explicit anchor: "the target repo's `.trail/` folder (in the root of the repo being worked on — never in the skills install directory)".
- `improve/SKILL.md` (v3.4.0 → v3.5.0) — same anchor added to the trail-read step; fallback write step now says "`.trail/log.md` **in the target repo root**".
- `probe/SKILL.md` (v3.1.0 → v3.2.0) — fallback write step now says "`.trail/log.md` **in the target repo root**".
- `retrospect/SKILL.md` (v1.2.0 → v1.3.0) — arc-read step now says "`.trail/log.md` **in the target repo root**".
- `hunch/SKILL.md` (v1.0.0 → v1.1.0) — signal-gather step now opens with the explicit anchor; vision write step now says "`.trail/vision.md` **in the target repo root**".

`trail/SKILL.md` was already explicit — it is the reference implementation. All other skills now match it.



### Changed
- `intent/SKILL.md` (v1.0.0 → v1.1.0) — "Read the accumulated context" section now explicitly lists `.trail/vision.md` and `.trail/compass.md` as the first two documents to read before interpreting any prompt. Vision (operator-held destination) and compass (Retrospect-derived orientation) are the most important context for intent interpretation; reading only `log.md` and sessions was insufficient. Adds note: if no `.trail/` exists yet, run Hunch first.

### Added
- `README.md` — new "The recommended flow for a new codebase" section. Explains the Hunch-first onboarding flow (establish vision before the loop starts), the Intent+Improve loop, Trail's role as the evidence record, and Retrospect's role as the arc reader. Includes a table showing which skills read and write to `.trail/`. Captures the operator's articulation of how the skills compose through shared `.trail/` state.



### Added
- `POSITION.md` (v0.1) — new top-level stance document. Names what this repo is betting on: **operation-time trustworthy delegation** — what it takes for a human to safely hand real work to an AI more capable than themselves on that work and remain the responsible party. Defines the area via four sub-claims (operation-time, delegation, evidence-while-driving, protocol-not-tool), maps it against adjacent fields (scalable oversight, agentic AI safety, human-AI collaboration, constitutional AI, SRE), states what the repo is **not** claiming, and lists five explicit falsification criteria. Marked v0.1 and provisional. Aimed at skeptical technical practitioners; signed work, not corporate-we (run 71).
- `.trail/vision.md` — added "What this work is, beyond a skillset" section framing the repo as research as much as development; introduces the trustworthy-delegation question and the dashboard-instruments framing for transparency-while-steering. Drafted from operator intent via Hunch, not paraphrased from operator words (run 70).

## v3.13.0 — 2026-05-02

### Changed
- `trail/SKILL.md` (v1.7.0 → v1.8.0) — `history.md` generation is now **manual/on-demand only**. Removed mandatory `record.py history --write` post-session step. Commit step now only requires `log.md` (plus `compass.md` if Retrospect ran). `history.md` is a convenience file for humans, not part of the evidence chain — it should not be auto-generated after every session.

## v3.11.0 — 2026-05-01

### Added
- `hunch/SKILL.md` (v1.0.0) — new sixth skill. Invoked on demand (not in the autonomous loop). The agent forms guesses about where the operator is heading from signal in conversation, the trail, and the operator's reactions, then surfaces them as short, falsifiable questions the operator can confirm, correct, or reject. Closes the gap between explicit vision (what the operator has written down) and implicit direction (what the agent has picked up but the operator has not articulated). Addresses the human-articulation bottleneck that vision alone cannot solve. Hunch never writes to `.trail/vision.md` without operator approval (run 68).
- `README.md`, `CITATION.cff` — updated to describe the suite as six skills (run 68).

---

## v3.10.0 — 2026-05-01

### Added
- `.trail/vision.md` — new optional artifact: the **operator-held destination**. Stable across runs, never written by any skill, read by Improve at step 1 before compass and trail. Resolves the contract incoherence between Retrospect (which rewrites `.trail/compass.md` each run) and operator-written orientation that should not be overwritten. Vision is input to the loop; compass is output (run 67).

### Changed
- `improve/SKILL.md` (v3.3.0 → v3.4.0) — step 1 read order now: vision → compass → log. Vision is the destination, compass is the current location, trail is the path. Resolution rule on disagreement spelled out: vision wins over compass (operator holds destination); trail wins over compass (trail is evidence) (run 67).
- `retrospect/SKILL.md` (v1.1.0 → v1.2.0) — step 5 clarified: Retrospect reads vision but never writes to it. Compass shape extended with explicit "What the next runs should test" section (previously implicit). Frontmatter description updated to name vision as input (run 67).
- `trail/SKILL.md` (v1.6.0 → v1.7.0) — directory listing includes `vision.md`; commit step clarifies vision is committed only when the operator changes it, not as a side effect of any agent run (run 67).
- `README.md` — "How it works" updated for the vision/compass/trail read order (run 67).

---

## v3.9.1 — 2026-05-01

### Added
- `retrospect/SKILL.md` (v1.0.0 → v1.1.0) — new step 5: write `.trail/compass.md`, the **compass** for the target. After each retrospect run the arc-claims are written to `.trail/compass.md` — a plain file that distills the current synthesized understanding of the target and orients future runs. Retrospect owns it; Improve reads it (run 65).
- `improve/SKILL.md` — step 1 updated: check for `.trail/compass.md` before examining the target; if present, read it first before reading the full trail (run 65).
- `trail/SKILL.md` — directory structure updated to include `compass.md`; commit step updated to include `compass.md` when Retrospect ran this session (run 65).

---

## v3.9.0 — 2026-05-01

### Added
- `retrospect/SKILL.md` (v1.0.0) — new standalone arc-reflection skill. Reads `.trail/log.md` as a single document about the target and forms falsifiable arc-level claims. Runs independently of Improve when a high-altitude view is needed rather than another incremental pass. Includes an optional loop-effectiveness step (step 4) for evaluating whether the loop is examining the right things — a question that Improve's step 6 explicitly defers (run 64).
- `improve/SKILL.md` — step 6 intro and step 6b updated to reference Retrospect for arc-reads that run outside an improve iteration (run 64).

---

## v3.8.1 — 2026-05-01

### Fixed
- `improve/SKILL.md` step 7 fallback bullet — "Any reflection on the loop itself" replaced with target-anchored prompt matching step 6a (run 55).
- `tools/record.py` STUB_TEMPLATE — bare `TODO` under `### Reflection` replaced with four-section scaffold (falsifiable claim, named blind spot, imagined pushback, conditional macro-Hansei) so agents are prompted with the required structure at stub generation time (run 57).

### Documentation
- `README.md` — "Reflect" step description updated from "Is the loop converging or drifting?" to match v3.8.0 target-anchored Hansei (run 56).
- `README.md` table + `improve/SKILL.md` subtitle — stale 5-word formula "Examine. Decide. Change. Verify. Record." replaced with accurate 7-step sequence matching actual SKILL.md headings (run 60).
- `improve/SKILL.md` frontmatter description — rewritten to name all seven steps accurately; "change it" and "verify" were wrong/absent step names (run 61).
- `.zenodo.json` description — Improve step summary updated to include all six enumerable steps (run 59).

---

## v3.8.0 — 2026-05-01

### Changed
- `improve/SKILL.md` step 6 — "Reflect on the loop itself" replaced with "Reflect", split into two operations:
  - **6a. Per-iteration reflection** runs every iteration. Forces a falsifiable target-model claim, a named blind spot, and a perspective-injection question (what would someone who knows the target push back on).
  - **6b. Across-trail reflection** is conditional. Triggers: recurring *class* of finding, about to declare silence, prior `[!REALIZATION]` contradicted, or operator asked. Reads the trail as one document about the target.
  - Reflection is reframed throughout to be *about the target*, not *about the loop* — addressing templated arc-counting reflections observed across runs 48–53. Storage is the existing `[!REALIZATION]` marker; no new markers, files, or tooling.
  - Skill version: 3.2.0 → 3.3.0.
- `trail/SKILL.md` entry-shape template — the "Reflection" section description rewritten to match the new two-part structure (target-model claim + blind spot + push-back; arc-claim when triggered). Skill version: 1.5.0 → 1.6.0.

---

## v3.7.4 — 2026-05-01

### Fixed
- `.trail/README.md` line 32: `trail/log.md` → `.trail/log.md` in the skill description bullet for Trail.
- `.zenodo.json`: two occurrences of `trail/log.md` → `.trail/log.md` in the Zenodo metadata description HTML (Trail skill description and "Read in this order" list). Published on next Zenodo release.
- `CITATION.cff`: version updated to reflect current HEAD.

---

## v3.7.3 — 2026-05-01

### Fixed
- `tools/record.py` module docstring, subcommand description, and `_parse_entries()` docstring: `trail/log.md` → `.trail/log.md`. Post-rename sweep complete — grep for `[^.]trail/log.` across all live non-CHANGELOG files now returns zero hits.
- `trail/SKILL.md` grep example command: `trail/` → `.trail/` — users copying this to search their evidence directory would have got zero results.
- `trail/SKILL.md` "The test" sentence: `trail/log.md` → `.trail/log.md` — the skill's own definition of what the trail file is now names the correct path.

---

## v3.7.2 — 2026-05-01

### Fixed
- `trail/SKILL.md` frontmatter `description:` field, two example git commands: `trail/log.md` → `.trail/log.md`.
- `README.md`: two references to `trail/log.md` in the "How it works" and "Evidence" sections corrected.
- `verify.py` `REQUIRED_FILES` list: `trail/log.md` → `.trail/log.md`, `trail/README.md` → `.trail/README.md`.

---

## v3.7.1 — 2026-05-01

### Fixed
- `tools/record.py`: added `sys.stdout.reconfigure(encoding='utf-8')` at the start of `main()`. Users on Windows with cp1252 or similar non-UTF-8 default code pages received a `UnicodeEncodeError` on any run that printed trail content containing em-dash or other non-ASCII characters.

---

## v3.7.0 — 2026-05-01

### Changed — Breaking
- Evidence directory renamed from `trail/` to `.trail/` in both the skills repo and the trail skill convention. The hidden-directory convention (`.trail/`) keeps the evidence in the repo without cluttering directory listings.

### Migration
Any target repo that has previously run the trail skill must be migrated:
```bash
git mv trail .trail
git commit -m "trail: rename trail/ to .trail/"
```
Update any CI scripts, `grep` commands, or external links that reference `trail/log.md` → `.trail/log.md` and `trail/history.md` → `.trail/history.md`. Set `$TRAIL_ROOT` if you cannot run `record.py` from the target repo root.

---

## v3.6.1 — 2026-04-30

### Fixed
- `INSTALLING.md`, `README.md`: added `tools/` to the full-install directory tree and quick-start step (missing since v3.5.0 moved `record.py` to the skills install).
- `trail/SKILL.md`, `improve/SKILL.md`, `README.md`: corrected `record.py` path prefix from `tools/record.py` to `<skills>/tools/record.py` — the script lives in the skills install, not the target repo root.
- `INSTALLING.md`, `improve/SKILL.md`: removed all references to `CONVERGENCE_SCOPE_PROTOCOL.md`, which no longer exists in the repo.
- `probe/SKILL.md`: removed unexplained v2 jargon "(Tier 1)" and replaced with a self-contained description of the failure mode being avoided.
- `INSTALLING.md`, `README.md`: removed `verify.py` from the exported `tools/` list; moved it to the repo root as an internal CI script. Users should not copy it to their target repos.

### Rationale
Five documentation-drift fixes found by the convergence loop running self-targeted after v3.6.0. Each finding had the same root cause: when an architectural decision is made, references in surrounding documentation don't get swept. All five are now resolved.

---

## v3.6.0 — 2026-04-30

### Changed
- `trail/SKILL.md` v1.5.0: added `### Multi-iteration runs` protocol under "When to write an entry". Each iteration is a separate trail entry appended and committed **before** the next iteration begins. A partial run must produce partial trail — batch writing at end-of-session is now an explicit violation.
- `improve/SKILL.md` v3.2.0: step 7 "Record" now opens with the multi-iteration requirement. A user who stops a 10-iteration run after iteration 4 must have 4 committed trail entries, not 0.

### Rationale
The per-iteration commit requirement was always implied by "write during the session, not after" but never stated as a structural rule. This session produced evidence that an agent will batch-write at the end unless the rule is explicit: three trail entries written in a single block at session end, rather than one per iteration. The fix makes the checkpoint sequence (`iteration → append entry → record.py history --write → commit`) a first-class part of both skills.

---

## v3.5.0 — 2026-04-30

### Changed
- `tools/record.py` now resolves the trail root from `$TRAIL_ROOT` or current working directory — no longer from its own file location. The script stays in the skills install and writes to whatever target repo invokes it. **No more copying `record.py` into target repos.**
- `trail/SKILL.md`: removed the "copy `record.py` into target repo" init step. Init now creates only `trail/log.md`. Documentation shows invoking `python <skills>/tools/record.py ...` from the target repo root.
- `INSTALLING.md`: same simplification.

### Rationale
A `record.py` showing up in someone else's repo trail folder is noise that creates confusion ("what is this script doing in my repo?"). The skill should leave a minimum, legible footprint in the target repo: `log.md` and `history.md`, both human-readable, both committed. The tool that produces them belongs in the skills install.

### Migration
If an existing target repo has `trail/record.py`, simply `git rm` it — stop committing it going forward. Existing `trail/log.md` and `trail/history.md` are unaffected; regenerate `history.md` by invoking the skills-install copy from the target repo root.

---

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

## v3.3.1 — 2026-04-29

### Changed
- `improve/SKILL.md`: principles inlined; `PRINCIPLES.md` and `CONVERGENCE_SCOPE_PROTOCOL.md` references changed to "if available".
- `probe/SKILL.md`: ARF definition inlined; `PRINCIPLES.md` reference changed to "if available".
- `trail/SKILL.md`: added self-init instruction — create `trail/log.md` if it does not exist.

All four skills now operate correctly with only their own `SKILL.md` present — no required sibling files.

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

Radical redesign. See [.trail/log.md](./.trail/log.md) for the rationale and decision trail.

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
