# History

Auto-generated from `trail/log.md` by the `record.py history --write` command in the autonomous-agent-skills install.
Do not edit by hand — re-run the command to refresh.

| # | Date | Slug | Outcome | Delta |
|---|------|------|---------|-------|
| ▸ 1 | 2026-04-23 | v3 redesign | redesign executed; v3 structure shipped on branch `v3-redesign` | v2.4.1 → v3.0.0 (not yet merged to main, not yet tagged) |
| ▸ 2 | 2026-04-23 | v3 self-target and v2 retirement | minor changes (drift markers + retirement notice); no structural changes | same author/session as the v3-redesign entry above; chain not yet started |
| ▸ 3 | 2026-04-23 | v3-clean-root-waste | v2 artifacts removed from live tree; chain reset | v3-redesign branch |
| ▸ 4 | 2026-04-23 | v3-citation-update | citation and release workflow updated | CITATION.cff and .github/workflows/release.yml aligned with v3 |
| ▸ 5 | 2026-04-23 | v3-principles-copy-repair | principles copy repaired and verifier hardened | PRINCIPLES.md de-duplicated; tools/verify.py now rejects duplicate H1 docs and broken local markdown links |
| ▸ 6 | 2026-04-23 | observable-loops-decision | design decision recorded; addendum spec drafted | OBSERVABLE-LOOPS.md added (v0.1 draft); no skill behaviour or runtime change |
| ▸ 7 | 2026-04-23 | v3 evaluation | identified structural gaps in tooling (verify.py) and probe skill; changes proposed | none yet (evaluation phase complete) |
| ▸ 8 | 2026-04-23 | v3-changelog-splice-repair | CHANGELOG.md de-spliced; 626 lines of v2 body removed from live file | CHANGELOG.md 651 lines → 25 lines |
| · 9 | 2026-04-24 | v3-silence-1 | silence — nothing actionable found; convergence chain peg 1/3 | none |
| · 10 | 2026-04-24 | v3-silence-2 | silence — nothing actionable found; convergence chain peg 2/3 | none |
| ▸ 11 | 2026-04-24 | v3-verifier-scope-repair | actionable finding fixed — verifier mojibake scan scope aligned with stated live-tree contract; convergence chain reset | tools/verify.py (`skip_dirs` changed from `{archive,.git,.github,tools}` to `{archive,.git}`) |
| ▸ 12 | 2026-04-24 | intent-done-condition-canonicalized | intent and done-condition contract added to live docs; convergence interpretation clarified | README.md and trail/README.md updated |
| ▸ 13 | 2026-04-24 | convergence-scope-protocol-adopted | convergence scope protocol added and integrated into Grasp inputs; verifier now requires protocol file | CONVERGENCE_SCOPE_PROTOCOL.md added; README.md, trail/README.md, improve/SKILL.md, tools/verify.py updated |
| ▸ 14 | 2026-04-24 | v3-baseline-lock | baseline locked | trail/log.md appended only |
| · 15 | 2026-04-24 | v3-silence-1 | silence — nothing actionable found; skills convergence peg 1/3 under convergence scope protocol | trail/log.md appended only |
| · 16 | 2026-04-24 | v3-silence-2 | silence — nothing actionable found; skills convergence peg 2/3 under convergence scope protocol | trail/log.md appended only |
| · 17 | 2026-04-24 | v3-silence-3 | silence — nothing actionable found; skills convergence peg 3/3 under convergence scope protocol | trail/log.md appended only |
| · 18 | 2026-04-24 | v3-coherence-silence | silence — no cross-layer contradictions found; coherence check passed under convergence scope protocol | trail/log.md appended only |
| ▸ 19 | 2026-04-24 | trail/README.md drift fix | trail/README.md rewritten to match actual v3 structure; v3.0.1 cut | v3.0.0 -> v3.0.1 |
| ▸ 20 | 2026-04-24 | v3.0.1 chain status declared | chain status made explicit; no artifact change | trail/log.md appended only |
| ▸ 21 | 2026-04-24 | trail-README-splice-repair | actionable finding fixed — trail/README.md had v2 splice tail (lines 45-70); fully removed; convergence chain resets to 0/3 | trail/README.md truncated from 70 lines to 44 lines; chain reset |
| ▸ 22 | 2026-04-24 | v3-peg2-openai-metadata-fix | actionable finding fixed — version metadata aligned with v3.0.1 tag; convergence chain reset | README.md, CHANGELOG.md, CITATION.cff |
| · 23 | 2026-04-24 | v3-silence-1 | silence — nothing actionable found; skills convergence peg 1/3 | trail/log.md appended only |
| · 24 | 2026-04-24 | v3-silence-2 | silence — nothing actionable found; skills convergence peg 2/3 | none |
| · 25 | 2026-04-24 | v3-silence-3 | silence — nothing actionable found; skills convergence peg 3/3 | none |
| · 26 | 2026-04-24 | cross-layer-coherence | silence — no contradiction found across all three layers; coherence check passes | none |
| ▸ 27 | 2026-04-28 | four-skill composable architecture | two new skills added (Intent, Trail); Improve and Probe refactored to delegate; README updated | v3.1.0 → v3.2.0 (live tree, not yet tagged) |
| ▸ 28 | 2026-04-29 | v3.3.0-history-and-install | history command added to record.py; INSTALLING.md created; README opening rewritten | v3.2.0 → v3.3.0 |
| ▸ 29 | 2026-04-30 | v3.3.2-trail-location-fix | trail SKILL.md location ambiguity fixed; v3.3.2 shipped | v3.3.1 -> v3.3.2 |
| ▸ 30 | 2026-04-30 | readme-human-scan-and-user-direction | README tightened for human scanning; user-set direction made explicit | README wording only; no behavior change |
| ▸ 31 | 2026-04-30 | verify-contract-and-trail-repair | verifier aligned with current repo contract; trail integrity restored | `tools/verify.py`, `improve/SKILL.md`, `CHANGELOG.md`, `trail/log.md`, `trail/history.md` |
| ▸ 32 | 2026-04-30 | trail-readme-skill-count | changed — corrected stale skill count in trail/README.md | trail/README.md "The two skills" → "The four skills" (intent, improve, probe, trail) |
| ▸ 33 | 2026-04-30 | readme-title-and-hook | changed — README title and opening paragraph rewritten for first impression | README.md title "Skills" → "Autonomous Development Skills Suite"; opening paragraph now leads with what it does, proof, and stopping condition |
| ▸ 34 | 2026-04-30 | readme-goal-section | changed — added "The goal" section to README.md | README.md gains explicit statement of operator intent and verification philosophy |
| ▸ 35 | 2026-04-30 | readme-stopped-to-converged | changed — "stopped" → "converged" in README opening paragraph | one word change; README opening now consistent with PRINCIPLES.md definition and Evidence section framing |
| ▸ 36 | 2026-04-30 | install-instructions-missing-tools | changed | added \	ools/\ to README.md and INSTALLING.md copy instructions |
| ▸ 37 | 2026-04-30 | relative-path-inconsistencies | changed | fixed broken link to format spec and invalid relative paths to record.py in documentation |
| ▸ 38 | 2026-04-30 | ghost-protocol-reference | changed | removed references to nonexistent CONVERGENCE_SCOPE_PROTOCOL.md from INSTALLING.md and improve/SKILL.md |

