---
name: kata
version: 2.3.0
description: 'Orchestrate an improvement cycle: diagnose, select methodology, execute, record, persist. The meta-pattern that connects all skills into a coherent workflow. USE WHEN: improve, audit, review, full treatment, kata, run the loop, comprehensive improvement, what does this project need.'
argument-hint: 'Specify the target (project, file, system) and optionally a focus area or concern'
---

# Kata

*The routine of improvement itself.*

Kata is the orchestrator. It takes a target, determines what that target needs, selects and executes the right methodology, records everything, and persists the results.

## The Cycle

### 1. Grasp the Situation

Understand the target before acting on it.

- What is this target? What does it do? Who uses it?
- What state is it in? Read its history if one exists (TRAIL/, changelogs, prior runs).
- What has been tried before? What worked? What did not?
- What is the triggering concern? (User request, periodic review, prior-run finding)
- Does a **Target Condition** exist in `TRAIL/SUMMARY.md`? If yes, it guides all decisions this run. If no, ask the human: *"Where do you want this project to end up?"* Record their answer in `SUMMARY.md` under `## Target Condition`.

If this target has a `TRAIL/` directory, read `TRAIL/GENBA.md` for the most recent run entries. If a prior run exists, verify its claims: check that changes it reported are actually present. Do not anchor to a prior run's score.

**Derive measurements.** After understanding the target, determine what to measure — based on what this target is, what the Target Condition is, and what would make improvement (or its absence) visible. The measurements must make sense for *this* target:

- A skill suite that claims to produce autonomous reasoning should be measured on whether it actually does (ARF, principle compliance, convergence integrity).
- A web application should be measured on what makes it good at being a web application (security posture, accessibility, test coverage, API consistency — whatever the agent determines matters after reading the code).
- A library should be measured on what makes it good at being a library (API surface clarity, documentation coverage, backward compatibility).

Do not prescribe the measurements in advance. Derive them from what you find. State each measurement and why it matters for this target. If a prior run on this target established a measurement scheme (recorded in GENBA), inherit it unless you have reason to revise — and if you revise, record the revision as a `[!DECISION]` with rationale.

If a formal scoring rubric exists for this target (e.g., Rubric v3 in SCORECARD.md for the skill suite), use it. Rubrics are one form of measurement scheme — pre-agreed, externally anchored. They don't replace context-derived measurements; they complement them.

### 2. Diagnose

Examine the target and determine what it needs. Three classical diagnostic lenses are available as vocabulary:

- **Unevenness** - inconsistency in style, patterns, quality distribution, naming, error handling, coverage. Unevenness is often a root cause: inconsistency breeds confusion, confusion breeds overburden, overburden breeds waste.
- **Overburden** - components asked to do too much. Excessive responsibilities, deep coupling, high complexity concentrated in one place.
- **Waste** - what does not earn its existence. Dead code, unused abstractions, redundant validation, documentation that duplicates rather than illuminates.

These are thinking tools, not a procedure. Use whichever reveals what matters. Use none if the situation calls for something else. The diagnosis must be grounded in what you find, not in which categories exist.

For each finding: identify the root cause, not just the symptom. "This function is too long" is a symptom. "This function handles three unrelated responsibilities because they were added incrementally without refactoring" is a root cause.

### 3. Decide

Based on the diagnosis, select the methodology. If a Target Condition exists, evaluate each option against it — does this move the target closer?

- **Kaizen** - the target needs incremental improvement. The structure is sound; specific things need fixing. This is the most common case.
- **Kaikaku** - the target's structure cannot reach its goals through incremental changes. It needs redesign. This is rare and must be justified.
- **Hansei** - the improvement loop itself needs examination. Use after every ~10 runs on the same target, or when 3+ consecutive runs produce no changes, or when the same kinds of findings keep recurring.
- **Shiken** - the target needs to prove it supports genuine reasoning, not just compliance. Use when you suspect prescriptive drift or when the system needs ARF validation.

### 4. Execute

Before executing, start a kiroku session for the target:

```powershell
& "<skills-dir>/kiroku/kiroku-start.ps1" -Slug "<methodology>-<target>" -Project "<target-path>"
```

First determine `<target-path>` correctly. It is the repository being improved, not the repository that happens to contain the skill scripts.

The `-Project` parameter determines where `TRAIL/` lives — always in the target being worked on. When Kata targets an external repo, the trail goes in that repo. When Kata targets the skills suite itself, the trail goes in the skills directory.

If direct VS Code chat work and Kata both act on the same repository, they append to the same `TARGET_REPO/TRAIL/`. The trigger differs; the trail does not.

Invoke the selected skill. It does the work. During execution, mark decisions, realizations, and reversals in the session transcript.

After execution, close the session:

```powershell
& "<skills-dir>/kiroku/kiroku-close.ps1" -Project "<target-path>"
```

### 5. Record

After execution, update the target's audit trail. All trail artifacts live in a single `TRAIL/` directory. Kiroku manages the core evidence layer (sessions, INDEX, SUMMARY). When Kata evaluates a target as a whole (scored, cross-model), it also maintains a run ledger:

- **`TRAIL/GENBA.md`** — Kata's evaluation run ledger. Used when the entire target is evaluated (e.g., suite-level scoring runs recorded in SCORECARD.md). Not used for development work on individual components — that's tracked by kiroku sessions alone. Prepend the new entry (newest-first). Keep entries compact. Every entry includes:
  - Run number, date, model identity
  - What was found (key findings only — root causes, not exhaustive lists)
  - What was done (actions taken — omit file manifests, `git log` has those)
  - Verification result (build/tests pass/fail)
  - Measurements (what was measured, the scores, and the delta from prior run — this is what makes the gap visible and drives the next run)
  - Assessment (one sentence: current state, what remains)

- **SCORECARD Dimension Trajectory** — if the target has a SCORECARD with a Dimension Trajectory table, append a row with the end-of-run per-dimension scores. The run table shows only the mean; the Dimension Trajectory shows which dimensions moved. This is the indexed-resolution view for P2: a human scanning the scorecard can see what changed without reading GENBA.

- **`TRAIL/sessions/`** — the session transcript. Mark decisions with `[!DECISION]` (include rationale and alternatives considered), realizations with `[!REALIZATION]`, reversals with `[!REVERSAL]`.

- **`TRAIL/INDEX.md`** — auto-generated decision index. Run `kiroku-index.ps1` after closing the session.

- **`TRAIL/SUMMARY.md`** — executive digest. Updated after each run. Must not duplicate GENBA or INDEX content. Contains:
  - One-line status
  - Target Condition (human-stated desired end-state, if provided)
  - Direction (current methodology and why)
  - Key decisions (max 3 strategic ones — link to INDEX for full list)
  - Open concerns
  - Integrity warning

The observer looks at one directory. CHANGELOG.md stays outside TRAIL/ — it serves project users, not process observers.

### 6. Persist

Commit the changes to version control. The disaster recovery floor is one run deep.

## Convergence

Kata honors Principle 3. Convergence requires three simultaneous conditions:

1. Three or more consecutive evaluations by distinct evaluators produce the same score (within a defined tolerance)
2. Zero artifact changes in each of those evaluations
3. Each evaluator scored independently without consulting prior scores

When these conditions are met, record the convergence and stop. Do not manufacture findings to justify continued execution. The P3 silence counter is computed by `metrics.ps1` from SCORECARD data — it is not asserted by the agent. If the asserted counter drifts from the computed value, the metrics output flags it.

## Periodic Hansei

After every 10 runs on the same target, invoke Hansei regardless of findings. The loop must examine itself.
