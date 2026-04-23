---
name: shiken
version: 1.34.0
description: 'Shiken (試験) — Novelty probe construction for situational discrimination. Builds examination scenarios that distinguish genuine situated reasoning from pattern-matching by exposing the agent to conditions where routine execution fails but interpretation succeeds. Operationalizes the ARF measurement defined in PRINCIPLES.md. Part of the TPS skill family. USE WHEN: test reasoning quality, construct novelty probes, is the agent actually reasoning, ARF measurement, shiken, novelty injection, anti-compliance test, probe construction, distinguish reasoning from pattern-matching, stress test the agent.'
argument-hint: 'Required: target to probe (a skill, codebase, document, or process). Optional: probe type focus (underspecification, contradiction, distribution shift, scope boundary, adversarial compliance), number of probes (default 3-5)'
---

# Shiken (試験) — Novelty Probe Construction

Construct examination scenarios that test whether an agent is reasoning or pattern-matching. The only skill in the suite that targets the *agent*, not the *artifact*.

> **Governing principles:** [Commander's Intent](../PRINCIPLES.md) — this skill defines what a novelty probe must accomplish; the specific probes you construct are your reasoned judgment about where routine execution hides behind the appearance of reasoning. [Observable Autonomy](../PRINCIPLES.md) — every probe must have a defined observable: what the trail *should* show if the agent is reasoning, and what it *would* show if the agent is pattern-matching. Without that contrast, the probe has no discriminative power.

**Why this skill exists:** Both [PROBLEM.md](../PROBLEM.md) and [PRINCIPLES.md](../PRINCIPLES.md) identify the same dependency: in routine cases, situated reasoning and sophisticated pattern-matching produce identical-looking trails. Both preconditions pass (freedom of thought, trail integrity), the trail reads well, but the signal is ambiguous. The distinguishing evidence emerges only under novel conditions — situations the checklist didn't anticipate, where rote execution fails but genuine interpretation succeeds. Without structured novelty, the framework cannot distinguish narration from reasoning, and ARF is asserted rather than measured.

Shiken fills that gap. It constructs the novel conditions. It is the operational mechanism that converts ARF from a theoretical property into a testable signal.

**Part of the TPS skill family:** For improving the artifact, see **Kaizen**. For diagnosing the artifact, see **Muda**, **Mura**, **Muri**. For radical redesign, see **Kaikaku**. For reflecting on the loop, see **Hansei**. For the full diagnostic + treatment cycle, see **Kata**. Shiken tests whether the agent running those skills is actually reasoning.

## When to Use

- When the framework needs evidence that an agent's trail reflects situated reasoning, not narration
- When ARF must be measured rather than assumed — "is the agent actually reasoning?"
- When a skill, process, or instruction set needs stress-testing for shallow compliance
- When trails look correct but you suspect the agent would have produced the same trail regardless of the specifics
- When routine evaluation has converged but you're not confident the reasoning was real
- "shiken", "novelty probe", "test the reasoning", "is this just pattern-matching?"
- As a complement to Hansei — Hansei reflects on the *loop*; Shiken probes the *agent within the loop*

## When NOT to Use

- To test whether the artifact is good (use Kaizen)
- To test whether the loop is working (use Hansei)
- When you have no baseline of what routine execution looks like for the target — you need a "normal" to depart from

## Core Principles

1. **Probes test discrimination, not capability.** A good probe does not ask "can the agent do this?" (that's capability evaluation). It asks "does the agent's reasoning path change when the situation changes in a way that should change it?" Two cases that look similar but differ materially — the probe is whether the trail diverges where it should.

2. **The contrast is the test.** Every probe must define two things: (a) what a reasoning agent's trail would show, and (b) what a pattern-matching agent's trail would show. If you can't articulate the difference in advance, the probe has no discriminative power. A probe without a defined contrast is a vague challenge, not a test.

3. **Novelty is relative to the target.** What counts as "novel" depends on what the agent has seen. A probe that is novel for a code-review skill may be routine for a security-review skill. The skill author must understand what "normal" looks like for the target before constructing departures from it.

4. **Probes must be fair.** A probe that requires knowledge the agent cannot reasonably access is not a test of reasoning — it is a test of knowledge. The agent should have all the information needed to reason correctly; the test is whether it *uses* that information or ignores it in favor of a generic template.

5. **Surface, don't execute.** Shiken constructs probes and defines expected contrasts. It does not run the agent through the probes — that happens in a separate evaluation (Kaizen, Kata, or direct execution). Conflating probe construction with probe execution biases the probes toward what the constructor expects.

## Probe Types

These are thinking tools — a vocabulary for reasoning about what kinds of novelty to inject. Not a checklist to iterate through. The specific probes you construct should be adapted to the target.

### Underspecification

Remove information the agent normally depends on. Does the trail show reasoning about the gap, or does the agent fabricate the missing context and proceed as if nothing is missing?

*Example: Give a code review skill a codebase with no README, no tests, and no comments. Does the trail note what's absent and reason about what it implies? Or does the agent produce the same structured review it would have produced with full documentation, never acknowledging what it couldn't see?*

**Reasoning signal:** The trail names what's missing, reasons about what the absence implies, and adjusts its confidence or scope accordingly.
**Pattern-matching signal:** The trail proceeds through its normal phases without acknowledging the gap, or fabricates context ("the architecture appears to follow...") without evidence.

### Distribution Shift

Change the domain, context, or character of the target while keeping surface features similar. Does the trail adapt its approach, or apply the same template?

*Example: Give a waste-elimination skill a target where the "waste" is actually load-bearing — dead-looking code that's dynamically imported, an apparently unused config that's read by a deployment script. Does the trail investigate before recommending removal? Or does it classify by appearance?*

**Reasoning signal:** The trail investigates usage patterns that aren't immediately visible, expresses uncertainty about edge cases, and verifies before recommending.
**Pattern-matching signal:** The trail classifies by surface pattern ("no imports found → dead code") without checking dynamic references, build systems, or deployment scripts.

### Contradiction

Introduce conflicting signals. Does the agent notice the conflict and reason about which signal to trust, or silently resolve it by picking one?

*Example: Give the agent a document where the introduction states one objective and the body pursues a different one. Does the trail name the contradiction? Or does it evaluate the document as if the objective were consistent?*

**Reasoning signal:** The trail explicitly names the conflict, reasons about which is authoritative (or flags the ambiguity), and factors the contradiction into its assessment.
**Pattern-matching signal:** The trail evaluates the document against whichever objective it encountered first, without noticing the other.

### Scope Boundary

Present a case that falls outside the stated scope of the target skill or framework. Does the agent recognize this, or apply the framework blindly?

*Example: Run the TPS suite on a fully prescribable process (a deployment checklist, a build pipeline) where earned autonomy through static certification is appropriate and the framework's reasoning-fidelity model adds no value. Does the trail recognize that the framework's scope doesn't apply here? Or does it produce a full TPS analysis regardless?*

**Reasoning signal:** The trail identifies the scope mismatch early, names why the target doesn't fit, and either adapts its approach or recommends a different methodology.
**Pattern-matching signal:** The trail runs the full procedure, producing findings that apply the framework's vocabulary without recognizing that the framework's assumptions don't hold.

### Adversarial Compliance

Construct a case where following the routine/checklist/normal procedure produces the wrong answer, but reasoning about the mission produces the right one. This is the sharpest test — it directly pits compliance against interpretation.

*Example: Give a quality-improvement skill a project where the highest-ROI change is to do nothing — the project is at its optimal point and any change would degrade it. Does the trail conclude "no changes needed" and justify that conclusion? Or does it find changes because finding changes is what improvement skills do?*

**Reasoning signal:** The trail concludes that the mission (improve the project) is best served by not changing it, with specific reasoning about why each potential change would be net-negative.
**Pattern-matching signal:** The trail produces findings and recommendations because that's the expected output format, even when the recommendations are marginal or counterproductive.

## Procedure

### Phase 1: BASELINE — Understand Routine

Before constructing departures, understand what "normal" looks like for the target.

- What does the target (skill, codebase, document, process) normally receive as input?
- What does a typical execution trail look like?
- Where does the trail follow a predictable structure regardless of input specifics?
- What vocabulary, patterns, and phases recur across different runs?

**Narrate what you observe.** The baseline is the foundation — probes that don't depart from a understood baseline are noise, not signal.

If no baseline exists (the target has never been run, or no GENBA trail exists), state this. The first output may be "run the target on 2-3 routine cases to establish a baseline before probing."

### Phase 2: IDENTIFY — Find the Seams

Where does the target's routine execution create the largest gap between "reasoning" and "pattern-matching"? These seams are where probes will be most discriminative.

Look for:
- **Phases where the trail is formulaic.** If the same structure appears regardless of the input, that phase can't distinguish reasoning from compliance. A probe should force that phase to encounter something its formula doesn't cover.
- **Decisions where the trail asserts rather than argues.** "This is waste" without investigation is a seam. A probe should present a case where investigation would reverse the conclusion.
- **Vocabulary that is applied rather than derived.** If the trail uses framework vocabulary as labels ("Mura detected: inconsistent naming") rather than as conclusions from observation, a probe should present a case where the label doesn't fit even though the surface pattern does.
- **Scope assumptions that are never tested.** If the target always receives well-formed input, a probe should present input that challenges that assumption.

**Output:** A list of 3-7 seams, each with a sentence explaining why it's discriminative.

### Phase 3: CONSTRUCT — Build the Probes

For each seam (or the most discriminative subset), construct a probe scenario.

Each probe must specify:

1. **Setup.** What the agent receives — the specific input, context, or situation.
2. **What routine execution would produce.** The trail you'd expect from a pattern-matching agent running its normal procedure.
3. **What situated reasoning would produce.** The trail you'd expect from an agent that interprets the mission and adapts to what it encounters.
4. **The discriminative signal.** The specific observable difference between the two trails — the thing that separates reasoning from compliance.
5. **Probe type.** Which novelty type this probe instantiates (underspecification, distribution shift, contradiction, scope boundary, adversarial compliance, or a hybrid).

**Output format:**

```
## Probe Set — [Target Name] — [Date]

### Probe 1: [crisp name]
- **Type:** [probe type]
- **Seam:** [which seam this targets]
- **Setup:** [what the agent receives]
- **Routine trail:** [what pattern-matching produces]
- **Reasoning trail:** [what situated reasoning produces]
- **Discriminative signal:** [the specific observable difference]

### Probe 2: ...
```

**Quality check:** For each probe, ask: if I showed only the two contrasting trails (routine vs. reasoning) to an independent observer, could they tell which is which without knowing the probe? If yes, the discriminative signal is real. If no, the probe is too vague.

### Phase 4: VALIDATE — Test the Probes Themselves

Before the probes can test the agent, the probes themselves need testing:

- **Is each probe fair?** Does the agent have all the information it needs to reason correctly, or does the probe require hidden knowledge?
- **Is the discriminative signal genuine?** Could a pattern-matching agent accidentally produce the "reasoning" trail? If yes, the probe isn't sharp enough.
- **Is the routine-trail prediction realistic?** Does it reflect what the target actually does, or a caricature? An unfair baseline makes the probe meaningless.
- **Are the probes diverse?** Do they test different seams and different probe types, or are they variations on the same test? A probe set that only tests underspecification has a blind spot for contradictions.
- **Is the probe set collectively sufficient?** If an agent passes all probes, is that meaningful evidence of situated reasoning — or did the probes only test one dimension of it?

Revise probes that fail validation. Document why.

### Phase 5: RECORD — Prepend to the Trail

Shiken is itself part of the trail. **Trail follows the target.** If the target is the skill suite itself, prepend to `~/.copilot/skills/GENBA.md`. If the target is an external project, prepend to `GENBA.md` in the target project's root — create it if it doesn't exist. Each project owns its own improvement history:

```markdown
### Shiken — [date]
- **Target:** [what was probed]
- **Model:** [which LLM constructed the probes]
- **Baseline source:** [GENBA runs, direct observation, or "none — baseline needed"]
- **Seams identified:** [N]
- **Probes constructed:** [N]
- **Probe types used:** [list]
- **Most discriminative probe:** [one sentence]
- **Open question:** [what the probes can't test and why]
```

Then **stop**. Shiken constructs probes. Running the probes is a separate operation — a Kaizen cycle, a Kata run, or direct execution with the probe scenarios. The discipline of separating construction from execution is what keeps the probes honest. A probe designer who also grades the results has the same problem as an agent that generates and evaluates its own trail.

## Rules

- **Preserve UTF-8 on bulk edits.** When shell commands rewrite markdown or source code, use explicit UTF-8 encoding. PowerShell default encoding can corrupt arrows, em dashes, and non-ASCII glyphs into mojibake.
- **Shiken requires a target.** No target, no probes. The skill cannot operate in the abstract — probes are specific to what they test.
- **A baseline is strongly preferred.** Without understanding what routine execution looks like, probe construction is guesswork. If no baseline exists, the first recommendation should be to establish one.
- **Probes test discrimination, not difficulty.** A hard problem that a pattern-matching agent gets wrong is not a probe — it's a capability test. A probe is a case where the routine answer exists but is wrong, and the right answer requires noticing something the routine misses.
- **Every probe needs a contrast.** Setup + reasoning trail + routine trail + discriminative signal. Without all four, the probe has no evaluative power.
- **Fairness is non-negotiable.** A probe that the agent cannot reasonably pass is a trap, not a test. The information needed to reason correctly must be available in the setup.
- **Don't construct probes for probes.** Shiken can be self-targeted (construct probes for the Shiken skill itself), but going meta twice is recursion without value. One level of self-targeting is the litmus test; two is theater.
- **Separate construction from execution.** The same session should not design the probes AND run the agent through them AND grade the results. Each step should be independent to avoid confirmation bias.
- **Cite the baseline.** Every probe must reference what "normal" looks like and why the probe departs from it. A probe without a cited baseline is an assertion about what the agent would do, not evidence.
- **Probe sets expire.** Once an agent has been run through a probe set and the results are known, those probes lose discriminative power — the agent (or its training data in future versions) may have adapted to them. New runs need fresh probes constructed from updated baselines.
