---
name: kata
version: 2.0.1
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

After execution, update the target's audit trail. All trail artifacts live in a single `TRAIL/` directory. Kiroku manages the core evidence layer (sessions, INDEX, SUMMARY). Kata owns the run ledger:

- **`TRAIL/GENBA.md`** — Kata's run ledger. Prepend the new entry (newest-first). Keep entries compact (~10 lines max). Every entry includes:
  - Run number, date, model identity
  - What was found (key findings only — root causes, not exhaustive lists)
  - What was done (actions taken — omit file manifests, `git log` has those)
  - Verification result (build/tests pass/fail)
  - Assessment (one sentence: current state, what remains)

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

1. Three or more consecutive evaluations by distinct evaluators produce the same assessment
2. Zero artifact changes in each of those evaluations
3. Each evaluator scored independently without consulting prior scores

When these conditions are met, record the convergence and stop. Do not manufacture findings to justify continued execution.

## Periodic Hansei

After every 10 runs on the same target, invoke Hansei regardless of findings. The loop must examine itself.
