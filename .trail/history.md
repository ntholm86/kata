# History

Auto-generated from `.trail/log.md` by the `record.py history --write` command in the autonomous-agent-skills install.
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
| ▸ 39 | 2026-04-30 | probe-unexplained-v2-jargon | one incremental change | replaced "(Tier 1)" jargon with an explanation readable without v2 knowledge |
| ▸ 40 | 2026-04-30 | remove-verify-from-export | one incremental change | moved verify.py out of the exportable tools/ config directory |
| ▸ 41 | 2026-04-30 | changelog-version-drift | one incremental change | added v3.6.1 entry to CHANGELOG.md; bumped version string in README.md |
| ▸ 42 | 2026-04-30 | indexed-marker-grep-path | one incremental change | fixed broken grep command path in indexed-marker recovery instructions |
| ▸ 43 | 2026-04-30 | trail-readme-v2-vocabulary | one incremental change | removed "kata skills" from H1 title — retired v2 vocabulary |
| ▸ 44 | 2026-04-30 | trail-readme-shiken-jargon | one incremental change | removed "(Shiken-style)" v2 jargon from probe skill description |
| · 45 | 2026-04-30 | claude-silence-run-1 | silence | none — zero actionable findings |
| · 46 | 2026-05-01 | claude-silence-run-2 | silence | none — zero actionable findings; second consecutive silence from this model family |
| ▸ 47 | 2026-05-01 | trail-dir-rename-to-dottrail | changed — structural fix; evidence trail moved from `trail/` to `.trail/` | v3.6.1 → v3.7.0 |
| ▸ 48 | 2026-05-01 | record-py-unicode-fix | changed — `record.py history` UnicodeEncodeError on Windows fixed; v3.7.1 | v3.7.0 → v3.7.1 |
| ▸ 49 | 2026-05-01 | trail-stale-paths-cleanup | changed — stale `trail/log.md` paths from v3.7.0 rename fixed; v3.7.2 | v3.7.1 → v3.7.2 |
| ▸ 50 | 2026-05-01 | trail-stale-paths-final | changed — remaining stale `trail/log.md` paths fixed in record.py and trail/SKILL.md; v3.7.3 | v3.7.2 → v3.7.3 |
| ▸ 51 | 2026-05-01 | changelog-v370-v373 | changed — CHANGELOG entries for v3.7.0–v3.7.3 written; README version updated to v3.7.3 | v3.7.3 (CHANGELOG + README only; no code change) |
| ▸ 52 | 2026-05-01 | stale-paths-zenodo-citation | changed — three stale paths / version mismatches fixed in .trail/README.md, .zenodo.json, CITATION.cff; v3.7.4 | v3.7.3 → v3.7.4 |
| ▸ 53 | 2026-05-01 | version-consistency-v374 | changed — CHANGELOG entry for v3.7.4 written; README and CITATION.cff updated to v3.7.4 | v3.7.4 (CHANGELOG + README + CITATION.cff only; no code change) |
| ▸ 54 | 2026-05-01 | reflect-step-hansei-rewrite | changed — `improve/SKILL.md` step 6 rewritten as two-part Hansei (per-iteration + conditional across-trail); `trail/SKILL.md` Reflection template updated to match | v3.7.4 → v3.8.0; improve 3.2.0 → 3.3.0; trail 1.5.0 → 1.6.0 |
| ▸ 55 | 2026-05-01 | fallback-reflection-bullet | changed — step 7 fallback bullet "Any reflection on the loop itself" replaced with target-anchored equivalent matching new step 6 | v3.8.0 (improve/SKILL.md only; no version bump warranted — v3.8.0 echo cleanup, not new content) |
| ▸ 56 | 2026-05-01 | readme-reflection-echo | changed — updated README.md's description of the 'Reflect' step to reflect v3.8.0's target-anchored Hansei instead of old loop-convergence wording | none (documentation cleanup echo) |
| ▸ 57 | 2026-05-01 | stub-reflection-scaffold | changed — `tools/record.py` STUB_TEMPLATE `### Reflection` section upgraded from bare `TODO` to structured three-prompt scaffold matching step 6a + conditional 6b | none (tooling quality improvement, no version bump) |
| · 58 | 2026-05-01 | echo-sweep-silence | silence — full repo sweep found no remaining v3.8.0 echo in any active instruction file | none |
| ▸ 59 | 2026-05-01 | zenodo-description-update | changed — updated .zenodo.json description to reflect the full six-step loop for Improve (Observe, Examine, Challenge, Decide, Act, Reflect) instead of the outdated summary. | none |
| ▸ 60 | 2026-05-01 | tagline-step-names | changed — updated SKILL.md subtitle and README table entry from the old 5-word formula ("Examine. Decide. Change. Verify. Record.") to the accurate 7-step sequence matching actual step headings | none (documentation alignment) |
| ▸ 61 | 2026-05-01 | frontmatter-description-fix | changed — rewritten `improve/SKILL.md` frontmatter `description` to use accurate step verbs; removed "verify, and record" tail and "change it" misname | none (no behaviour change, skill routing text updated) |
| ▸ 62 | 2026-05-01 | v381-patch-release | changed — cut v3.8.1 patch release; CHANGELOG, README version line, CITATION.cff all bumped from 3.8.0 → 3.8.1 | v3.8.1 |
| · 63 | 2026-05-01 | silence-run-63 | silence — no actionable finding after full sweep of all active files | none |
| ▸ 64 | 2026-05-01 | feat-retrospect-skill | added Retrospect — new standalone arc-reflection skill (v1.0.0) | v3.8.1 → v3.9.0 |
| ▸ 65 | 2026-05-01 | feat-working-model | added `.trail/model.md` as the working model artifact — written by Retrospect, read by Improve | v3.9.0 → v3.9.1 |
| ▸ 66 | 2026-05-01 | docs-readme-compass-orientation | fixed stale README description — runs now start with compass.md, not the full trail | v3.9.1 (no version bump — docs fix only) |
| ▸ 67 | 2026-05-01 | compass-seed-evo-vision | created .trail/compass.md — first compass for this repo, capturing the evo connection and constraints that must hold before integration | no version bump — compass is a new artifact, not a code change |
| ▸ 68 | 2026-05-01 | split-vision-from-compass | introduced `.trail/vision.md` as a sibling to `.trail/compass.md`; vision is operator-held and never written by any skill, compass is Retrospect-derived and rewritten each run | suite v3.9.1 → v3.10.0; improve 3.3.0 → 3.4.0; retrospect 1.1.0 → 1.2.0; trail 1.6.0 → 1.7.0 |
| ▸ 69 | 2026-05-01 | hunch-skill-added | added Hunch as the sixth skill — on-demand interview mechanism that surfaces the agent's guesses about where the operator is heading and turns them into questions the operator can confirm or correct | suite v3.10.0 → v3.11.0; new `hunch/SKILL.md` v1.0.0 |
| ▸ 70 | 2026-05-01 | hunch-on-operator-vision-intent | vision.md gained a top-section research framing — "architecture of trustworthy delegation" — drafted from intent rather than operator's words, approved before write | .trail/vision.md +14 lines (new "What this work is, beyond a skillset" section) |

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

