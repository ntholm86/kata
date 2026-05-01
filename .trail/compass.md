# Compass — autonomous-agent-skills

_Last updated: 2026-05-01 (seeded from operator conversation + convergence-loop-prompt; not a formal Retrospect run)_

---

## What this repo is for, right now

This repo is **simultaneously the workshop and the proof**. The skills — intent, improve, probe, trail, retrospect — are generic tools meant to make any AI agent's improvement loop better. The honest test is whether they can improve themselves. If they can't, the claim is hollow.

The present focus has two parts:

1. **Get the reasoning layer to a reasonable state** — each run finds the highest-leverage thing left to change in the skills themselves and changes it, or declares convergence.
2. **Document the process well enough to be implementable** — by something like evo, by another agent framework, by a human team. "Good enough" is bounded by Principles 1 and 2: the documentation must **define the destination, not prescribe the route** (no checklists, no thresholds smuggled in as defaults), and the process it describes must **produce a visible trail as a structural property**, not as an optional add-on. A spec that satisfies a harness by being mechanical violates Principle 1. A spec that hides what the agent did violates Principle 2.

These two goals constrain each other. A skill that works conversationally but can't be specified precisely enough for another system to invoke is not done. A specification precise enough for machine invocation but that turns the skill into a checklist — or strips out the trail — has broken what it was specifying.

## Architectural constraints (not guidelines)

1. **Generic first.** No infrastructure, tests, or docs that only make sense because the target is a skills repo.
2. **No test infrastructure.** The loop is the test. The trail is the evidence.
3. **Human-readable.** If a term requires prior knowledge to understand, it fails.
4. **One change per run, highest leverage, stated reason.** No batching.
5. **The three principles are constraints, not preferences.** Violating one means a skill is broken.

## Current claims about the reasoning layer

1. **The skills are a prototype of the right protocol, not the finished protocol.** Concepts (intent, improve, probe, trail, retrospect, compass) appear correct. The format is optimized for a conversational agent operating on a single repo. Whether that format is the right one for general use is still an open question.

2. **The loop is closer to a text-consistency engine than a behavioral improvement engine.** Recent runs (55–66) were predominantly documentation propagation following structural changes. The two genuinely behavioral additions (Retrospect, compass) both originated from operator observation, not the loop finding them autonomously. This is the most important current limitation to address.

3. **Retrospect and compass are unproven.** Retrospect has never been run end-to-end. This compass file was seeded from conversation, not derived from a trail-read. Their value is an open empirical question, not a settled fact.

4. **Convergence is real but local.** Each silence ("nothing actionable found") is honest for that run, that reader, that day. It is not a global claim. The next operator with fresh eyes has repeatedly found something the loop missed.

## What the next runs should test

- **Run Retrospect for real** — produce a falsifiable arc-claim that an Improve run would not have surfaced, and check whether it holds up.
- **Probe Intent's core claim** — that the agent is acting on what the operator means, not what they typed.
- **Honest behavioral changes** — not docs catching up to a prior structural change. If the next high-leverage move is documentation, name it as such and ask whether the structural change before it was actually right.

## Memory, learning, meta-cognition (the protocol must require all three)

A reasoning layer that can't carry anything across runs is not a reasoning layer. The protocol the skills define must require all three, while leaving the implementation open — different harnesses will satisfy them in different ways, and some of those ways will be faster or more structured than what this skillset uses.

**Memory** — *what happened.* The full record of decisions, actions, and reflections from prior runs, kept in a form that can be re-read. Without it, every run starts from zero and the agent cannot be held to anything it concluded yesterday.
- *How the skillset solves it:* `.trail/log.md` — append-only, human-readable, source of truth. `.trail/history.md` is an auto-generated digest. The Trail skill enforces the structure.

**Learning** — *what to do differently next time.* Some signal extracted from prior runs that changes future behavior. This is not the same as memory; memory is the substrate, learning is the update.
- *How the skillset solves it:* Indirectly and weakly. There is no stored strategy artifact. "Learning" here means a future agent re-reads the trail and reasons over it. This is honest but slow; it is also the most underdeveloped of the three and a likely place a future loop run will find leverage.

**Meta-cognition** — *what the target is becoming, and is the loop's attention in the right place.* Reasoning about the work itself: the arc, the recurring patterns, whether the questions being asked are the right questions. Without this, an agent will keep solving local problems while the structural problem drifts.
- *How the skillset solves it:* `.trail/compass.md` (this file) — the current synthesized orientation, written by Retrospect after reading the arc, read by Improve at step 1 before each run. The Retrospect skill is the mechanism that produces it.

## The hard problem this repo exists to chip away at

When this repo targets itself, the loop has to derive the compass it would otherwise be handed. The agent cannot be told "this is what the target is for" — it has to read the trail, form arc-claims, and write that orientation itself. **That — autonomous compass derivation — is the hard problem.** Every other reasoning capability sits on top of it: an agent that cannot derive what the target is becoming will keep optimizing for whatever metric is in front of it.

The current state of this file is the honest baseline: the compass was seeded by the operator. The next milestone is a Retrospect run that produces a compass an Improve run would not have produced — and that holds up to scrutiny. Until that happens, the protocol's meta-cognition layer is unproven.

## Horizon (context, not current focus)

The longer arc is that the skills suite is intended to become the reasoning layer for an autonomous execution harness — evo (`c:\git\evo`) is the concrete instance, but the goal is broader: **the skills should be specifiable cleanly enough that any execution harness could invoke them**. Integration with any specific system is **deferred** — it does not begin until the reasoning layer has proven itself on real targets with Retrospect in play, and until the specification is precise enough that the integration is a matter of wiring, not interpretation.

## What this compass is not

This file was seeded from operator conversation, not from a Retrospect arc-read. It captures intent and orientation, not evidence. A future Retrospect run on the actual trail will produce a more grounded compass and should replace this. Treat the present file as a working hypothesis about what matters, to be falsified by the next real arc-read.
