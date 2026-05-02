# A stance on what we're actually trying to solve

_Author: Nils Holmager ([@ntholm86](https://github.com/ntholm86)). Version 0.1, 2026-05-01. This is a stance, not a paper. It states what I'm betting on, where I think it differs from adjacent work, and what would prove me wrong._

---

## The situation, in plain language

You're using an AI agent that can do things you can't fully verify. Maybe it's writing code in a framework you're rusty in. Maybe it's refactoring across a codebase larger than you can hold in your head. Maybe it's making a sequence of small judgment calls — naming, structuring, choosing between two reasonable approaches — at a rate you couldn't review even if you tried.

You are still responsible for the outcome.

Two stances are common, and both are wrong.

**Stance one:** "I'll just review everything." You can't. Not at the rate the agent produces it, not in the depth that would actually catch the mistakes that matter. This stance scales until it doesn't, and the moment it stops scaling is the moment you start rubber-stamping.

**Stance two:** "The agent is good enough, I'll trust the outputs." Sometimes true. But "good enough" is not a property of the agent — it's a property of the agent *on this task, this codebase, this day, with this framing.* You don't know in advance which runs are the ones where it's wrong in a way that will cost you. By the time you find out, it's downstream of you.

The interesting question is not which stance is right. Both are evasions. The interesting question is:

> **What does it actually take for a human to safely hand real work to an AI more capable than themselves on that work — and remain the responsible party for what gets done?**

That question is older than the current AI wave. It has answers in aviation (autopilot), in surgery (robotic assistance), in finance (algorithmic execution). What's new is that the AI is now a generalist, the work is open-ended, and the verification gap can be arbitrarily large at the moment of decision. Nothing in the older domains transfers cleanly.

I don't think this question is being addressed head-on. Pieces of it are. The whole thing is not.

## Why the existing labels miss it

The relevant adjacent fields:

- **AI oversight / scalable oversight** — Anthropic, ARC Evals, METR. Asks: can humans supervise systems that exceed them? Mostly framed at *training time* (debate, weak-to-strong, recursive reward modeling) and *evaluation time*. Treats oversight as a regulator-grade activity. Closest in spirit; wrong layer for the situation I described.
- **Agentic AI safety / agent governance** — Shavit et al. ("Practices for Governing Agentic AI Systems"), Chan et al. ("Visibility into AI Agents"). Asks: how do we keep autonomous agents accountable? Concerned with traceability, but the audience for that traceability is institutional — auditors, policy. Not the operator at the wheel.
- **Human-in-the-loop / human-AI collaboration** — long HCI tradition. Mostly assumes the human is at least the AI's equal on the task. The asymmetric case — AI more capable, human still responsible — is rarely the central case.
- **Constitutional AI, Model Spec** — specify what the AI should *do.* Not how the human stays *responsible* for what it did.
- **SRE / observability / postmortem culture** — Allspaw, Google SRE. Closest in *form* (structured traces, evidence-driven review) but the motivation is system reliability, not delegation under capability asymmetry.

None of these are wrong. They're all working on related problems. But the *operator-at-the-wheel-of-a-more-capable-system, in real time, while the run is happening* problem is not where most of the energy is. It tends to be assumed away in two directions: either the human is treated as a regulator who reviews after the fact, or the human is treated as a pair-programmer who is the AI's equal.

I think there's a real problem in the middle they're collectively under-serving. I want to give it a name and bet on it.

## The name and what it means

I'll call it **operation-time trustworthy delegation**.

Four sub-claims define the stance:

**1. Operation-time, not training-time or evaluation-time.** The interesting decisions happen while the agent is running, not during training and not during a separate evaluation pass. The instrumentation has to work *during the run*, not as a retrospective audit. If you can only see what happened after the fact, you can't steer.

**2. Delegation, not control or supervision.** "Control" implies you can intervene at every step. You can't, and even trying degrades the value of using a more-capable agent. "Supervision" implies a regulator stance. The interesting stance is *delegation* — you've handed real work to a more-capable party and remain on the hook for the outcome. That is a different relationship than supervisor-to-subordinate.

**3. Evidence-while-driving, not audit-after-the-fact.** The output the operator needs is not a log they could in principle reconstruct from. It's a dashboard — instruments calibrated for the operator's bandwidth and their authority to course-correct *before the run finishes.* The trail has to be readable in time to matter.

**4. Protocol, not tool.** The artifact that solves this should be specifiable cleanly enough that any execution harness — not just the one I built — can implement it. If the answer is "use my framework," the answer is wrong. The answer has to be something a competent team could re-implement in their own stack from a spec.

That four-part stance is what I mean by the term. It's also the boundary: a contribution that satisfies one or two of these and drops the rest is doing something interesting but not this thing.

## What I'm doing about it

I'm building a small set of skills — currently six, version 3.11.0 — that an AI agent applies to its own work. The skills are: **intent** (interpret the operator's intent before acting), **improve** (one highest-leverage change per run, stated reason), **probe** (test reasoning vs. pattern-matching), **trail** (append-only structured evidence per run), **retrospect** (read the arc of the trail and synthesize current orientation), and **hunch** (surface guesses the agent has formed about the operator's direction, as falsifiable questions).

The skills sit on top of three principles I've published separately ([Principles of Autonomous Development](https://github.com/ntholm86/autonomous-agent-principles)): Commander's Intent (define destination, not route), Observable Autonomy (autonomy is a function of transparency), and Convergence Is Silence (you're done when independent evaluators find nothing left to change).

The repo where the skills live is **simultaneously the workshop and the proof**. The skills have to be able to improve themselves; if they can't, the claim that they're a usable reasoning layer is hollow. Each run finds the highest-leverage thing left to change in the skills themselves and changes it — or argues for convergence.

The workshop-and-proof setup is honest about its own limits. It's incestuous: same author, same lineage, no real external test yet. Any claim the skills make about generality is provisional until the protocol gets exercised by a harness that didn't co-evolve with it.

## What I'm not claiming

I want to be precise about what is and isn't on the table.

- **I'm not claiming the skills are the answer.** They are *one attempt* at the answer. They may be the wrong attempt. They may be the right attempt for a narrower class of work than I hope.
- **I'm not claiming the protocol is finished.** The current version is 3.x. The vision/compass split is two weeks old. Hunch was added this week. Most of the protocol is unproven in execution.
- **I'm not claiming this solves AI safety.** It doesn't. It addresses one slice — the slice where a willing operator with real authority is delegating to a real agent, in real time, on a real task. Many of the harder safety problems sit outside that slice.
- **I'm not claiming originality on the components.** Trails are standard. Mission-type command is Prussian. Independent multi-evaluator convergence is older than I am. The bet is on the combination and the framing of *what they're collectively trying to solve.*

## What would prove this wrong

A stance without falsification is a manifesto. Here's what I'd take as serious evidence the bet is wrong:

1. **The protocol cannot be implemented by a harness that didn't co-evolve with it.** If after one or two honest external attempts, the spec turns out to require so much interpretation that it isn't really a spec, the "protocol not tool" claim is false. The skills become a framework. That's a smaller, less interesting result.
2. **Operators don't actually use the trail in real time.** If when given a working multi-resolution trail, operators only ever consult it after the fact, then "evidence-while-driving" is a story I told and not a thing humans actually do. The dashboard metaphor breaks down. The result might still be useful for audit, but the central claim collapses.
3. **The capability gap eats it.** If the protocol works at 1-2 capability steps of asymmetry (operator can verify if they squint hard) and breaks down at 5+ steps (operator cannot verify even with effort), then it's a tool for *narrow* delegation, not the trustworthy-delegation question I framed. Still useful; not what I'm betting on.
4. **A diverse evaluator panel can't agree the protocol-driven runs are different from the non-protocol runs.** Convergence Is Silence is the validation mechanism. If multiple independent evaluators looking at runs done with and without the protocol can't tell them apart on the dimensions that matter, the protocol isn't doing the work I think it's doing.
5. **The right unit of analysis is somewhere else entirely.** Maybe trustworthy delegation isn't about per-run instrumentation; maybe it's about organizational structure, contract design, or post-incident learning systems. If after engaging with the adjacent fields someone can show me the locus is elsewhere, I'd rather know than persist.

I don't expect all of these to come back negative. I expect at least one to. That's the point of stating them up front.

## What the runs are showing

_Added 2026-05-02. This section is updated as evidence accumulates._

The Hunch skill was the first mechanism in the protocol to produce something the operator had not written down before the run. Four runs in a single session, each on a different target, each at a different level of prior context:

1. **Own vision paragraph.** The operator wrote a paragraph about the repo's direction. Hunch read it and surfaced a latent intent the operator hadn't stated directly. Confirmed.
2. **Known target with history (evo).** A repo the operator knows deeply, with an existing trail. Hunch surfaced three direction and constraint hunches from the trail arc. All three confirmed.
3. **Cold foreign target (vectorium).** A repo not discussed in the session, no `.trail/`, no vision, no priming. Signal came entirely from code structure, git commit arc, and package.json. Hunch 1 surfaced "lost interest after beating the benchmark" — not written anywhere in the repo, inferred from the commit arc alone (performance climbs to a peak, then cleaning commits, then silence). Confirmed.
4. **Production system with trail history (leifoglenedk).** A live driving school management system with three prior improvement runs in the trail. Hunch surfaced the dual-role tension (production vs. practice target), the reason P0 security work was blocked, and the sequencing logic behind the three runs. All three confirmed.

The pattern across all four: **the agent articulated something the operator had not written down, the operator confirmed it, and the confirmation came as recognition rather than surprise.** None of the confirmed hunches were new information to the operator. But none were written anywhere the agent could have retrieved them.

The mechanism: an agent reads signal the operator never consciously gave it — emphasis patterns, what gets pushed back on, what the commit arc looks like when motivation runs out, what's named in every run but never touched — and surfaces that signal as falsifiable questions. Not conclusions. Not actions. Questions the operator answers in a sentence. The operator then either confirms, corrects, or redirects; the agent updates its working model.

This is how Observable Autonomy and Commander's Intent combine in practice. Commander's Intent says: give the AI the destination, not the route, so it can adapt. But "the destination" assumes the operator has the destination fully articulated. The Hunch mechanism works one step earlier: it reduces the cost of articulation, making implicit intent explicit enough to steer from. The operator stays in the loop not by reviewing every action but by answering questions whose answers are already in their head — they just hadn't said them yet.

This is early evidence, not proof. Four runs in one session, one operator. But the pattern held across cold and warm targets, across targets with and without existing trails, and across targets where the operator has deep knowledge and targets they haven't looked at recently. The falsification condition — "Hunch only ever confirms things already written in vision.md" — failed to trigger. Hunch produced signal not in any file.

What remains unproven: whether this scales to capability gaps large enough that the operator can't verify the agent's source-reading even conversationally; whether it holds with operators other than the one building it; whether the questions the agent asks are well-calibrated or systematically biased toward certain kinds of implicit intent. Those are the next tests.

## Where this is going

The next stretch of work, in order:

1. **Close the validation gap inside the repo.** Several mechanisms — Retrospect, the vision/compass split, Hunch — are in the protocol but unproven in execution. They need to actually run and produce something that wasn't pre-seeded.
2. **Strengthen the weakest of memory / learning / meta-cognition.** Memory (the trail) and meta-cognition (the compass) are reasonably solid. Learning — extracting durable updates from prior runs — is currently weak: a future agent re-reads the trail and reasons over it, which is honest but slow. This is the most likely place a future loop run finds leverage.
3. **One external proof.** Run the protocol on a target where the AI exceeds the operator on the underlying task and the operator is not me. Without this, the workshop-and-proof setup remains incestuous.
4. **Engage the adjacent fields.** Send this stance to 3-5 people working on the closest problems. The goal is not validation; it's pressure-testing. Three outcomes are all good: "you're describing what I already do" (frame is not novel — adjust), "you're missing X" (frame is incomplete — adjust), "this is genuinely different" (frame earns its position).

If steps 1-3 hold up, the stance is worth defending publicly. If they don't, the stance updates or dies. Either is a result.

---

## Status

This stance is **v0.2 and provisional** (updated 2026-05-02 with first empirical evidence from Hunch runs). The repo it sits in is at v3.13.0 of the skillset and is not converged. The convergence baseline at v3.1.0 was for a smaller, simpler suite; the current suite is in active research, not production refinement. Any external claim about the suite's "convergence" should be read against that distinction.

I'm putting this here so the bet is stated and findable. If you read it and think I'm pointing at something real, I'd like to hear from you. If you read it and think I'm pointing at something that already has a name and a literature I'm ignoring, I'd especially like to hear from you.

— Nils

Repo: <https://github.com/ntholm86/autonomous-agent-skills>
Principles (separate): <https://github.com/ntholm86/autonomous-agent-principles>
