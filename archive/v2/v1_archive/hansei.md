---
name: hansei
version: 1.34.0
description: 'Hansei (反省) — Structured reflection on the improvement loop itself. Reads the GENBA.md trail and prior reports to surface recurring findings, blind spots, methodology effectiveness, and what the loop has been silently ignoring. Hansei is meta-Kaizen — it improves the improvement process, not the artifact. USE WHEN: reflect, retrospective, what are we missing, blind spots in the loop, why does this keep recurring, hansei, examine the trail, meta-improvement, loop critique, what hasn''t worked, why is the score plateauing.'
argument-hint: 'Optional: scope (last N runs, full history, specific dimension), focus (recurring patterns, blind spots, methodology effectiveness, evaluator behavior)'
---

# Hansei (反省) — Structured Reflection

The improvement loop needs improvement too. Hansei reads the trail and asks what the loop itself has been silently missing.

> **Governing principles:** [Commander's Intent](../PRINCIPLES.md) — this skill defines what reflection is for; what patterns matter and what they mean is your reasoned judgment from reading the actual record. [Observable Autonomy](../PRINCIPLES.md) — the trail you reflect on (GENBA.md, SCORECARD.md, prior reports) is the proof; without the trail there is nothing to reflect on, and the reflection itself becomes part of the trail.

In Toyota's culture, Hansei is structured self-criticism — looking back honestly even when things went well. It is distinct from Kaizen: Kaizen improves the work; Hansei improves the way of working. Toyota practitioners run Hansei as a planned ceremony, not a feel-good ritual.

**Hansei is not a retrospective.** Software retrospectives are famously weak — they produce action items nobody implements. Hansei is rigorous: it interrogates the trail, names what's been recurring, surfaces what's been silently ignored, and challenges the methodology itself. It is willing to find that the loop has been wrong.

**Part of the TPS skill family:** For improving the artifact, see **Kaizen**. For redesigning the artifact, see **Kaikaku**. For diagnosing the artifact, see **Muda**, **Mura**, **Muri**. For novelty probes that test reasoning quality, see **Shiken**. For one full diagnostic + treatment cycle, see **Kata**. Hansei improves the loop that runs all of them.

## When to Use

- After several Kaizen cycles when the score has plateaued
- When the same finding type keeps recurring across runs (systemic, not incident)
- When you suspect the loop has blind spots (every evaluator agreeing is a warning, not a confirmation)
- When methodology choice has felt arbitrary (Kaizen vs Kaikaku vs which 3M lens?)
- "what is the loop missing?", "why does this keep coming back?", "blind spots", "hansei"
- Periodically — every N runs (default 5), regardless of trigger. The blind spots are exactly when nothing feels wrong.

## Core Principles

1. **Read the actual record.** Hansei has no value without GENBA.md or equivalent. Reflection without evidence is rumination.
2. **Name what's silent.** The highest-value findings are things the trail has consistently NOT discussed. What is everyone treating as obvious that may not be?
3. **Be honest about effectiveness.** Which fixes actually moved the needle? Which felt productive but didn't? The trail tells you if you ask.
4. **Challenge the methodology, not just the artifact.** Hansei targets the loop. If every run uses the same lens and finds the same things, the lens may be the limitation.
5. **Surface, don't act.** Hansei produces insight; Kaizen, Kaikaku, or other skills act on it. Conflating reflection with action is how reflection becomes ritual.

## Procedure

### Phase 1: GATHER — Assemble the Record

Identify what trail exists for the target loop:

- GENBA.md (run-by-run ledger)
- SCORECARD.md (cross-cycle scoring, cross-model trajectory)
- Prior Hansei findings (don't repeat what previous reflection already named)
- Conversation history, commit messages, the artifact's own change history

Scope the reflection: full history, last N runs, or runs matching a criterion (model, methodology, dimension). Default: full history if ≤10 runs; last 10 otherwise.

**Narrate what you have and what you don't.** If the trail is thin, say so — that itself is a Hansei finding. A loop without a record cannot be reflected on; the first Hansei output may be "build the trail before reflecting again."

### Phase 2: PATTERN — What Recurs?

Read the trail and identify:

- **Recurring finding types.** Has the same defect class been fixed multiple times in different places? That suggests systemic cause, not isolated incident.
- **Recurring methodology choices.** Did every run use the same lens? Why? Is the choice automatic or reasoned?
- **Recurring evaluator behaviors.** Did models in the ensemble find similar kinds of things and miss similar kinds of things? Did certain dimensions never get critiqued?
- **Recurring scoring patterns.** Did the score plateau? Where? Were deltas concentrated in specific dimensions, or spread evenly?
- **Rubric version transitions.** If the scoring rubric changed between runs (e.g., implicit → v1, dimensions added/removed), account for that when comparing scores. A score drop at a rubric boundary is expected, not regression. Compare dimension-level scores only within the same rubric version. Note which runs used which rubric version so trend analysis isn't misleading.

Show your work — quote the trail. "Run 3 fixed Muri prescriptive table. Run 4 fixed Muri SCOPE prescriptive table. Run 6 fixed Kaikaku prescriptive table. Pattern: prescriptive artifacts re-emerge in the structure-providing skills." That's a Hansei finding; "Muri had a bug" is not.

### Phase 3: SILENCE — What's NOT There?

This is the hardest phase and the highest-value. Look for absences:

- **Topics never discussed.** What dimensions has no run scored against? What concerns has nobody raised?
- **Findings nobody flagged.** Was there an obvious issue the trail consistently ignored? (Compare against your own fresh reading of the artifact.)
- **Methodologies never tried.** Has every run used Kaizen and never Kaikaku? Or vice versa? Why?
- **Voices never heard.** If the loop is single-model, what would a different model family see? If multi-model but same lineage (all Claude, all GPT), what would a genuinely different family see?
- **Failure modes never tested.** Has the loop ever produced a finding that turned out wrong? Has anything been rolled back? If not — is the loop too easy on itself?

The test for a real Silence finding: when you name it, does it feel obvious in retrospect? If yes, it was a true blind spot. If you have to argue it's important, it probably isn't yet.

### Phase 4: CHALLENGE — Interrogate the Methodology

Apply these questions to the loop itself:

- Is the score moving for the right reasons, or are evaluators learning to score the artifact higher without it actually being better?
- Is convergence real (no more findings exist) or anchoring (evaluators reluctant to score lower than the previous peer)?
- Is the methodology choice load-bearing or ceremonial? If you replaced the named methodology with "just look at it and fix what's bad," would the trajectory actually differ?
- Are the rules being followed, or routed around? Check specific rules against actual run behavior.
- What would a critic outside the system — someone hostile to the framework — say about this loop?

### Phase 5: NAME — Crystallize the Findings

Distill to 1-3 meta-findings. Each finding must:

- Be supported by specific evidence from the trail (cite runs)
- Name a structural property of the loop, not a one-off defect of an artifact
- Suggest a concrete next move (which may be: change methodology, add a missing skill, retire a redundant skill, bring in a new evaluator class, accept the ceiling)

Output format:

```
## Hansei Findings — [Date]

### Finding 1: [crisp name]
- **Evidence:** [runs cited, quotes from trail]
- **What this means:** [structural interpretation]
- **Recommended response:** [concrete next move, or "accept and document"]

### Finding 2: ...

### Finding 3: ...
```

### Phase 6: RECORD — Prepend to the Trail

Hansei is itself part of the trail. **Trail follows the target.** If the target is the skill suite itself, prepend to `~/.copilot/skills/GENBA.md`. If the target is an external project, prepend to `GENBA.md` in the target project's root — create it if it doesn't exist. Each project owns its own improvement history:

```markdown
### Hansei — [date]
- **Scope:** [full history / last N runs / filtered]
- **Model:** [which LLM]
- **Findings:** [N crystallized]
- **Most important finding:** [one sentence]
- **Recommended next move:** [what should the next run do differently?]
- **Loop status:** [healthy / drifting / converged at meta-level / blind to a category]
- **Regression vs prior Hansei:** [better / same / regressed — did prior reflections lose ground?]
```

Then **stop**. Hansei surfaces insight. The user (or the next Kaizen/Kaikaku/Kata invocation) decides what to do with it. Resist the urge to act in the same cycle — the discipline of separating reflection from action is what keeps reflection honest.

## Rules

- **Preserve UTF-8 on bulk edits.** When shell commands rewrite markdown or source code, use explicit UTF-8 encoding. PowerShell default encoding can corrupt arrows, em dashes, and non-ASCII glyphs into mojibake.
- **Hansei requires a trail.** No GENBA.md, no Hansei. Build the trail first.
- **Hansei is meta-Kaizen, not super-Kaizen.** It finds limits of the loop, not defects of the artifact. If you find yourself listing artifact bugs, switch to Kaizen.
- **One reflection per cycle.** Don't conflate reflection with action. Insight first, action separately.
- **Silence is the highest-value phase.** Most reflections only find what's already visible. The discipline is finding what isn't.
- **Cite the trail.** Every finding must reference specific runs. Hansei without citations is opinion.
- **Periodic, not only reactive.** Schedule Hansei every N runs (default 5) even when nothing feels wrong. The blind spots are exactly when nothing feels wrong.
- **Hansei can find that Hansei isn't helping.** If two consecutive Hansei runs surface no actionable findings, the loop is at a **meta-level plateau**. Per Principle 3 (Convergence Is Silence), this is *not* meta-convergence — that requires the same pattern to hold across distinct evaluators with zero artifact changes. Record the plateau, schedule a cross-model Hansei to confirm, and only declare meta-convergence after Principle 3's threshold is met.
- **Don't add a skill on every Hansei.** The temptation will be strong. The bar for adding a new skill is: it fills a structural capability gap, not just a recurring topic.
- **Chronicle in SCORECARD.md.** After reflection, the orchestrator (Kata) should update the high-level `SCORECARD.md` if the Hansei findings represent a major turning point or invalidation.

