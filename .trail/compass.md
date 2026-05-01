# Compass — autonomous-agent-skills

_Last updated: 2026-05-01 (seeded from operator conversation + convergence-loop-prompt; not a formal Retrospect run)_

---

## What this repo is for, right now

This repo is **simultaneously the workshop and the proof**. The skills — intent, improve, probe, trail, retrospect — are generic tools meant to make any AI agent's improvement loop better. The honest test is whether they can improve themselves. If they can't, the claim is hollow.

The present focus has two parts:

1. **Get the reasoning layer to a reasonable state** — each run finds the highest-leverage thing left to change in the skills themselves and changes it, or declares convergence.
2. **Document the process well enough to be implementable** — by something like evo, by another agent framework, by a human team. "Reasonable" means: clear enough that someone who didn't write it can pick it up and run it.

These two goals constrain each other. A skill that works conversationally but can't be specified precisely enough for another system to invoke is not done. A specification precise enough for machine invocation but unreadable by a human violates the human-readable principle.

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

## Horizon (context, not current focus)

The longer arc is that the skills suite is intended to become the reasoning layer for an autonomous execution harness — evo (`c:\git\evo`) is the concrete instance, but the goal is broader: **the skills should be specifiable cleanly enough that any execution harness could invoke them**. Integration with any specific system is **deferred** — it does not begin until the reasoning layer has proven itself on real targets with Retrospect in play, and until the specification is precise enough that the integration is a matter of wiring, not interpretation.

## What this compass is not

This file was seeded from operator conversation, not from a Retrospect arc-read. It captures intent and orientation, not evidence. A future Retrospect run on the actual trail will produce a more grounded compass and should replace this. Treat the present file as a working hypothesis about what matters, to be falsified by the next real arc-read.