### Run 1 — 2026-04-23 — v3 redesign

- **decided:** Execute the full critique. Honest minimum: 2 skills (Improve + Probe), one trail file (`trail/log.md`), no Tier 1 scoring, Python scripts instead of PowerShell. Keep the repo name `kata` as a historical codename to preserve URL/DOI/citation lineage. Do not tag or merge — leave that to the maintainer.
- **decided:** Use the `improve` skill (in its just-created v3 form) to drive this redesign rather than running the v2 Kata loop on itself. Running the v2 loop would generate trail evidence but no new insight; the reasoning had already happened in the prior conversation. Ceremony for ceremony's sake is exactly what v3 is meant to remove.

### Run 2 — 2026-04-23 — v3 self-target and v2 retirement

- **decided:** Make three small changes:
- **decided:** Do NOT shorten `improve/SKILL.md` further. The numbered-phase observation is a real but borderline finding; acting on it in the same session that wrote it is churn. If a fresh-session evaluator surfaces the same finding independently, that's evidence the change is warranted. Otherwise, leave it.

### Run 3 — 2026-04-23 — v3-clean-root-waste

- **decided:** I must fail the convergence check (i.e., not declare silence) because actionable waste and inconsistency were found. I will remove the duplicate retired v2 files from the root to align the repository tree with the declared v3 architecture.

