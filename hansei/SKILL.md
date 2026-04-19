---
name: hansei
version: 2.0.1
description: 'Reflect on the improvement loop itself. Examine the trail, surface recurring findings, blind spots, methodology effectiveness, and what the loop has been ignoring. Meta-improvement - improving the improvement process. USE WHEN: reflect, retrospective, what are we missing, blind spots in the loop, why does this keep recurring, hansei, examine the trail, meta-improvement, loop critique, what hasnt worked, why is the score plateauing.'
argument-hint: 'Specify the target whose improvement history to reflect on, and optionally a specific concern about the loop'
---

# Hansei

*Reflect on the loop, not the artifact.*

Hansei examines the improvement process itself. While Kaizen improves the target and Kaikaku evaluates whether to replace it, Hansei asks whether the improvement process is working - whether it is measuring the right things, finding the right problems, and actually making progress or just churning.

**Part of the suite:** For orchestration, see **Kata**. For improving the artifact, see **Kaizen**. For structural redesign, see **Kaikaku**. For novelty probes that test reasoning quality, see **Shiken**.

## What Hansei Examines

### The Trail

Read the improvement history. GENBA entries, Kiroku sessions, prior run reports, changelogs.

- What has the loop been finding across runs?
- Are the findings getting more specific (progress) or staying at the same level (stagnation)?
- Are the same categories of finding recurring? If so, why is the loop not resolving them?

### Recurring Patterns

Look for findings that keep appearing across multiple runs:

- Same finding, same words: the fix did not work, or the fix was cosmetic.
- Same class of finding, different instances: the root cause is structural and the loop is treating symptoms.
- Finding that was marked fixed but returned: the change was reverted or the fix was incomplete.

For each recurring pattern: what would it take to resolve this permanently? Is it a Kaizen problem (fix the thing) or a Kaikaku problem (the structure makes this inevitable)?

### Blind Spots

What has the loop NOT been looking at?

- Are there aspects of the target that no run has ever examined?
- Is the loop anchored to a particular analytical lens and missing others?
- Has the loop been evaluating the artifact as a document but never testing it as a tool?
- Has the loop been measuring input quality (how good is the skill file?) but not output quality (how good is the work the skill produces)?
- Are there observer classes (from Principle 2) whose perspective has never been represented?

### Methodology Effectiveness

Is the improvement process itself well-designed?

- Is the scoring rubric measuring what matters?
- Are the diagnostic lenses revealing real problems or generating false positives?
- Is the loop producing genuine improvements or just reshuffling?
- Would a different approach (different rubric, different focus, different evaluator) produce better results?

### Trajectory

Plot the trajectory. Not just scores over time, but the character of the work:

- Early runs: broad findings, large improvements. Expected.
- Middle runs: findings become more specific, improvements become smaller. Progress.
- Late runs: findings are cosmetic, improvements are marginal. Approaching convergence - or approaching the structural ceiling.
- Stagnation: score oscillates, findings cycle, no clear direction. The loop may need Kaikaku on itself.

## Output

Hansei produces a reflection, not a fix. Its output is:

1. What the loop has been doing well
2. What the loop has been missing
3. Whether the loop's methodology is still appropriate or needs adjustment
4. Specific recommendations for the next cycle (focus area, methodology change, rubric revision, etc.)

Hansei does not modify the target artifact. It modifies the loop's approach for the next iteration.
