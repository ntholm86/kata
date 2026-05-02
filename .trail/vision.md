# Vision — autonomous-agent-skills

_Operator-held. Stable within runs — no skill changes this file; only the operator revises it. Read by Improve at step 1, before the trail and the compass. Revisit with Hunch whenever the operator's understanding has evolved or after a major arc milestone._

---

## What this work is, beyond a skillset

This repo is **as much research as it is development**. The development output is a set of skills; the research question those skills serve is older and bigger than any of them:

> **What is the architecture of trustworthy delegation?** What does it actually take for a human to safely hand real work to an AI more capable than themselves — and remain the responsible party for what gets done?

The skills are one attempt at an answer. They may turn out to be the wrong attempt, the right attempt for a narrower class of work than hoped, or a step toward an architecture none of us has named yet. A negative result on the skills is still a result on the question.

**This is an entry in an emerging space.** Reasoning frameworks for AI agents are being developed from multiple directions simultaneously. The differentiator this one is aiming for is **recognition, not comprehension**. If the psychological primitives are correct, practitioners who have experienced the friction — unclear AI intent, invisible reasoning, improvement loops that stall without explanation — will recognise the problem being named the moment they encounter this framework. That instant recognition is the test of whether the model found the right primitives. If the framework requires extensive explanation before someone sees the point, the model is probably wrong, not just badly communicated. Effectiveness without recognition produces a tool no one reaches for. Recognition without effectiveness produces a concept no one deploys.

**The mechanism is psychological, not procedural.** Most reasoning frameworks improve the quality of a single run — better decomposition, better tool use, better output validation. This approach is different: the skills are designed to give the AI a progressively richer *interior model of the situation*, so that its autonomous decisions are more enlightened rather than just more structured. Commander's Intent gives the AI the *why*, not just the *what*. The trail gives the AI memory of its own reasoning across sessions. Hunch closes the gap between what the operator holds in their head and what the AI is actually working from. Retrospect gives the AI a sense of what the target is *becoming* — not just what it is. The compass gives the AI its current orientation before it acts. None of these are output-quality levers. They are all about building situational understanding over time. An AI running these skills is not following a better procedure — it is developing a richer model of the work, the operator's intent, and its own prior reasoning. That is the bet.

**Two success conditions run in parallel:**
1. **Research success** — the experiment produces evidence about what trustworthy delegation actually requires, including negative results.
2. **Adoption success** — developers read the skills and start using them in their own projects without help from the author. Not integration into a pipeline — just: someone encounters these skills, recognises the problem, and finds them worth running.

**The architecture has two phases, and only one is fully automatable.**

Phase 1 is **vision convergence**: the human and the AI converge on a shared, precise model of what is to be built and why. This is done through dialogue — Hunch, Intent, and revision cycles on this file. It cannot be automated; the AI cannot derive the full vision from the work alone, because the human's understanding of the goal is always ahead of what has been written down. Vision will expand and change as the operator has realisations — that is expected and healthy. Hunch is the mechanism for revisiting it.

Phase 2 is **the iterative loop**: once vision is precise enough, the loop runs against it. The autonomy level is configurable — from full autonomy to human-gated at key decision points. What is safe to automate fully: testing, robustness improvements, internal consistency fixes, trail maintenance. What requires a human gate: direction changes, and most importantly — **what to implement next**.

**The irreducible human gate is: what to implement.** The AI can reason toward the vision, identify the highest-leverage gap, and propose the next change. But there will always be constraints and context the human holds that haven't made it into vision.md — cost, stakeholders, downstream implications, things not yet realised. The AI proposes; the human decides — or explicitly delegates that decision back to the AI. The goal is to make this gate as lightweight as possible while keeping the human genuinely in the loop, not just formally in the loop.

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
- *How the skillset solves it:* Indirectly and weakly. There is no stored strategy artifact. "Learning" here means a future agent re-reads the trail and reasons over it. This is honest but slow.
- *What done looks like:* The agent begins a run with a different approach than it would have used on run 1 — not because the operator told it to, but because it read what didn't work and adjusted. Concretely: a run produces a `[!REALIZATION]` or `[!REVERSAL]`; a later run in a fresh session, on the same target, shows evidence it acted on that prior finding rather than rediscovering it. That is learning. The skillset does not currently produce this reliably. This is the most underdeveloped of the three and the most important gap for a future loop run to target.

**Meta-cognition** — *what the target is becoming, and is the loop's attention in the right place.* Reasoning about the work itself: the arc, the recurring patterns, whether the questions being asked are the right questions. Without this, an agent will keep solving local problems while the structural problem drifts.
- *How the skillset solves it:* `.trail/compass.md` — the current synthesized orientation, written by Retrospect after reading the arc, read by Improve at step 1 before each run. The Retrospect skill is the mechanism that produces it. This `vision.md` sits alongside it: vision is what the operator/team holds and does not change without an explicit decision; compass is what the agent derives from the trail and is rewritten each Retrospect run.

## The hard problem this repo exists to chip away at

When this repo targets itself, the loop has to derive its compass from the trail. The agent cannot be told "this is what the target is becoming" — it has to read the trail, form arc-claims, and write that orientation itself. **That — autonomous compass derivation — is the hard problem.** Every other reasoning capability sits on top of it: an agent that cannot derive what the target is becoming will keep optimizing for whatever metric is in front of it.

Vision (this file) is what the operator gives the agent as input. Compass is what the agent must produce as output. The gap between them is what Retrospect is trying to close.

## Horizon (context, not current focus)

The longer arc is that the skills suite is intended to become the reasoning layer for an autonomous execution harness — evo (`c:\git\evo`) is the concrete instance, but the goal is broader: **the skills should be specifiable cleanly enough that any execution harness could invoke them**. Integration with any specific system is **deferred** — it does not begin until the reasoning layer has proven itself on real targets with Retrospect in play, and until the specification is precise enough that the integration is a matter of wiring, not interpretation.
