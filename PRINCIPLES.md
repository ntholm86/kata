# Principles of Autonomous Development

> **This file is a copy.** Source: [autonomous-agent-principles](https://github.com/ntholm86/autonomous-agent-principles) repository, commit `dea859d`. Copied 2026-04-23; header updated 2026-04-24 (only metadata changed in manifesto since v1.0.0 — principles text unchanged).
> The manifesto repo is canonical. This copy rewrites manifesto-internal links to canonical URLs so the document remains navigable from this suite.
> License: CC BY-SA 4.0 (the principles document). The execution tools and scripts in this repo are MIT.

These principles govern how autonomous agents operate in this system.
They are not guidelines - they are **architectural constraints**. A skill or agent that violates them is broken, not "non-compliant."

Context for these principles - the problems they are designed to solve - is in [PROBLEM.md](https://github.com/ntholm86/autonomous-agent-principles/blob/v1.0.0/PROBLEM.md).

---

## Digest (60 seconds)

Three principles, one emergent property:

1. **Commander's Intent** - *Define the destination. Never prescribe the route.* The agent must interpret and adapt, not execute a checklist.
2. **Observable Autonomy** - *Autonomy is a function of transparency.* Every autonomous operation produces a visible, continuous, multi-resolution trail.
3. **Convergence Is Silence** - *The system has converged when diverse independent evaluators find nothing left to change.* Not when a score stops moving.

Together they produce **Autonomous Reasoning Fidelity (ARF)** - the external signal that the agent is genuinely reasoning about the situation and that the reasoning is visible enough for observers to judge. ARF is not a fourth principle; it is what the three principles measure when they hold simultaneously. (See our [Clean-Room Proof of Autonomy](https://github.com/ntholm86/autonomous-agent-principles/blob/v1.0.0/PROOF.md) for how we empirically validated this).

---

## Principle 1: Commander's Intent

*Define the destination. Never prescribe the route.*

**Origin:** Auftragstaktik (Prussian mission-type command), the Coaching Kata (Toyota), the Socratic Method.

**The problem it solves:** A prescriptive instruction ("check if param count > 5, apply the Strangler Fig pattern, scan for these 8 waste types") produces compliance, not understanding. An agent following a checklist scores well on the checklist and misses everything the checklist didn't mention. The checklist becomes the ceiling.

**The principle:** An autonomous agent must understand *what* needs to be achieved and *why* it matters. It must then determine *how* - interpreting the mission and adapting to the specific situation it encounters. The skill defines the shape of the work. The agent discovers the content.

**In practice:**

- **Ask, don't tell.** "What here doesn't earn its existence?" not "Look for unused imports, dead code, and unreachable branches." The agent should arrive at those specifics because they're the right answer, not because they were listed.
- **State the goal, not the steps.** "Find where the system is asked to do too much" not "Check function length > 50 lines, parameter count > 5." Those thresholds may be correct - but the agent should derive them from understanding overburden, not from reading a bullet point.
- **Provide vocabulary, not answers.** Introduce concepts as a *thinking framework* - language to reason with - not as a lookup table.
- **Trust the interpretation.** If the agent's interpretation of the mission leads to a different answer than the checklist would have, the interpretation might be right and the checklist wrong. That's the whole point.

**The test:** If you removed all the specific examples and thresholds from a skill, would an intelligent agent still know what to do? If yes, the skill embodies Commander's Intent. If no, it's a checklist wearing a skill's clothes.

**What this is not:** It is not vagueness. "Make it better" is not Commander's Intent - it lacks a defined objective. "Find what doesn't earn its maintenance cost and remove it, proving each removal is safe" is Commander's Intent - clear objective, clear constraint, open method.

---

## Principle 2: Observable Autonomy

*The degree of autonomy a system deserves is bounded by the degree of transparency it provides.*

**Origin:** Synthesizes Meaningful Human Control (autonomous systems ethics), Trust Calibration (Lee & See, 2004), and the Observatory architecture pattern - but establishes a relationship none of those frameworks state explicitly.

**The problem it solves:** Autonomy and transparency are typically treated as parallel concerns - as if they were independent checkboxes. They are not. They are causally linked. Autonomy without observability is not delegation - it is abdication.

**The principle:** Every autonomous operation must produce a visible, continuous trail - not upon request, not as a post-hoc summary, but as a structural property of the operation itself. The trail is not a feature. It is the mechanism by which the agent earns the right to keep acting.

**The dependency:**

```
Transparency -> Trust -> Autonomy
     |                    |
  (observable)        (earned, not granted)
     |                    |
  reduces            reduces
     |                    |
  if lost             if lost
     |                    |
Trust decays -> Autonomy must be revoked
```

Autonomy is a *function* of transparency:
- More visibility -> more trust -> more autonomy earned
- Less visibility -> trust decays -> autonomy must be constrained
- Zero visibility -> zero trust -> autonomy must be revoked regardless of competence

### The resolution requirement

Observability is not binary - it is a function of observer, time budget, and evidence resolution. A trail at only one resolution is observable to one class of observer and opaque to the rest. A 50-page transcript is unobservable to the deployer with 2 minutes; a 1-paragraph summary is unobservable to the regulator with an afternoon.

Evidence must therefore exist at multiple resolutions simultaneously:

- **Full evidence** - the complete reasoning exchange (prompts, responses, tool calls, dead ends, reversals). Ground truth. An observer with unlimited time can replay the entire sequence.
- **Indexed evidence** - key decisions, realizations, and turning points highlighted within the full evidence, so an observer with bounded time can navigate to what matters without reading everything.
- **Digested evidence** - a summary that gives any observer a 60-second understanding of direction, recent decisions, and integrity. Must point to disagreements and reversals, not just outcomes.

A single-resolution trail satisfies one observer at the cost of silently excluding the others. This violates the principle even when the trail itself is honest - because observability that only one party can consume is not observability, it is the *appearance* of observability.

**Fidelity marking.** Where the agent authors its own summary, this must be explicitly marked so observers can discount accordingly. A summary written by the audited party is evidence, but it is not *independent* evidence. Where verbatim capture is impossible (e.g., platform limitations prevent transcript export), the trail must explicitly mark fidelity rather than silently degrading. "Reconstructed from agent memory" and "verbatim tool output" are different trust levels; conflating them is dishonest.

**In practice:**

- **Record reasoning, not just results.** Capture what was examined, what was found, what was decided, and why - not a polished after-the-fact summary. The constraint is *content fidelity* (the reasoning was recorded), not *delivery timing* (the human watched live).
- **Show the reasoning, not just the conclusion.** "I removed `utils/helpers.py` because no module imports it and its tests are orphaned" - not just "Removed 1 file." The *why* is what makes the action observable.
- **Make uncertainty visible.** "This might be dead code, but I can't trace the dynamic import in `loader.py` - flagging for human review" is more trustworthy than silent confidence.
- **Record everything.** The trail is not optional documentation. Every autonomous operation produces a trail entry. Every entry is comparable to the prior entry. The trajectory is visible.
- **Design for the absent human.** Assume the human may not be watching right now but will review later. The trail must be legible after the fact, not just during execution.

**The test:** If the human stepped away for an hour and came back, could they - at their resolution - reconstruct what the agent did, why, and whether to trust the results, from the trail alone? If yes, the system has Observable Autonomy. If no, the autonomy is unsafe regardless of how good the agent's work was.

**The corollary:** *If you can't see it, it shouldn't be doing it.*

---

## Principle 3: Convergence Is Silence

*A system has converged when diverse evaluators independently find nothing left to change - not when the score stops moving.*

**Origin:** Cross-validation (statistics), ensemble agreement (machine learning), the Delphi method (forecasting), and Kaizen's own exit condition - taken to its logical conclusion.

**The problem it solves:** Iterative improvement loops declare convergence too early. The typical criterion - "the score stabilized across N consecutive runs" - measures the wrong signal. A score can stabilize while the system is still changing underneath: each run removes something and adds something, the score stays flat, but the artifact never stops churning. Worse, a single evaluator (or a single model family) can converge on its own blind spots, producing a stable score that reflects the evaluator's limitations, not the artifact's quality.

Score stability is necessary but not sufficient. Change-rate stability is necessary but not sufficient. Only the combination - across diverse, independent evaluators - constitutes convergence.

**The principle:** Convergence requires diverse independent evaluators to arrive at the same assessment *and* find nothing material to change.

### The test

Three simultaneous conditions:

1. **Score agreement across distinct evaluator families.** N consecutive evaluations by M distinct evaluator families produce the same score within a defined tolerance. Evaluators must be meaningfully diverse - different models, different people, different analytical traditions. Same-family evaluators (e.g., multiple versions of one model) count as one. Each model family develops habituated blind spots; a different family, trained and evaluated independently, does not share those blind spots. The mechanism is analogous to scientific peer review: the value is not in more reviews but in *independent* reviews.

2. **Zero material change.** Each of those N evaluations ends with no changes to the artifact itself. The only output is the evaluation record. If a run produces a diff to the artifact, the convergence counter resets to zero - regardless of whether the score changed.

3. **Independent assessment, including of the measurement scheme.** Each evaluator scores fresh, without consulting prior scores. In chat-based systems, switching to a new model inside the same conversation is **not** independent - prior scores remain in context. A valid convergence evaluation must begin in a fresh conversation/session. Independence extends to *what is being measured*, not just to the score: if the first evaluator derives the measurement scheme and subsequent evaluators merely score against it, independence is partial. A genuinely independent evaluator re-derives the measurement scheme from the artifact before scoring, then compares against any inherited scheme. Convergence on re-derivation validates the scheme; divergence is itself a finding (the inherited scheme had a blind spot one family could not see). Pre-agreed externally anchored rubrics (published standards) are exempt from re-derivation, but not from the divergence-as-finding rule.

**The minimum bar:** 3 consecutive runs, 3 distinct evaluator families, same score, zero artifact changes, at least one re-derivation of the measurement scheme that converged with the inherited scheme. Below this, you have improvement trajectory. Above this, you have convergence. There is no middle ground.

**Why this matters for autonomous development:** Without this principle, an autonomous improvement loop has no honest stopping condition. It runs indefinitely - each cycle finding something to change because finding something to change is what the loop is designed to do. The agent's incentive is to justify its own execution by producing changes. Convergence Is Silence inverts that incentive: the agent proves its value by finding *nothing*, and the system proves its quality by surviving diverse scrutiny unchanged.

**The corollary:** *If the loop is still producing changes, the system is still improving. If the system is still improving, it hasn't converged. Convergence is not a score - it is the absence of actionable findings across independent observers.*

---

## How the principles interact

Commander's Intent without Observable Autonomy is dangerous - you told the agent what to achieve but can't see how it's pursuing it.

Observable Autonomy without Commander's Intent is theater - you can see everything the agent does, but it's just following a checklist, so the observability shows compliance, not interpretation.

Together: the agent understands the goal, interprets the mission, adapts to what it encounters, and makes every step of that process visible. The human can trust the autonomy because they can see how the agent arrived at its conclusions. The agent can be autonomous because it has earned that trust through transparency.

Convergence Is Silence completes the system: it defines *when the work is done.* Without it, Commander's Intent gives purpose and Observable Autonomy gives visibility, but the loop has no honest exit. Convergence provides the stopping condition - and critically, it requires the other two to function. You can only measure convergence if the evaluator interprets the mission independently (Commander's Intent, not checklist compliance) and the entire trail is visible (Observable Autonomy, not self-reported scores).

```
Commander's Intent     Observable Autonomy     Convergence Is Silence
(what + why)           (show everything)       (when to stop)
       \                     |                      /
        \                    |                     /
         ->    Autonomous Agent that earns    <-
              trust through visible reasoning
              and knows when the work is done
```

### Scope: evidence substrate, not trust manufacturing

These principles do not *create* trust. They produce an **evidence substrate** on which trust *can* form - if observers actually consume the evidence, if the reasoning shown is genuinely correct (not just visible), and if the social, organizational, and incentive conditions for delegation exist independently. The full boundary - what the framework does not solve - is in [PROBLEM.md § Out of Scope](https://github.com/ntholm86/autonomous-agent-principles/blob/v1.0.0/PROBLEM.md#out-of-scope-what-this-framework-does-not-solve).

---

## Autonomous Reasoning Fidelity (operational definition)

ARF is defined conceptually in [PROBLEM.md § What the Framework Measures](https://github.com/ntholm86/autonomous-agent-principles/blob/v1.0.0/PROBLEM.md#what-the-framework-measures-autonomous-reasoning-fidelity). This section gives the operational definition used by the skills.

ARF is not a fourth principle. It is the measurable external signal that exists only when Principles 1 and 2 are both satisfied and Principle 3 has validated the observation. We named it because it needed a name - no existing framework measures it, and it is the property that distinguishes an agent operating under earned autonomy from a sophisticated autocomplete whose outputs happen to look correct.

**Theoretical anchors:**

- **Auftragstaktik** (Prussian mission-type command) - telling subordinates *what* and *why*, then trusting them to determine *how*. Origin of Principle 1 and the "freedom of thought" half of ARF.
- **Meaningful Human Control** (autonomy ethics) - autonomous systems must operate within boundaries that allow humans to maintain appropriate oversight without real-time intervention. Shapes the "trail integrity" half.
- **Trust Calibration** (Lee & See, 2004) - trust in autonomous systems should be calibrated to actual capabilities, and calibration requires observability. Over-trust and under-trust are both failures. Principle 2 is the calibration mechanism.

**Preconditions** (principle compliance - verify the environment, not the agent):

1. **Freedom of thought** (P1 compliance). Remove all examples and thresholds from a skill. Would a competent agent still know what to do? If yes, Commander's Intent holds. If no, the instruction has drifted toward prescription.
2. **Trail integrity** (P2 compliance). Can an absent observer reconstruct what the agent did, why, and whether to trust the results - from the trail alone? The trail is generated by the same model that produced the output; a coherent trail can document reasoning that never occurred. Trail integrity is necessary but not self-validating. It requires external verification through diverse evaluators (Principle 3) to guard against confabulation.

**The ARF metric itself - situational discrimination.** When both preconditions hold, ARF measures one thing: given two cases that look similar on the surface but differ in a material way, does the agent's reasoning path diverge where it should? In routine cases, situated reasoning and pattern-matching produce identical-looking trails. The distinguishing evidence emerges under novel or adversarial conditions - situations the checklist didn't anticipate, distribution shifts that expose shallow compliance, cases where rote execution fails but genuine interpretation succeeds. Without structured novelty, the framework cannot distinguish narration from reasoning.

ARF answers: *did the agent's responses actually vary with the specifics of what it encountered, or did it produce surface variation on a generic template?*

**Validation (Principle 3).** Principles 1 and 2 *produce* the conditions for ARF. Situational discrimination *measures* it. Principle 3 *validates* the measurement. Without diverse, independent evaluators confirming the signal, ARF is self-assessed - and self-assessment can become self-justification. A single evaluator (or single model family) may consistently accept trails that look situated but are generic, because the evaluator shares the agent's blind spots. ARF that survives diverse scrutiny is externally evidenced. ARF that only one observer ever validated is an assertion.

**Implementation note.** These principles define *what* Observable Autonomy requires. They do not prescribe *how* to provide it. A conforming implementation could use markdown files, a database, structured logs, a dashboard, or any other medium - as long as multi-resolution evidence exists, fidelity is marked, and the trail is inspectable by all observer classes. The specific tools and formats used in this suite are one implementation, not the specification itself.

**Why this matters for scoring:** a scoring rubric for systems built on these principles must measure ARF directly - not the preconditions (which verify the environment) but the signal itself: does the agent discriminate between situations that demand different responses? Process frameworks (CMMI, DMAIC, NIST AI RMF) measure whether processes are followed correctly. None of them measure whether the agent's responses are situated to what it actually encountered - because in human organizations, that is assumed. For LLM agents, it must be externally evidenced.

---

## For skill authors

Every skill in this system must embody all three principles:

1. **Structure over prescription.** Define phases that shape the work. Within each phase, ask questions that guide reasoning. Don't provide answers - provide vocabulary and a thinking framework.
2. **Continuous narration.** Every phase must produce visible output. Format can be structured (tables, classifications) but the reasoning must be the agent's own. "I found X because Y" not "Checklist item 3: checked."
3. **Trail recording is mandatory.** Every skill run must update the target's audit trail. Every entry is comparable to the prior entry. The trajectory is the proof. No run is invisible.
4. **Self-targeting must work.** If the skill can't be run on itself and produce meaningful results, it's too prescriptive (the agent is just matching patterns) or too vague (the agent has no framework to reason with). Self-targeting is the litmus test.

The operational standards (verification scripts, integrity snapshots, scoring rubrics, metrics history) that support these principles belong in the consuming implementation's own documentation and tooling. They are tool prescriptions - not architectural constraints - and therefore do not belong in this manifesto repository.