### Run 39 — 2026-04-30 — probe-unexplained-v2-jargon

- **decided:** Remove the unexplained v2 jargon and replace with a self-contained explanation of the failure mode being avoided. The functional claim of the sentence is preserved; the opaque reference is eliminated.

### Run 40 — 2026-04-30 — remove-verify-from-export

- **decided:** Move `verify.py` from `tools/` into the repo root (`verify.py`), and remove it from `INSTALLING.md`'s exported full-install tree.
- **REVERSAL:** Reverses the portion of Iteration 1's decision that implicitly told users to copy `verify.py` by grouping it in the `tools/` directory export.

### Run 41 — 2026-04-30 — changelog-version-drift

- **decided:** Add a v3.6.1 entry to CHANGELOG.md summarising all five fixes from Iterations 1–5, and bump the version string in README.md to match.

### Run 42 — 2026-04-30 — indexed-marker-grep-path

- **decided:** Change the grep target from `trail/sessions/` to `trail/` in both files. This covers `log.md` (where markers actually live) and `sessions/*.md` (if the optional layer is in use).

### Run 43 — 2026-04-30 — trail-readme-v2-vocabulary

- **decided:** Remove "kata skills" subtitle from the H1. Change to `# Audit Trail` — accurate and version-stable without referencing a retired name.

