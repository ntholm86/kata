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
- What state is it in? Read its history if one exists (GENBA, changelogs, prior runs).
- What has been tried before? What worked? What did not?
- What is the triggering concern? (User request, periodic review, prior-run finding)

If this target has a GENBA.md, read the most recent entries. If a prior run exists, verify its claims: check that changes it reported are actually present. Do not anchor to a prior run's score.

### 2. Diagnose

Examine the target and determine what it needs. Three classical diagnostic lenses are available as vocabulary:

- **Unevenness** - inconsistency in style, patterns, quality distribution, naming, error handling, coverage. Unevenness is often a root cause: inconsistency breeds confusion, confusion breeds overburden, overburden breeds waste.
- **Overburden** - components asked to do too much. Excessive responsibilities, deep coupling, high complexity concentrated in one place.
- **Waste** - what does not earn its existence. Dead code, unused abstractions, redundant validation, documentation that duplicates rather than illuminates.

These are thinking tools, not a procedure. Use whichever reveals what matters. Use none if the situation calls for something else. The diagnosis must be grounded in what you find, not in which categories exist.

For each finding: identify the root cause, not just the symptom. "This function is too long" is a symptom. "This function handles three unrelated responsibilities because they were added incrementally without refactoring" is a root cause.

### 3. Decide

Based on the diagnosis, select the methodology:

- **Kaizen** - the target needs incremental improvement. The structure is sound; specific things need fixing. This is the most common case.
- **Kaikaku** - the target's structure cannot reach its goals through incremental changes. It needs redesign. This is rare and must be justified.
- **Hansei** - the improvement loop itself needs examination. Use after every ~10 runs on the same target, or when 3+ consecutive runs produce no changes, or when the same kinds of findings keep recurring.
- **Shiken** - the target needs to prove it supports genuine reasoning, not just compliance. Use when you suspect prescriptive drift or when the system needs ARF validation.

### 4. Execute

Invoke the selected skill. It does the work and produces its output.

### 5. Record

After execution, update the target's GENBA.md (create it if needed). Prepend the new entry (newest-first). Every entry includes:

- Run number, date, model identity
- What was found (findings with root causes)
- What was done (actions taken)
- What changed (concrete diffs, not vague descriptions)
- Assessment (current state, score if applicable)

If the target uses Kiroku trails, also update the session transcript and decision index.

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
