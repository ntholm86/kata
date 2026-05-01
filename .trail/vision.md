# Vision — autonomous-agent-skills

_Operator-held. Stable across runs. Read by Improve at step 1, before the trail and the compass. Not written by any skill — only by the operator/team that holds the destination._

---

## What this work is, beyond a skillset

This repo is **as much research as it is development**. The development output is a set of skills; the research question those skills serve is older and bigger than any of them:

> **What is the architecture of trustworthy delegation?** What does it actually take for a human to safely hand real work to an AI more capable than themselves — and remain the responsible party for what gets done?

The skills are one attempt at an answer. They may turn out to be the wrong attempt, the right attempt for a narrower class of work than hoped, or a step toward an architecture none of us has named yet. A negative result on the skills is still a result on the question.

A load-bearing piece of any answer to that question — and the piece this skillset is most directly aimed at — is this: **the AI's power has to be made transparent enough that the human keeps steering even when the AI exceeds their ability to verify in detail.** "Transparent" here does not mean regulator-grade auditability after the fact; it means evidence the operator can use *while driving*, in time to correct course. That is what the trail, the compass, and the read-order at step 1 of Improve are trying to be — instruments on a dashboard, not a black box and a logfile.

**Convergence on a particular skill is not convergence on the question.** The question is the longer arc the skills serve. Every claim this repo makes about being "done" must be read against that distinction.

## What this repo is for

This repo is **simultaneously the workshop and the proof**. The skills — intent, improve, probe, trail, retrospect — are generic tools meant to make any AI agent's improvement loop better. The honest test is whether they can improve themselves. If they can't, the claim is hollow.

The present focus has two parts:

1. **Get the reasoning layer to a reasonable state** — each run finds the highest-leverage thing left to change in the skills themselves and changes it, or declares convergence.
2. **Document the process well enough to be implementable** — by another agent framework, by a human team, by an execution harness. "Good enough" is bounded by Principles 1 and 2: the documentation must **define the destination, not prescribe the route** (no checklists, no thresholds smuggled in as defaults), and the process it describes must **produce a visible trail as a structural property**, not as an optional add-on. A spec that satisfies a harness by being mechanical violates Principle 1. A spec that hides what the agent did violates Principle 2.

These two goals constrain each other. A skill that works conversationally but can't be specified precisely enough for another system to invoke is not done. A specification precise enough for machine invocation but that turns the skill into a checklist — or strips out the trail — has broken what it was specifying.

## Architectural constraints (not guidelines)

1. **Generic first.** No infrastructure, tests, or docs that only make sense because the target is a skills repo.
2. **No test infrastructure.** The loop is the test. The trail is the evidence.
3. **Human-readable.** If a term requires prior knowledge to understand, it fails.
4. **One change per run, highest leverage, stated reason.** No batching.
5. **The three principles are constraints, not preferences.** Violating one means a skill is broken.

## Memory, learning, meta-cognition (the protocol must require all three)

A reasoning layer that can't carry anything across runs is not a reasoning layer. The protocol the skills define must require all three, while leaving the implementation open — different harnesses will satisfy them in different ways, and some of those ways will be faster or more structured than what this skillset uses.

**Memory** — *what happened.* The full record of decisions, actions, and reflections from prior runs, kept in a form that can be re-read. Without it, every run starts from zero and the agent cannot be held to anything it concluded yesterday.
- *How the skillset solves it:* `.trail/log.md` — append-only, human-readable, source of truth. `.trail/history.md` is an auto-generated digest. The Trail skill enforces the structure.

**Learning** — *what to do differently next time.* Some signal extracted from prior runs that changes future behavior. This is not the same as memory; memory is the substrate, learning is the update.
- *How the skillset solves it:* Indirectly and weakly. There is no stored strategy artifact. "Learning" here means a future agent re-reads the trail and reasons over it. This is honest but slow; it is also the most underdeveloped of the three and a likely place a future loop run will find leverage.

**Meta-cognition** — *what the target is becoming, and is the loop's attention in the right place.* Reasoning about the work itself: the arc, the recurring patterns, whether the questions being asked are the right questions. Without this, an agent will keep solving local problems while the structural problem drifts.
- *How the skillset solves it:* `.trail/compass.md` — the current synthesized orientation, written by Retrospect after reading the arc, read by Improve at step 1 before each run. The Retrospect skill is the mechanism that produces it. This `vision.md` sits alongside it: vision is what the operator/team holds and does not change without an explicit decision; compass is what the agent derives from the trail and is rewritten each Retrospect run.

## The hard problem this repo exists to chip away at

When this repo targets itself, the loop has to derive its compass from the trail. The agent cannot be told "this is what the target is becoming" — it has to read the trail, form arc-claims, and write that orientation itself. **That — autonomous compass derivation — is the hard problem.** Every other reasoning capability sits on top of it: an agent that cannot derive what the target is becoming will keep optimizing for whatever metric is in front of it.

Vision (this file) is what the operator gives the agent as input. Compass is what the agent must produce as output. The gap between them is what Retrospect is trying to close.

## Horizon (context, not current focus)

The longer arc is that the skills suite is intended to become the reasoning layer for an autonomous execution harness — evo (`c:\git\evo`) is the concrete instance, but the goal is broader: **the skills should be specifiable cleanly enough that any execution harness could invoke them**. Integration with any specific system is **deferred** — it does not begin until the reasoning layer has proven itself on real targets with Retrospect in play, and until the specification is precise enough that the integration is a matter of wiring, not interpretation.