### Run 44 — 2026-04-30 — trail-readme-shiken-jargon

- **decided:** Remove "(Shiken-style)" from the probe bullet in `trail/README.md`. The sentence is complete and accurate without it.

### Run 45 — 2026-04-30 — claude-silence-run-1

- **decided:** Declare silence. Nothing actionable remains for this model family to find.

### Run 46 — 2026-05-01 — claude-silence-run-2

- **decided:** Declare silence. Nothing actionable found that would improve the skills' effectiveness on an arbitrary codebase.

### Run 47 — 2026-05-01 — trail-dir-rename-to-dottrail

- **decided:** Move evidence (`log.md`, `history.md`, `sessions/`) from `trail/` to `.trail/`. Update the skill convention in all four SKILL.md files, INSTALLING.md, README.md, trail/README.md, verify.py, and tools/record.py to use `.trail/` as the evidence location. The skill definition folder (`trail/SKILL.md`, `trail/README.md`) stays at `trail/`.

### Run 48 — 2026-05-01 — record-py-unicode-fix

- **decided:** Add `sys.stdout.reconfigure(encoding='utf-8')` at the start of `main()` in `tools/record.py`, guarded by `hasattr` for robustness. This configures stdout to write UTF-8 bytes regardless of the platform default, fixing the crash for all trail content (em-dashes, arrows, `▸`, `·`, and any other Unicode chars trail entries may contain).

### Run 49 — 2026-05-01 — trail-stale-paths-cleanup

- **decided:** Fix all five stale `trail/log.md` path references in the live skill surface to `.trail/log.md`. Treat as one conceptual change: cleanup of the v3.7.0 rename across the user-facing surface.

### Run 50 — 2026-05-01 — trail-stale-paths-final

- **decided:** Fix all five remaining stale `trail/log.md` references: `record.py` module and subcommand docstrings (×3), `trail/SKILL.md` grep example, `trail/SKILL.md` "The test" sentence.

### Run 51 — 2026-05-01 — changelog-v370-v373

- **decided:** Write CHANGELOG entries for v3.7.0, v3.7.1, v3.7.2, v3.7.3. Update README version line. No code changes — this is documentation-only but addresses a genuine user-facing gap: the breaking rename has no migration note visible to anyone not reading the trail.

### Run 52 — 2026-05-01 — stale-paths-zenodo-citation

- **decided:** Fix three findings:

### Run 53 — 2026-05-01 — version-consistency-v374

- **decided:** Write CHANGELOG v3.7.4 entry. Update README version line to v3.7.4. Update CITATION.cff to v3.7.4. No code changes.

### Run 54 — 2026-05-01 — reflect-step-hansei-rewrite

- **decided:** Rewrite step 6 of `improve/SKILL.md` as two operations: 6a "Per-iteration reflection" (every iteration; falsifiable target-model claim, named blind spot, perspective-injection question), and 6b "Across-trail reflection" (conditional on four named triggers; reads `.trail/log.md` as one document about the target). Update the Reflection template in `trail/SKILL.md` consistently. Reuse `[!REALIZATION]` as the storage marker. Keep wording target-agnostic (no self-targeting branch). Bump improve 3.2.0→3.3.0, trail 1.5.0→1.6.0, suite 3.7.4→3.8.0.

### Run 55 — 2026-05-01 — fallback-reflection-bullet

- **decided:** Replace step 7's bullet `Any reflection on the loop itself.` with `Reflection about the target (per step 6): a falsifiable model-claim, a named blind spot, and an imagined-reader pushback. Across-trail reflection if its triggers fired.`

### Run 56 — 2026-05-01 — readme-reflection-echo

- **decided:** Replace the stale "Reflect" description in `README.md` with wording that accurately mirrors the v3.8.0 specification (falsifiable claim about target, named blind spot, imagined reader pushback, and across-trail macro-Hansei).

