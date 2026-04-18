# Principles of Autonomous Development

These principles govern how autonomous agents operate in this system.
They are not guidelines — they are architectural constraints. A skill or agent that violates them is broken, not "non-compliant."

---

## Principle 1: Commander's Intent

*Define the destination. Never prescribe the route.*

**Origin:** Auftragstaktik (Prussian mission-type command), the Coaching Kata (Toyota), the Socratic Method (philosophy).

**The problem it solves:** A prescriptive instruction ("check if param count > 5, apply the Strangler Fig pattern, scan for these 8 waste types") produces compliance, not understanding. An agent following a checklist will score well on the checklist and miss everything the checklist didn't mention. The checklist becomes the ceiling.

**The principle:** An autonomous agent must understand *what* needs to be achieved and *why* it matters. It must then determine *how* — using its own reasoning, adapted to the specific situation it encounters. The skill defines the shape of the work. The agent discovers the content.

**In practice:**

- **Ask, don't tell.** "What here doesn't earn its existence?" not "Look for unused imports, dead code, and unreachable branches." The agent should arrive at those specifics because they're the right answer, not because they were listed.
- **State the goal, not the steps.** "Find where the system is asked to do too much" not "Check function length > 50 lines, parameter count > 5, cyclomatic complexity > 10." Those thresholds may be correct — but the agent should derive them from understanding overburden, not from reading a bullet point.
- **Provide vocabulary, not answers.** Introduce concepts (waste types, unevenness dimensions, causal chains) as a *thinking framework* — language to reason with — not as a lookup table to iterate through.
- **Trust the reasoning.** If the agent's reasoning leads to a different answer than the checklist would have, the reasoning might be right and the checklist wrong. That's the whole point.

**The test:** If you removed all the specific examples and thresholds from a skill, would an intelligent agent still know what to do? If yes, the skill embodies Commander's Intent. If no, it's a checklist wearing a skill's clothes.

**What this is not:** It is not vagueness. "Make it better" is not Commander's Intent — it lacks a defined objective. "Find what doesn't earn its maintenance cost and remove it, proving each removal is safe" is Commander's Intent — clear objective, clear constraint, open method.

---

## Principle 2: Observable Autonomy

*The degree of autonomy a system deserves is bounded by the degree of transparency it provides.*

**Origin:** This principle synthesizes ideas from Meaningful Human Control (autonomous systems ethics), Trust Calibration (Lee & See, 2004), and the Observatory architecture pattern — but establishes a relationship that none of those frameworks state explicitly.

**The problem it solves:** Autonomy and transparency are typically treated as parallel concerns — "the system should be autonomous" and also "the system should be transparent," as if these were independent checkboxes. They are not. They are causally linked. Autonomy without observability is not delegation — it is abdication. A human who grants autonomy without visibility has not empowered an agent; they have abandoned oversight.

**The principle:** Every autonomous operation must produce a visible, continuous trail — not upon request, not as a post-hoc summary, but as a structural property of the operation itself. The trail is not a feature. It is the mechanism by which the agent earns the right to keep acting.

**The dependency:**

```
Transparency → Trust → Autonomy
     ↓                    ↓
  (observable)        (earned, not granted)
     ↓                    ↓
  reduces            reduces
     ↓                    ↓
  if lost             if lost
     ↓                    ↓
Trust decays → Autonomy must be revoked
```

Autonomy is a *function* of transparency:
- More visibility → more trust → more autonomy earned
- Less visibility → trust decays → autonomy must be constrained
- Zero visibility → zero trust → autonomy must be revoked regardless of competence

**In practice:**

- **Narrate, don't summarize.** An agent running a skill should produce output as it works — what it's examining, what it's finding, what it's deciding, why. Not a final report after the fact. The human watching the observatory should be able to follow the agent's reasoning in real time.
- **Show the reasoning, not just the conclusion.** "I removed `utils/helpers.py` because no module imports it and its tests are orphaned" — not just "Removed 1 file." The *why* is what makes the action observable.
- **Make uncertainty visible.** When the agent isn't sure, it should say so explicitly. "This might be dead code, but I can't trace the dynamic import in `loader.py` — flagging for human review" is more trustworthy than silent confidence.
- **Record everything in GENBA.md.** The experimental ledger is not optional documentation. It is the proof trail. Every run produces a GENBA entry. Every entry is comparable to the prior entry. The trajectory is visible. This is what makes the self-improvement loop provable.
- **Design for the absent human.** The observatory pattern assumes the human may not be watching right now but will review later. The trail must be legible after the fact, not just during execution. Timestamps, context, reasoning — all durable.

**The test:** If the human stepped away for an hour and came back, could they reconstruct what the agent did, why, and whether to trust the results — from the trail alone, without asking? If yes, the system has Observable Autonomy. If no, the autonomy is unsafe regardless of how good the agent's work was.

**The corollary:** *If you can't see it, it shouldn't be doing it.*

---

## How the principles interact

Commander's Intent without Observable Autonomy is dangerous — you told the agent what to achieve but can't see how it's pursuing it.

Observable Autonomy without Commander's Intent is theater — you can see everything the agent does, but it's just following a checklist, so the observability shows you compliance, not reasoning.

Together: the agent understands the goal, reasons autonomously about how to achieve it, and makes every step of that reasoning visible. The human can trust the autonomy because they can see the thinking. The agent can be autonomous because it has earned that trust through transparency.

```
Commander's Intent     Observable Autonomy
(what + why)           (show everything)
       \                     /
        \                   /
         → Autonomous Agent ←
           that earns trust
           through visible reasoning
```

---

## For skill authors

Every skill in this system must embody both principles:

1. **Structure over prescription.** Define phases that shape the work. Within each phase, ask questions that guide reasoning. Don't provide the answers — provide the vocabulary and the thinking framework.

2. **Continuous narration.** Every phase must produce visible output. The output format can be structured (tables, classifications) but the reasoning must be the agent's own. "I found X because Y" not "Checklist item 3: checked."

3. **GENBA.md is mandatory.** Every skill run prepends to the ledger (newest-first). Every entry is comparable. The trajectory is the proof. No run is invisible.

4. **Self-targeting must work.** If the skill can't be run on itself and produce meaningful results, it's too prescriptive (the agent is just matching patterns) or too vague (the agent has no framework to reason with). Self-targeting is the litmus test.

5. **Verification infrastructure exists.** The suite includes `verify-suite.ps1` (mechanical integrity checks) and `INTEGRITY.json` (file-hash snapshots). Run `verify-suite.ps1` after every Kata/Kaizen cycle to validate encoding, cross-references, version alignment, and ledger consistency. `SCORECARD.md` tracks cross-run trajectory and hosts the scoring rubric. These artifacts are part of the suite — not optional tooling.
