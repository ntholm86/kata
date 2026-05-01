---
name: improve
version: 3.3.0
description: 'The improvement skill. Understand the ask, examine the target, challenge the first read, decide on one change (or argue for redesign, or declare silence), act, reflect on the target, and record. Combines incremental refinement, structural rethinking, and reflection on the target itself. USE WHEN: improve, audit, review, fix, refactor, redesign, evaluate, what would make this better, am I missing something.'
argument-hint: 'The target to improve, and optionally the concern (correctness, simplicity, performance, etc.)'
---

# Improve

*Understand. Examine. Challenge. Decide. Act. Reflect. Record. Or argue convincingly that nothing should change.*

This is the only skill you need for most autonomous work. It combines what v2 split into Kaizen (incremental), Kaikaku (radical), and Hansei (reflection) — because in practice the agent should pick which mode the situation calls for, not be told.

## Governing principles

This skill exists to enact three principles:

1. **Commander's Intent** — *what + why, not how.* You are given a destination, not a route. The lenses below are vocabulary for thinking, not a checklist to execute.
2. **Observable Autonomy** — *every reasoning step is recorded as it happens.* If an observer can't reconstruct what you did and why from the trail alone, the work is invisible regardless of how good it was.
3. **Convergence Is Silence** — *finding nothing actionable is a valid outcome and advances the system toward done.* Do not manufacture findings to justify the run.

Full statement of the principles: [PRINCIPLES.md](../PRINCIPLES.md) — read it if available, but this skill operates fully without it.

## The work

### 1. Understand the target and the ask

*If [Intent](../intent/SKILL.md) is installed, apply it now — it handles this step in full. Continue to step 2 when done.*

If Intent is not installed: before examining anything, narrate your interpretation of what you've been asked to do, in your own words. State what you believe the destination is and what would count as success. If your interpretation diverges from a literal reading of the request, say so explicitly so the operator can correct course before you act.

If the ask is about convergence or publication readiness, read the repo's convergence-scope protocol before proceeding if it has one, then declare which layer (problem, principles, skills, cross-layer coherence) this run is evaluating.

Before examining the target, check whether `.trail/model.md` exists. If it does, read it first — it is the current working model of the target, written by [Retrospect](../retrospect/SKILL.md) and updated each time a retrospect run completes. It distills what is currently believed about the target so you do not have to re-derive it from the full trail. Read `log.md` for the full history; read `model.md` for the current synthesis.

This is not ceremony. The most common failure mode in autonomous improvement is solving a precisely-executed wrong problem.

### 2. Examine

Look at the target. Read what is there. Run what can be run. Form a mental model of how it works and what it is for.

Three lenses are available as thinking tools — not a procedure, not a checklist. Apply the ones the target invites:

- **Inconsistency.** Where does the target contradict itself? Mixed conventions, asymmetric handling of similar cases, naming patterns that diverge for no reason. Inconsistency is often a root cause whose symptoms surface elsewhere.
- **Overburden.** Where is some component asked to do too much? Functions, modules, files, or processes that concentrate too many responsibilities. Overburden concentrates risk: the overburdened component is the one most likely to break and hardest to change.
- **Waste.** Where does the target carry things that don't earn their existence? Dead code, abstractions with one consumer, validation that can never fire, documentation that restates the obvious. Waste creates cognitive load without contributing value.

If the target's problems don't fit these lenses, describe what you actually see. Add lenses as the target warrants (security posture, performance, type safety, accessibility, whatever applies). Name every lens you apply and what it revealed — including "nothing actionable."

### 3. Challenge the first read

Ask explicitly:
- What am I not seeing?
- Am I anchored to the most obvious finding and missing a subtler, more important one?
- Is the target's structure itself wrong, such that no incremental fix will help?

The third question is the Kaikaku question. If the answer is yes, do not produce a list of incremental fixes. Argue for redesign. Sketch what a v2 of the target would look like. Estimate the cost of the redesign against the cost of continuing to patch. The decision is the operator's; your job is to make it visible.

If you find nothing the first read missed, say so. Do not manufacture blind spots to appear thorough.

### 4. Decide

Pick one of:

- **One incremental change.** The single highest-leverage finding. State why it ranks above the alternatives in one sentence each.
- **Argument for redesign.** A statement of why incremental work won't pay off here, and a sketch of what redesign would look like. Stop and surface the argument; do not redesign without confirmation.
- **Silence.** Nothing actionable was found. State what was examined and why nothing warranted change. This advances the convergence chain (Principle 3) and is a legitimate outcome.

### 5. Act (if a change was decided)

Make the change. For each non-trivial step, state what you are about to do and why before doing it. Show the reasoning, not just the diff. After the change, verify it: run tests, check types, re-read the surrounding code to confirm no regression.

If the change introduces a problem, surface it immediately. Half-done work that pretends to be done is worse than no work at all.