### Run 4 — 2026-04-23 — v3-citation-update

- **decided:** Make incremental changes to CITATION.cff and release.yml to eliminate the inconsistencies. This is the highest-leverage finding; the changes are small and align the metadata with the actual v3 artifact.

### Run 5 — 2026-04-23 — v3-principles-copy-repair

- **decided:** Make one incremental repair to the principles copy and one adjacent verifier hardening change. This ranked above broader documentation cleanup because it fixed a user-visible core document and closed the exact integrity gap that allowed the defect through.

### Run 6 — 2026-04-23 — observable-loops-decision

- **decided:** Adopt Ralph as a substrate, do not conform to it neat. Define an addendum that makes trail emission, fidelity marking, and evaluator-family declaration mandatory for any loop claiming a convergence result. Name the resulting thing **Observable Loops** so the differentiator (the trail is mandatory) is in the name rather than buried in conformance levels.
- **decided:** This work is a redesign/feature track, not an improve run. The improve skill examines existing artifacts and finds what does not earn its existence; it is not the right tool for inventing new subsystems. Inventive work belongs in design documents (REDESIGN.md, OBSERVABLE-LOOPS.md). Improve will be able to run on the resulting implementation later.

### Run 7 — 2026-04-23 — v3 evaluation

- **decided:** Record the findings in the trail before proceeding to make the changes, ensuring the evaluation phase itself is observable. I will propose fixing `probe/SKILL.md` to include metadata, exempting `PRINCIPLES.md` from local link checks in `verify.py`, and adding a strict malformed-heading check to `verify.py`.

### Run 8 — 2026-04-23 — v3-changelog-splice-repair

- **decided:** Remove the spliced v2 content from CHANGELOG.md. Single highest-leverage finding: eliminates 626 lines of genuine waste, resolves a direct contradiction (redirect pointer vs. inline content), and is safe to execute without operator confirmation. The change is reversible (`git checkout CHANGELOG.md`) and leaves `python tools/verify.py` passing.

### Run 9 — 2026-04-24 — v3-silence-1

- **decided:** Silence. Nothing actionable was found. This is peg 1/3 in the v3 convergence chain.

### Run 10 — 2026-04-24 — v3-silence-2

- **decided:** Silence. The suite contains no actionable findings. This is peg 2/3 in the v3 convergence chain.

### Run 11 — 2026-04-24 — v3-verifier-scope-repair

- **decided:** Apply one incremental fix in `tools/verify.py`: remove unintended `.github` and `tools` exclusions from mojibake scanning so implementation and declared contract match.
- **REVERSAL:** Initial path considered: silence peg 3/3. Reversed after full-tree read surfaced the verifier scope mismatch as a material, low-risk, high-leverage fix.

### Run 12 — 2026-04-24 — intent-done-condition-canonicalized

- **decided:** Add the canonical intent/done-condition text to `README.md` and add a convergence-intent interpretation paragraph to `trail/README.md`.

### Run 13 — 2026-04-24 — convergence-scope-protocol-adopted

- **decided:** Add `CONVERGENCE_SCOPE_PROTOCOL.md` as the canonical scope/reset policy and make it mandatory pre-read for convergence runs via references in `README.md`, `trail/README.md`, and `improve/SKILL.md`.
- **decided:** Add the protocol file to `tools/verify.py` required files to keep governance artifacts mechanically enforced.

### Run 14 — 2026-04-24 — v3-baseline-lock

- **decided:** Freeze references for intent, problem, principles, and skills at explicit repo+ref coordinates so downstream runs can be judged against a fixed target.

### Run 15 — 2026-04-24 — v3-silence-1

- **decided:** Silence. The skills layer is consistent, minimal, and cleanly upholds the principles defined in `PRINCIPLES.md` and `PROBLEM.md` (which are locked upstream). Nothing material needs to be altered or redesigned.

