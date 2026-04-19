---
name: kaizen
version: 2.0.1
description: 'Incremental improvement - diagnose, challenge blind spots, prioritize by impact, implement, verify. The core improvement cycle. Includes diagnostic vocabulary for unevenness, overburden, and waste. USE WHEN: audit, review, rate, improve, make impressive, quality loop, iterate, kaizen, evolve this, what would make this better, ROI analysis, blind spots, what am I missing.'
argument-hint: 'Specify the target to improve and optionally a focus area or quality concern'
---

# Kaizen

*Make it better. Prove it is better.*

Kaizen is the core improvement skill. Given a target, it finds what needs improving, determines the highest-leverage changes, implements them, and verifies the results. It is incremental - the target's fundamental structure is assumed to be sound.

**Part of the suite:** For orchestration, see **Kata**. For structural redesign, see **Kaikaku**. For reflection on the loop itself, see **Hansei**. For novelty probes that test reasoning quality, see **Shiken**.

## The Work

### Diagnose

Examine the target. What is its current state? What are its strengths? What are its weaknesses?

Three diagnostic lenses are available. They are vocabulary for thinking about different classes of problems, not a sequential procedure:

**Unevenness** - Where is the target inconsistent with itself? Mixed conventions, uneven quality distribution, asymmetric error handling, naming that follows three different patterns. Unevenness matters because it signals places where the target grew by accretion rather than design. It is often a root cause: fix the inconsistency and several downstream symptoms resolve.

**Overburden** - Where is the target asked to do too much? A module with too many responsibilities. A function that handles unrelated concerns. An interface that serves too many consumers. Overburden matters because it concentrates risk: the overburdened component is the one most likely to break, hardest to change, and most expensive to maintain.

**Waste** - Where does the target carry things that do not earn their existence? Dead code, unused abstractions, validation that can never fire, documentation that restates what the code already says. Waste matters because it creates cognitive load without contributing value. Every unnecessary element is something a future developer must understand before they can change what is around it.

Use these lenses as thinking tools. If the target's problems do not fit any of them, describe what you actually see. The diagnosis must reflect the target, not the categories.

### Challenge Blind Spots

After the initial diagnosis, ask: *What am I not seeing?*

- Are there structural assumptions I have not questioned?
- Does the target have patterns that look intentional but might be accidental?
- Am I anchored to the most obvious finding and missing a subtler, more important one?
- Would someone from a different tradition (different language, different domain, different era of software engineering) see something I missed?

This is not performative skepticism. It is a genuine attempt to catch what the first pass missed. If you find nothing, say so. Do not manufacture blind spots to appear thorough.

### Prioritize

Rank findings by impact. The question is not "how many things can I fix" but "what single change would improve this target the most?"

For each finding, consider:
- How much does this hurt the target's ability to serve its purpose?
- How much risk does this create?
- How hard is it to fix?
- Does fixing this resolve other findings too?

Start with the highest-leverage change. Not everything needs to be fixed in one pass. Kaizen is incremental.

### Implement

Make the changes. For each change:
- State what you are changing and why before making the change
- Make the change
- Verify the change is correct (tests pass, no regressions, the improvement is real)

Show the reasoning, not just the diff. "I consolidated these three naming conventions into one because the inconsistency was the root cause of the confusing API surface" - not just a diff.

### Verify

After all changes:
- Does the target still work? Run tests, check types, verify builds.
- Are the improvements real? Compare the current state to the prior state on the specific findings you addressed.
- Did any changes introduce new problems?

### Self-Evaluate

Score the target's current state. Be honest. A score that inflates progress undermines the loop. If the target was 4/10 before and your changes brought it to 5/10, say 5/10 - not 7/10 because you tried hard.

If a scoring rubric exists for the target, use it. If not, state your criteria explicitly so the next evaluator can score on the same basis.