### 6. Reflect

Two operations live in this step. The first runs every iteration. The second runs only when the first surfaces a reason for it. Reflection in this skill is always *about the target* — the codebase, the system, the artefact you are working on — not about the loop that examines it. The loop is only interesting insofar as it reveals or obscures something about the target. For arc-level questions about whether the loop is examining the right parts of the target — questions this step does not answer — use [Retrospect](../retrospect/SKILL.md) as a standalone skill.

#### 6a. Per-iteration reflection

After the change is made (or silence is declared), but before recording, sit with three things. They are prompts for honest reflection inside the trail entry, not slots to fill.

- **State your current model of the target as a claim a future run could disagree with.** Not a summary of what you did this run — a falsifiable assertion about *what the target is, what it is becoming, or where its real weight sits.* Examples of the right shape: "This codebase is converging on X." "The hardest part of this target is Y, and prior runs have consistently misread it as Z." "The real risk in this system lives in W, even though most attention has gone to V." A future iteration examining the same target should be able to read the sentence and say either "still true" or "no, here is what changed my mind."
- **Name a blind spot in this run.** Something specific you suspect this iteration did not see clearly — an area you did not examine, a kind of evidence you did not gather, an assumption you took on faith. Generic hedging ("I might have missed something") is not a blind spot. If you genuinely cannot name one, say so, and say why ("this run touched only documentation; runtime behaviour was not exercised").
- **Imagine a reader who knows this target better than you do.** What would they push back on in this run's findings or model? If nothing comes to mind, the run probably did not engage the target deeply enough.

When something material surfaces — an updated model, a contradiction with a prior run, a blind spot worth carrying forward — write it as `[!REALIZATION]` in the entry. That is the storage mechanism. No new markers are introduced for reflection.

#### 6b. Across-trail reflection

Most iterations do not need this. Run it only when one of the following is true:

- The last few iterations found the same *class* of finding (not the same text — the same kind of thing). A recurring shape of inconsistency, a repeating fix pattern, the same lens triggering each time.
- You are about to declare silence. Read the arc of the trail before counting the peg — silence read against a mistaken arc is not convergence.
- A prior `[!REALIZATION]` is contradicted by what this run found.
- The operator explicitly asked.

When triggered, read `.trail/log.md` as a *single document about the target*, not as a list of past runs. Then sit with this:

- Which prior realisations aged well, and which were wrong in retrospect? If the trail is long enough, name at least one of each.
- Where has attention been spent, and is that where the target's real weight lies? A long tail of small fixes in one corner can mean either "that corner is the bottleneck" or "this is the corner the loop has grown comfortable looking at." The trail itself is the evidence — re-read it.
- What does the target need next that *no individual iteration would have surfaced* — only the arc reveals?

Write the result as `[!REALIZATION]` in this entry, framed as a claim about the target. If it changes the priority for the next iteration, say so plainly.

For an arc-read that runs outside an improve iteration, use [Retrospect](../retrospect/SKILL.md).

### 7. Record

*If [Trail](../trail/SKILL.md) is installed, apply it now — it handles this step in full.*

**In multi-iteration runs, this step executes after every iteration — not once at the end of all iterations.** The trail entry is the commit point for that iteration. Append it, regenerate `history.md`, and commit before starting the next iteration. A user who stops a 10-iteration run after iteration 4 must have 4 committed trail entries, not 0.

If Trail is not installed: append a single entry to `.trail/log.md`. The entry must include:

- Date, target, operator (if known), model identity (provider + tool-call ID prefix if observable).
- Your interpretation of the ask.
- Lenses applied and what each revealed.
- The decision (incremental, redesign argument, or silence).
- The change made and verification evidence — or, if silence, a statement of what was examined.
- Reflection about the target (per step 6): a falsifiable model-claim, a named blind spot, and an imagined-reader pushback. Across-trail reflection if its triggers fired.
- Marked moments: `[!DECISION]`, `[!REVERSAL]`, `[!REALIZATION]`.

The format spec is in [trail/SKILL.md](../trail/SKILL.md). The script `<skills>/tools/record.py` can stub a new entry for you.

## Self-targeting

This skill must be runnable on itself. If running Improve on `improve/SKILL.md` and `probe/SKILL.md` produces nothing actionable, that is evidence the skills are simple enough. If it produces a list of fixes, do them. If it produces an argument for redesign, surface it.

## What this skill does not do

- It does not score the target on a numerical rubric. v2 did this and the question "who made up these metrics?" never went away. Convergence — diverse independent evaluators finding nothing to change — is the only honest measure of done.
- It does not orchestrate other skills. The other skills (Intent, Trail, Probe) run independently. Improve delegates to Intent (step 1) and Trail (step 7) when they are installed, but does not require them.
- It does not tell you when to stop. The convergence protocol in PRINCIPLES.md does.
