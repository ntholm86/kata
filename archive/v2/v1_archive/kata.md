---
name: kata
version: 1.34.0
description: 'Kata (型) — Full TPS treatment orchestrator. Runs the complete Toyota Production System diagnostic and improvement cycle: diagnose with all 3M lenses (Mura → Muri → Muda in causal order), assess severity to select methodology (Kaizen for incremental, Kaikaku for radical), execute the selected methodology, chronicle results in GENBA.md, and persist to git. The meta-pattern — the routine of improvement itself. USE WHEN: full treatment, kata, TPS, give me everything, full diagnostic, complete analysis, run all lenses, comprehensive improvement, what does this project need.'
argument-hint: 'Optional: specify target project/module, skip diagnosis if already done ("just run kaizen"), or focus the diagnosis ("only check the API layer")'
---

# Kata (型) — Full TPS Treatment

The routine of improvement. Diagnose, decide, execute, chronicle, persist.

> **Governing principles:** [Commander's Intent](../PRINCIPLES.md) — Kata sequences the skills and provides the thinking structure; what you find at each phase and how you act on it is your reasoned judgment. [Observable Autonomy](../PRINCIPLES.md) — every phase produces visible output; the GENBA.md chronicle is the proof trail that makes the full cycle auditable.

Toyota Kata is the meta-pattern — the practice of practicing improvement. It encompasses: understanding the challenge, grasping the current condition, establishing a target condition, and experimenting toward it. This skill orchestrates the full Toyota Production System toolkit in the right order.

**Why Kata exists:** Each TPS skill (Muda, Mura, Muri, Kaizen, Kaikaku) is autonomous and works alone. But the 3M diagnostics have a CAUSAL ORDER — Mura causes Muri causes Muda. Running them in isolation can miss root causes. Kata ensures the diagnostic phase respects causality, and that the right methodology is selected based on evidence.

**Kata is thin.** It does not duplicate the skills — it sequences them. Each phase references the actual skill to run.

**Part of the TPS skill family:** This is the orchestrator. For individual skills: **Muda** (waste), **Mura** (unevenness), **Muri** (overburden), **Kaizen** (incremental improvement), **Kaikaku** (radical redesign), **Hansei** (reflection on the loop itself), **Shiken** (novelty probes for reasoning quality).

## When to Use

- "full treatment", "run everything", "what does this project need?"
- "kata", "TPS", "complete analysis", "comprehensive improvement"
- When you don't know WHICH skill to use — Kata figures it out
- When you want the disciplined diagnostic → methodology → execution → tracking cycle
- First encounter with a new project where you want a complete picture

## Core Principles

1. **Causal order matters.** Diagnose Mura (unevenness) before Muri (overburden) before Muda (waste). Symptoms are downstream; root causes are upstream.
2. **Methodology follows evidence.** Do not assume Kaizen or Kaikaku before running the 3M diagnostic. The severity and causality of findings dictate the treatment.
3. **The chronicle is the proof.** Kata requires documenting the loop. Without `GENBA.md`, it is just wandering.
4. **Mura-first resolution (when applying Kaizen).** When fixing issues, prioritize root causes (Mura) over downstream symptoms (Muda). Removing the cause of the waste is better than repeatedly cleaning up the waste.

## Procedure

### Phase 1: GRASP — Understand Current Condition

**Pre-run integrity check:** Before diagnosing, if `verify-suite.ps1` is available, run it to confirm the current state is known-good. If it reports failures, fix them first — diagnosing a corrupted or tampered state wastes the entire cycle. If the script is unavailable, proceed but note the limitation.

**Prior-run delta check (mandatory):** Before diagnosing, inspect what the most recent run already accomplished so you don't re-claim its work. Run `git log --oneline -5` from the suite root and read the latest released entry in `CHANGELOG.md`. If the immediately prior GENBA run number is already committed (tag matches), the suite is at a clean checkpoint. If the latest GENBA/SCORECARD entries are *ahead* of git, that uncommitted state is the prior run's incomplete CHRONICLE/PERSIST — it is *not* an invitation to redo that run's work. Findings already shipped in the latest CHANGELOG version must not be reported as new findings; doing so produces a hallucinated/duplicate run (see Run 11 and Run 39 in `GENBA.md` for precedent invalidations).

**Model self-identification (mandatory):** At the start of every run, explicitly state which model is executing the cycle and record the same string in both `GENBA.md` (`| Model | ... |`) and `SCORECARD.md` (Model column). Do not wait for the user to provide model identity.

Run the three diagnostic lenses in causal order. Each lens produces its own report per its skill definition.

**Narrate the transitions.** When moving from one lens to the next, state what the previous lens found and how it informs what you'll look for next. The causal chain (Mura → Muri → Muda) should be visible in your reasoning, not just in the final output.

**Step 1: Mura (unevenness)**
Run the Mura skill. Identify inconsistencies across the project. This comes first because unevenness is the root cause of the other two.

Output: Mura unevenness map + score.

**Step 2: Muri (overburden)**
Run the Muri skill. For each Mura finding, check: does this unevenness cause overburden somewhere? Also scan independently for overburden signals.

Output: Muri overburden assessment. Note which items trace upstream to Mura findings.

**Step 3: Muda (waste)**
Run the Muda skill. For each Muri finding, check: does this overburden produce waste? Also scan independently for waste.

Output: Muda waste inventory. Note which items trace upstream to Muri or Mura findings.

**Step 4: Synthesize the causal map.**

```
## 3M Diagnostic — [Project] — [Date]

### Causal Chains Found
| # | Mura (root cause) | → Muri (overburden) | → Muda (waste) |
|---|-------------------|---------------------|----------------|
| 1 | Mixed error handling (exceptions + result types) | Every handler must check both styles | Duplicate error translation layers |
| 2 | No standard for where config lives | utils.py became the config dumping ground (God module) | 3 abandoned refactoring attempts left as dead code |
| 3 | — | process_order() has 8 params (independently overburdened) | — |
| 4 | — | — | Unused dep: old-http-lib (independently wasteful) |

### Standalone Findings (no causal chain)
- [findings that don't connect to other 3M lenses]

### Severity Summary
| Lens | Critical | High | Medium | Low |
|------|:--------:|:----:|:------:|:---:|
| Mura | X | X | X | X |
| Muri | X | X | X | X |
| Muda | X | X | X | X |
```

### Phase 2: CHALLENGE — Select Methodology

Based on the diagnostic, decide: does this project need incremental improvement (Kaizen) or radical redesign (Kaikaku)?

This is a judgment call, not a formula. Consider:

- **Are most findings isolated or do they form causal chains?** Isolated findings suggest targeted fixes (Kaizen). Pervasive causal chains — where unevenness drives overburden drives waste — suggest structural problems.
- **What's the severity distribution?** Mostly medium/low findings are Kaizen territory. Multiple critical findings across all three lenses may indicate something deeper.
- **Can the existing architecture absorb the fixes?** If the fixes require changing fundamental patterns or paradigms, that's Kaikaku territory.
- **Is there convergence evidence?** If prior kaizen cycles show diminishing returns below target, the architecture may be the ceiling.

State your reasoning explicitly. The human needs to understand why you selected the methodology you did.

**If the 3M diagnostic surfaces zero findings:** This is a *candidate silence* signal, not convergence. Per **Principle 3 (Convergence Is Silence)**, true convergence requires 3 consecutive Kata runs by 3 distinct evaluators that produce the same score AND zero artifact changes. A single zero-findings run is one data point toward that condition. Distinguish:
- **Candidate silence (record and increment the silence counter):** Prior runs fixed everything detectable at the current depth. Record it as candidate silence in GENBA, note the current value of the Principle 3 silence counter, and consider running Hansei to check whether the diagnostic itself has blind spots.
- **Local plateau (silence counter resets to 0 if any artifact changes):** Score is steady but the loop keeps making small edits. This is a plateau, not convergence — the suite is moving, the score isn’t.
- **Shallow audit:** The diagnostic passed too quickly, skipped dimensions, or didn't read deeply enough. Re-run with explicit depth — read every file, check every cross-reference. If still zero, accept candidate silence.

Do not fabricate findings to justify continuing. Zero real findings is a valid and valuable result.

**Output:**

```
## Methodology Selection

**Selected: Kaizen / Kaikaku**

### Rationale
- [specific evidence from 3M diagnostic]
- [why the selected methodology fits]

### If Kaizen — Focus Areas
Top 3-5 findings to address, pulled from all three 3M reports, ranked by ROI.
Prefer fixing Mura root causes first (prevents downstream Muri and Muda).

### If Kaikaku — The Ceiling
[What structural limitation prevents incremental improvement]
```

**The Mura-first principle:** When Kaizen is selected, prioritize fixing Mura findings even if Muda findings have higher standalone ROI. Fixing the root cause (unevenness) often eliminates downstream overburden and waste for free. Check: would fixing this Mura finding also resolve any Muri or Muda findings in the causal chain? If yes, its effective ROI is the sum of the chain.

### Phase 3: EXECUTE — Run the Selected Methodology

**If Kaizen selected:**
Run the Kaizen skill with the focus areas identified in Phase 2. The kaizen cycle handles its own OBSERVE → RATE → CHALLENGE → ORIENT → DECIDE → ACT → CHECK flow.

**If Kaikaku selected:**
Run the Kaikaku skill. It handles its own DIAGNOSE → ENVISION → PLAN → VALIDATE → EXECUTE → REPORT flow. Present to user for approval before executing (Kaikaku requires explicit consent).

**If quick wins exist alongside the main methodology:**
Before running the selected methodology, handle any high-confidence, zero-risk Muda findings (Type II waste with verified 0 callers). Pruning dead weight before improving or redesigning is always correct — less to improve, less to redesign.

**Fix globally, not locally.** When a finding describes a pattern (e.g., "Skill X uses outdated phrasing Y"), search for every occurrence of pattern Y across the suite before declaring the fix complete. Repeated recurrences of the same finding across runs almost always mean the prior fix was applied to the one cited instance and not to its siblings. The verifier cannot catch this; the discipline is yours.

### Phase 4: CHRONICLE — Write to Ledgers

After execution, record the full run in the project ledgers. This is the experimental ledger — the proof trail of what was done, why, and what happened.

**Step 1: Update GENBA.md**
Location: **Trail follows the target.** If the target is the skill suite itself (path under `~/.copilot/skills/`), write to `~/.copilot/skills/GENBA.md`. If the target is an external project, write to `GENBA.md` in the target project's root — create it if it doesn't exist. External projects get their own improvement history; the skill suite's GENBA tracks only its own evolution.
Prepend the detailed entry for the run so the active ledger stays newest-first.

**Step 2: Update SCORECARD.md**
Location: Look for SCORECARD.md in the skills suite root (`~/.copilot/skills/SCORECARD.md`).
Append a one-line summary of the run, capturing the model, date, score delta, and a brief summary. This provides the high-level trajectory.

**Step 2b: Update CHANGELOG.md**
Location: `~/.copilot/skills/CHANGELOG.md`. If a version bump occurred, move items from `[Unreleased]` to the new version heading. Format: Keep a Changelog. Every added, changed, or fixed item gets a terse entry.

**Entry format (GENBA.md):**

```markdown
---
## Run [N] — [YYYY-MM-DD]

| Field | Value |
|-------|-------|
| Target | [project / artifact name] |
| Model | [LLM name + variant] |
| Trigger | "[the user's exact request]" |
| Methodology | Kata → [Kaizen / Kaikaku] |

### 3M Diagnosis Summary
| Lens | Findings | Critical/High |
|------|:--------:|:-------------:|
| Mura | N | N |
| Muri | N | N |
| Muda | N | N |
| Causal chains | N | — |

### Findings
| # | Finding | Lens | Severity | Fixed? | Recurred? |
|---|---------|------|:--------:|:------:|:---------:|
| 1 | [one-line description] | Mura/Muri/Muda | Critical/High/Med/Low | Yes/No | First / Run N |

**Recurrence detection:** Search prior GENBA entries for findings with the same lens AND the same component/dimension. Match on the *underlying issue*, not exact wording — models phrase differently. If a prior finding targeted the same structural concern, mark `Run N` (the earliest prior run). Track recurrence across rubric versions: a finding first seen under an implicit rubric and resurfacing under v1 still counts as recurrence. Note: GENBA entries before Run 17 use prose format rather than structured tables — search the prose for the same concern even though the format differs.

### Actions Taken
- [terse bullets — one line per action, name the file/skill touched]

### Outcome
- Score: [before] → [after] ([+/-]delta)
- [one-line interpretation of why the score moved (or didn't)]

### Regression Check
| Metric | Prev Run | This Run | Delta | Regressed? |
|--------|:--------:|:--------:|:-----:|:----------:|
| [metric] | X | Y | ±Z | Yes / No |

### Observations
- [pattern, blind spot, or methodology insight worth carrying forward]
```

**Step 3: Run verify-suite.ps1**
Run `verify-suite.ps1` from the skills suite root. This mechanical check validates encoding integrity, placeholder text, cross-references, version alignment, ledger consistency, and frontmatter. It also writes a file-hash snapshot to `INTEGRITY.json` for diff-based validation. If the script reports failures, fix them before recording the run as complete.

**Entry format (SCORECARD.md):** Append one row to the score table:

```
| [N] | [YYYY-MM-DD] | [Model] | [start] | [end] | [+/-delta] | [target] | [one-line result summary] |
```

### Phase 5: REFLECT — Statistical Pattern Recognition

After chronicling, step back and analyze the GENBA.md data across runs. This is where proof accumulates.

**Quantitative analysis (when ≥3 runs exist for this target):**

```
### Trend Analysis (Runs 1–N)

#### Score Trajectory
| Run | Kaizen Score | Delta | Model | Methodology |
|:---:|:------------:|:-----:|-------|:-----------:|
| 1   | 6.2          | —     | Opus  | Kaizen      |
| 2   | 7.1          | +0.9  | Sonnet| Kaizen      |
| 3   | 7.4          | +0.3  | Opus  | Kaizen      |
| 4   | 7.5          | +0.1  | GPT-4o| Kaizen      |

#### Velocity: [decelerating / steady / stalled]
#### Silence signal: [no candidate silence yet / candidate silence run X / N consecutive distinct-evaluator silences toward Principle 3]
#### Recommendation: [continue kaizen / evaluate kaikaku / schedule cross-model run for silence confirmation / target reached]
```

**Qualitative analysis (all runs):**

- **Recurring findings:** Does the same type of Mura/Muri/Muda keep appearing? Count recurrences. If the same waste type appears in ≥3 runs, it's systemic — the fix isn't sticking, or the root cause hasn't been addressed.
- **Methodology effectiveness:** Compute average delta per methodology. Is kaizen producing consistent improvement? Are later cycles showing diminishing returns?
- **Causal chain frequency:** What percentage of findings form causal chains (Mura → Muri → Muda) vs standalone? Track this ratio across runs.
- **Regression frequency:** How often do metrics regress between runs? Frequent regression = improvements aren't locked in.
- **Cross-skill referrals:** Note when one skill's findings suggest another skill should run.

**When to invoke Hansei:** If recurring findings span ≥3 runs, or if the REFLECT phase keeps finding the same patterns, invoke the **Hansei** skill for structured meta-reflection rather than duplicating that analysis here. Kata REFLECT handles in-cycle observation; Hansei handles across-cycle pattern interrogation.

**Periodic Hansei (mandatory cadence):** If 5 or more Kata runs have occurred since the last Hansei invocation in `GENBA.md`, invoke Hansei in this cycle even if no recurring patterns are visible. The blind spots are exactly when nothing feels wrong — Hansei's own rule. `verify-suite.ps1` warns when this cadence is overdue. Do not skip; the discipline is load-bearing only when enforced. When Hansei is invoked, record it in the same run entry with an explicit heading (`### Hansei` or `### Hansei Pass`) so cadence checking remains machine-verifiable.

```
### Patterns (Run [N])
- [pattern observed across this and prior runs]
- [referral: suggest [skill] for [finding] in next run]
- [trend: score velocity is decelerating/steady/stalled]
- [regression: X metrics regressed — cause: Y]
```

### Phase 6: PERSIST — Commit to Git

After a successful run (verify-suite.ps1 reports 0 failures), commit the current state to git so the disaster floor is never more than one run deep. This phase exists because Run 29 proved that uncommitted work is one `git checkout .` away from total loss.

**Gate:** Only execute this phase if verify-suite.ps1 passed with 0 failures in the CHRONICLE phase. Never commit a broken state.

**Procedure:**
1. Stage all changed files in the suite root: `git add -A` from the skills directory.
2. Commit with the message format: `TPS Skill Suite vX.Y.Z — Run N: <one-line summary>` where the summary matches the SCORECARD row's Result column.
3. Create an annotated tag: `git tag -a vX.Y.Z -m "vX.Y.Z"`
4. **Do not push.** Pushing is a shared-system action and requires explicit user consent. Report that the commit and tag are local and offer to push if the user wants.

For version format conventions and verification of version-string completeness, reference the **project-increment** skill.

**If the suite is not in a git repository**, skip this phase and note the limitation. Do not initialize a repository without user consent.

**If staging reveals unrelated changes** (files outside the skills suite), warn the user and stage only the suite files rather than using a blanket `git add -A`.

## Rules

- **Kata is an orchestrator, not a replacement.** It calls the individual skills — it doesn't duplicate their logic. If you need just Muda, use Muda directly. Kata is for when you want the full picture.
- **Causal order matters.** Always diagnose Mura → Muri → Muda. Fixing downstream (waste) without addressing upstream (unevenness) means the waste will return.
- **Chronicle every run.** The `GENBA.md` and `SCORECARD.md` ledgers are not optional. The value of Kata is the ACCUMULATION of evidence across runs.
- **Run verify-suite.ps1 after every run.** The mechanical verification script (`verify-suite.ps1` in the suite root) is the final integrity gate. It checks encoding, placeholders, cross-references, version alignment, ledger consistency, frontmatter, and writes a file-hash snapshot to `INTEGRITY.json`. Pass it before recording the run as complete. If the script is unavailable, fall back to a manual text scan for `existing code`, `â€`, `â†`, `Ã` — but the script is always preferred.
- **Archive GENBA when it grows large.** If GENBA.md exceeds ~200 entries or becomes too large to fit in context during REFLECT, archive older entries to `GENBA-archive-YYYY.md` and keep the most recent 20-30 entries in the active file. The archive is still accessible — it's just not loaded by default. Note the archive event in the active file.
- **Mura-first when possible.** Fix root causes before symptoms. A Mura fix that eliminates a Muri and a Muda finding has 3x the ROI of its standalone assessment.
- **Quick Muda wins before methodology.** Obvious waste (dead code, unused deps) should be pruned before running kaizen or kaikaku. Less to analyze, less to improve, less to redesign.
- **Partial runs are fine.** User can request "just the diagnosis" (Phases 1-2), "diagnose and plan but don't execute" (Phases 1-2 + methodology planning), or the full cycle.
- **Self-targeting is expected.** Running Kata on the TPS skills themselves is how the skill suite improves. GENBA.md entries for self-targeting runs are the experiment's data.
- **Persist every run.** After REFLECT, commit to git (Phase 6). The disaster floor must never be more than one run deep. Do not push without explicit user consent.
- **Self-identify every run.** The executing model identity must be stated at run start and must match between `GENBA.md` and `SCORECARD.md` for the same run number.
- **Preserve UTF-8 on bulk edits.** When shell commands rewrite skill markdown or ledgers, use explicit UTF-8 encoding. PowerShell default encoding can corrupt arrows, em dashes, and non-ASCII glyphs into mojibake.
- **Context awareness.** A full Kata run can be large. If the target project is too big for a single run, scope the diagnosis to a specific module or layer. If context fills during execution, summarize intermediate findings and continue — don't silently drop phases. Tell the user when you're summarizing rather than reporting in full.