### Run 16 — 2026-04-24 — v3-silence-2

- **decided:** Silence. Nothing actionable was found. This is peg 2/3 in the v3 skills convergence chain under the convergence scope protocol.

### Run 17 — 2026-04-24 — v3-silence-3

- **decided:** Silence. Nothing actionable was found. This run advances the skills convergence chain to peg 3/3 under the convergence scope protocol.

### Run 18 — 2026-04-24 — v3-coherence-silence

- **decided:** Silence. No cross-layer contradiction found at any junction. Full cross-layer trace is coherent end-to-end: Problem → Principles → Skills. This is the Step 4 outcome under the convergence scope protocol.

### Run 19 — 2026-04-24 — trail/README.md drift fix

- **decided:** Rewrite `trail/README.md` to describe the actual three-resolution-across-two-files structure, with a grep example for the indexed layer. Update the Glossary to reflect v3 skills (`improve`, `probe`) and note v1/v2 vocabulary preserved in `archive/v2/`.
- **decided:** Do not change PROOF.md in the manifesto. The L52 phrasing ("the resolution they need") doesn't claim a number; the three-resolution claim holds. The `trail/README.md` defect is a kata-repo issue outside the manifesto convergence chain's scope.
- **decided:** Cut v3.0.1 for the README fix. Keep v3.0.0 tag at d75b5e1 (the convergence-validated commit) — that is what the chain ratified.

### Run 20 — 2026-04-24 — v3.0.1 chain status declared

- **decided:** Declare the convergence chain reset to 0/3 as of v3.0.1 / fc91fa1. The v3.0.0 chain remains valid evidence for what it ratified (commit d75b5e1, the pre-fix state of the suite). It does not ratify the post-fix state. A new chain — three fresh-session evaluations from distinct evaluator families against the v3.0.1 live tree — is required to re-converge.
- **decided:** Do not retroactively edit the v3.0.1 trail entry. Append-only ledger; later clarifications go in later entries.

### Run 21 — 2026-04-24 — trail-README-splice-repair

- **decided:** Truncate trail/README.md to the clean v3 section (lines 1-44). Single operation; no information loss (v2 archive exists for provenance).

### Run 22 — 2026-04-24 — v3-peg2-openai-metadata-fix

- **decided:** Align the version metadata with the existing v3.0.1 tag across README, CHANGELOG, and CITATION.

### Run 23 — 2026-04-24 — v3-silence-1

- **decided:** Silence. Nothing actionable was found. This is skills convergence peg 1/3.

### Run 24 — 2026-04-24 — v3-silence-2

- **decided:** Silence. Nothing actionable was found. This is skills convergence peg 2/3.

### Run 25 — 2026-04-24 — v3-silence-3

- **decided:** Silence. No actionable material issues found in the skills layer. This completes skills convergence peg 3/3.

### Run 26 — 2026-04-24 — cross-layer-coherence

- **decided:** Silence. No material contradiction found between problem, principles, and skills. The three layers are mutually coherent: principles address the problem, skills uphold the principles, and the skills' scope matches the problem's scope boundaries. This satisfies step 4 of the convergence scope protocol.

### Run 27 — 2026-04-28 — four-skill composable architecture

- **decided:** Add Intent and Trail as first-class skills alongside Improve and Probe. Keep Improve and Probe fully functional as standalone skills by using "if X is installed, delegate; otherwise do it yourself" pattern — not hard dependencies.
- **decided:** README describes the composable installation progression: Intent alone → add Trail → add Improve → add Probe = full loop. This is the entry-point story for new users.
- **decided:** Convergence on v3 is the maintainer's to drive, not mine. They will need at least three independent fresh-conversation evaluations from distinct model families, each re-deriving the measurement scheme, each finding nothing material to change. v3.0.0 will not be tagged until that chain reaches 3/3.

### Run 28 — 2026-04-29 — v3.3.0-history-and-install