### Run 57 — 2026-05-01 — stub-reflection-scaffold

- **decided:** Replace the bare `TODO` under `### Reflection` in `STUB_TEMPLATE` with a four-section scaffold: falsifiable claim, named blind spot, imagined-reader pushback, and conditional macro-Hansei with its triggers listed inline. This makes the required structure visible at stub generation time without requiring the agent to re-read SKILL.md step 6.

### Run 58 — 2026-05-01 — echo-sweep-silence

- **decided:** Silence. All active instruction surfaces are aligned with v3.8.0. The v3.8.0 echo propagation chain is complete: SKILL.md core (run 54) → step 7 fallback (run 55) → README user docs (run 56) → record.py stub (run 57) → full sweep clear (run 58).

### Run 59 — 2026-05-01 — zenodo-description-update

- **decided:** Update `.zenodo.json` description to match the six canonical steps of the loop.

### Run 60 — 2026-05-01 — tagline-step-names

- **decided:** Replace both occurrences of "Examine. Decide. Change. Verify. Record." (and "examine, decide, change, verify, record") with the accurate 7-step sequence: "Understand. Examine. Challenge. Decide. Act. Reflect. Record." (and lowercase equivalent in README table).

### Run 61 — 2026-05-01 — frontmatter-description-fix

- **decided:** Rewrite the frontmatter `description` sentence to: "Understand the ask, examine the target, challenge the first read, decide on one change (or argue for redesign, or declare silence), act, reflect on the target, and record." The USE WHEN tags are unchanged. The "Combines incremental refinement…" sentence is accurate and unchanged.

### Run 62 — 2026-05-01 — v381-patch-release

- **decided:** Cut v3.8.1: add CHANGELOG entry covering all seven post-v3.8.0 commits, bump README version line and CITATION.cff from 3.8.0 → 3.8.1. No skill-level version bumps warranted (no behavioral changes to any individual skill; step 7 fallback fix is a doc-only correction).

### Run 63 — 2026-05-01 — silence-run-63

- **decided:** Silence. No actionable finding. This is Anthropic silence peg 2 for the post-v3.8.1 state (peg 1 was run 58, which was post-v3.8.0 pre-description fixes; run 63 is the first clean peg on the fully updated v3.8.1 state).

### Run 64 — 2026-05-01 — feat-retrospect-skill

- **decided:** Create `retrospect/SKILL.md` as a new standalone arc-reflection skill. Update improve/SKILL.md step 6 to reference it. Propagate to all metadata surfaces.

### Run 65 — 2026-05-01 — feat-working-model

- **decided:** Add `.trail/model.md` as the working model artifact. Retrospect writes it (new step 5); Improve reads it at step 1; Trail documents it in the directory structure. Bump retrospect to v1.1.0, suite to v3.9.1.

### Run 66 — 2026-05-01 — docs-readme-compass-orientation

- **decided:** Fix the README "How it works" opening sentence to correctly describe the reading order introduced in run 65.

### Run 67 — 2026-05-01 — compass-seed-evo-vision

- **decided:** Seed `.trail/compass.md` from operator conversation. This is a bootstrap exception — normally compass is generated by a Retrospect arc-read. Seeding from conversation captures strategic insight that a trail-read alone would not produce. Future Retrospect runs will replace and update it.

### Run 68 — 2026-05-01 — split-vision-from-compass

- **decided:** Split orientation into two artifacts: `.trail/vision.md` (operator-held, stable, never written by any skill) and `.trail/compass.md` (Retrospect-derived, rewritten each run). Improve reads vision first, then compass, then trail. Vision is the destination; compass is the current location; trail is the path.

### Run 69 — 2026-05-01 — hunch-skill-added

- **decided:** Add a new sixth skill, Hunch, with this contract:

### Run 70 — 2026-05-01 — hunch-on-operator-vision-intent

- **decided:** Apply Hunch as designed: form 2-5 specific sourced hunches stated as guesses, turn each into a falsifiable question, surface one prioritized question (not all at once), do not write to vision.md without explicit operator approval. Three hunches formed:

**70 runs total — 56 with changes, 14 silence**