- **decided:** Rewrite README opening paragraph to lead with "autonomous self-improving loop" and establish that the loop has run on this repo repeatedly under observation.
- **decided:** Add `record.py history` command that parses trail/log.md and renders a per-run timeline: date, slug, outcome, delta, decisions. Use `▸` for change runs and `·` for silence runs so convergence direction is visible at a glance.
- **decided:** Add INSTALLING.md explaining the one-level-deep discovery rule, minimum vs full install, and what sibling files each skill needs. Link from README "Using the skills" section.
- **decided:** Increment to v3.3.0. No skill logic changed; no convergence chain impact. These are tooling and documentation additions.

### Run 29 — 2026-04-30 — v3.3.2-trail-location-fix

- **decided:** Added explicit location statement to The Structure section of trail/SKILL.md: 'The trail lives in the root of the target repo being worked on - not in the skills install directory.' With concrete examples (`c:\git\clikit\trail\log.md`).

### Run 30 — 2026-04-30 — readme-human-scan-and-user-direction

- **decided:** Keep the README structure intact and tighten the wording locally. The load-bearing fix is to state, early in "How it works," that the user sets the direction in the prompt and the agent is autonomous in how it gets there.
- **decided:** Preserve the three principle callouts, but rewrite them to explain the mechanism at the point of use rather than restate abstract principle language.

### Run 31 — 2026-04-30 — verify-contract-and-trail-repair

- **decided:** Fix the verifier contract in code instead of restoring removed placeholder files. The repo truth lives in the current docs and changelog; the verifier must follow that truth.
- **decided:** Repair the trail data rather than weakening the trail checks. The point of the verifier is to catch exactly this kind of drift.

### Run 32 — 2026-04-30 — trail-readme-skill-count

- **decided:** Fix trail/README.md. Single highest-leverage change: a REQUIRED_FILE containing an actively false claim about the number of skills. A user reading trail/ directory would believe the suite is two skills and that Intent was retired. Both wrong.

### Run 33 — 2026-04-30 — readme-title-and-hook

- **decided:** Title + opening paragraph. Single incremental change. Ranked alternatives: (1) title fix only — would improve headline but not the hook; (2) restructure the whole page — overkill, structure is sound; (3) this change — highest leverage per word changed.

### Run 34 — 2026-04-30 — readme-goal-section

- **decided:** Add "The goal" section immediately after the opening paragraph. This is the highest-leverage single addition: it is the answer to the first question any new reader should ask, and without it the rest of the README reads as a feature description rather than a principled claim.

### Run 35 — 2026-04-30 — readme-stopped-to-converged

- **decided:** Change "stopped" to "converged" in the opening paragraph. One word. The opening is the first statement any reader or agent encounters about what the loop does. If it encodes the wrong mental model of convergence (permanent cessation vs. point-in-time state), that model propagates into how the agent understands the stopping condition. Alternatives ranked: (1) this change — highest leverage per word changed; (2) add first-run guidance to Intent — addresses a minor edge case; (3) declare convergence — premature given the identified inconsistency.

### Run 36 — 2026-04-30 — install-instructions-missing-tools

- **decided:** Update \README.md\ and \INSTALLING.md\ to explicitly include \	ools/\ in the installation instructions. Alternatives ranked: (1) this change — fixes a broken workflow that violates Observable Autonomy due to missing tooling; (2) change \	rail/SKILL.md\ to make \	ools/\ an optional sibling file — rejected, trail requires history generation to fulfill multi-resolution observability; (3) silence — rejected, the local install instructions actively broke the workflow.

### Run 37 — 2026-04-30 — relative-path-inconsistencies

- **decided:** Update relative paths in improve/SKILL.md, 	rail/SKILL.md, and README.md to correct the dead format spec link and explicitly use <skills>/tools/record.py for commands meant to be run from target repos.

### Run 38 — 2026-04-30 — ghost-protocol-reference

- **decided:** Remove the two stale references. Rationale: a named optional file that does not exist is worse than no mention — it creates a search cost for users and agents that always fails. Generic language ("read the repo's convergence-scope protocol if it has one") is correct for any target repo, whether or not one exists. Alternatives: (1) re-add the file — rejected, the protocol content was absorbed into improve/SKILL.md and PRINCIPLES.md; (2) silence — rejected, the references were demonstrably stale.

**38 runs total — 28 with changes, 10 silence**
