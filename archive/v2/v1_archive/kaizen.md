---
name: kaizen
version: 1.34.0
description: 'Kaizen (改善) — Iterative project improvement cycle — audit, rate, challenge blind spots, prioritize by ROI, research solutions, plan with solve-by-design thinking, implement highest-leverage changes, then re-audit. Includes blind spot analysis (what are we NOT seeing?) and cross-model validation (don''t let the same model grade its own work). Part of the TPS skill family: Muda (waste), Mura (unevenness), Muri (overburden), Kaizen (incremental), Kaikaku (radical), Hansei (reflection), Kata (orchestrator). Repeats until rating ≥ target or audit finds only novelty gaps. USE WHEN: audit, review, rate, improve, make impressive, quality loop, iterate on quality, kaizen, evolve this, what would make this better, compare to state of art, ROI analysis, improvement cycle, blind spots, what am I missing.'
argument-hint: 'Optional: specify target area (architecture, security, performance, etc.), target rating (default 8.5), or specific concern to focus on'
---

# Kaizen (改善) — Iterative Project Improvement

One full improvement cycle: audit → rate → challenge blind spots → prioritize → research → implement → re-audit. The user invokes this repeatedly until satisfied. Each invocation is one turn of the wheel.

> **Governing principles:** [Commander's Intent](../PRINCIPLES.md) — this skill defines the improvement cycle; what you find, how you score, and what you fix is your reasoned judgment. [Observable Autonomy](../PRINCIPLES.md) — show your reasoning at every phase; scores without rationale are worthless, fixes without explanation are untrustworthy.

Inspired by PDCA (Plan-Do-Check-Act), OODA (Observe-Orient-Decide-Act), and pre-mortem analysis. The philosophy: small, high-leverage changes compound into excellence. The key insight: what you're NOT seeing matters more than what you are.

**Part of the TPS skill family:** Kaizen is the incremental improvement methodology. For pure waste elimination, see **Muda**. For unevenness detection, see **Mura**. For overburden reduction, see **Muri**. For radical redesign, see **Kaikaku**. For reflection on the improvement loop itself, see **Hansei**. For novelty probes that test reasoning quality, see **Shiken**. For the full diagnostic + treatment cycle, see **Kata**.

## When to Use

- "audit this", "review and rate this", "is this impressive?", "how can this be better?"
- "kaizen", "improvement cycle", "iterate on quality", "evolve this project"
- "what would make this stand out?", "compare to state of the art"
- Any request to audit, review, rate, or improve a project
- For pure waste elimination ("prune this", "what should I remove?"), use the **Muda** skill instead
- When the user asks you to evaluate ROI of improvements

## Core Principles

These principles govern every phase. They reflect how the user thinks:

1. **Solve by design.** Can the problem be prevented rather than detected? Can the design make the wrong state impossible rather than catching it at runtime?
2. **ROI governs priority.** What change produces the most improvement for the least effort? This determines order — not preference, not interest, not complexity.
3. **Subtract before adding.** Would removing something solve this as effectively as adding something? Is every element here earning its place? Is this the simplest approach that actually works?
4. **Context is everything.** What does this specific project, with its specific constraints, actually need? Don't propose rewrites when a tweak suffices. Don't propose additions when removal suffices.
5. **Compounding.** What did the last cycle find? What improved? What didn't? Each run builds on accumulated evidence — don't re-audit unchanged areas.

## Procedure

### Phase 1: OBSERVE — Deep Audit

Thoroughly understand the project before judging it — what it is, who it's for, what design decisions were made and why. Read broadly, not narrowly.

**Budget rule:** Spend at most ~30% of your available context on OBSERVE. For large projects (50+ files), sample strategically: entry points, the most complex module, one test file, one config file, the README. You can always read more in later phases if a specific finding requires deeper context. Don't try to read everything — understand the architecture, not every line.

**Narrate as you observe.** State what you're reading, what you notice, and what questions emerge. The observation trail is how the human follows your reasoning and knows what you've covered vs. what you haven't.

**For codebases:**

Explore broadly: entry points, core modules, tests, configuration, documentation, build pipeline, security posture. You can always read more in later phases.

As you read, ask:
- What is the architecture here? What are the design decisions and why were they made?
- How does this system handle failure? What about unexpected inputs, adversarial inputs, scale?
- What's the test quality — not coverage numbers, but: are tests testing behavior or implementation? Are edge cases covered?
- Could a new contributor get started from the docs alone?
- Where are the trust boundaries? Is input validated there?
- Does the build work cleanly? Is there CI?
- Is anything here that might not earn its maintenance cost? (Note for CHALLENGE phase — don't judge yet.)

Run the tests if possible. Note failures, warnings, coverage.

**For documents/designs/instructions:** Adapt your observation approach. Instead of code-specific checks, read the entire document and assess: purpose and audience, internal consistency, completeness, gaps, audience fit, edge cases not addressed. The same RATE and CHALLENGE phases apply — use the non-code dimensions when scoring.

### Phase 2: RATE — Structured Scorecard

Score the project on a 1-10 scale across these dimensions. The number matters only if the notes justify it.

| Dimension | What to evaluate |
|-----------|-----------------|
| **Architecture** | How well-separated are concerns? Do dependencies flow in one direction? Would adding a new feature require touching many modules or few? |
| **Code Quality** | Is the code consistent and idiomatic? Can you read a function and understand it without reading 5 others? |
| **Reliability** | How does the system handle failure? What happens when inputs are unexpected? How confident are you that the tests catch regressions? |
| **Security** | Where are the trust boundaries? Is input validated at those boundaries? Are secrets handled properly? What would you attack first? |
| **Documentation** | Could a new contributor start working from the docs alone? Is anything documented that shouldn't be, or undocumented that should be? |
| **Performance** | Is work proportional to input? Are there obvious bottlenecks? Is the right algorithm used for the data size? |
| **Developer Experience** | How long from clone to running tests? How many files to change for a typical feature? What causes friction? |
| **Innovation** | Does anything here make you pause and think "that's a good idea"? What's the unique contribution? |

**Output format:**

```
## Scorecard — [Project Name] — Iteration N

| Dimension      | Score | Notes |
|----------------|:-----:|-------|
| Architecture   |  X/10 | ... |
| Code Quality   |  X/10 | ... |
| Reliability    |  X/10 | ... |
| Security       |  X/10 | ... |
| Documentation  |  X/10 | ... |
| Performance    |  X/10 | ... |
| DX             |  X/10 | ... |
| Innovation     |  X/10 | ... |
| **Overall**    |**X.X**| Weighted average (see weighting guide below) |

### Impressive
- [what stands out, what's genuinely good]

### Could Be More Impressive
- [specific, actionable observations — not vague "could be better"]
```

**Honesty anchor:** Score relative to the best work you've seen in this domain. "Works" is not the same as "impressive." Explain what earned the number.

**Weighting guide:** Default: all dimensions equal weight. Adjust by project type:
- **Libraries/frameworks:** Architecture ×2, Reliability ×2
- **Web apps/APIs:** Security ×2, Reliability ×1.5
- **Research/experimental:** Innovation ×2, Documentation ×1.5
- **CLI tools:** DX ×2, Documentation ×1.5
- **Documents/instructions:** derive dimensions from what this specific target must do well to serve its audience. The code dimensions won't apply — what does? Consider what you observed in Phase 1: what qualities distinguish good work from bad work for *this particular* target? Common document dimensions include clarity, completeness, internal consistency, audience fit, actionability, depth, structure, innovation, and trustworthiness — but these are a reference vocabulary, not a substitution list. Some may not apply; others may be missing (e.g., navigability for a large doc set, factual accuracy for a spec, temporal freshness for evolving content). Weight by what matters most for this target.

Calculate the weighted average. Don't hand-wave — show which weights you used if non-default.

**For non-code targets** (documents, designs, instructions), derive your scoring dimensions from the target itself. Ask: what does *this specific* target need to do well? What did I observe in Phase 1 that reveals its strengths and failure modes? The code dimensions don't transfer — but neither does a generic list. Your OBSERVE findings should drive dimension selection: if you found navigability problems, navigability is a dimension; if you found factual contradictions, factual accuracy is a dimension. Reference dimensions you might consider: clarity, completeness, internal consistency, audience fit, actionability, depth, structure, innovation, trustworthiness — but adapt, add, remove, and weight based on what you actually encountered. The scoring discipline stays the same: be honest, be specific, and show your reasoning.

**Cross-model validation:** Prefer evaluator independence. If multiple models are available, use one model for RATE and CHECK and another for ACT. If the same model must do both, note the limitation explicitly.

### Phase 3: CHALLENGE — Blind Spot Analysis

This is the most important phase. Humans and LLMs share a critical flaw: we evaluate what's in front of us and miss what's absent. After scoring the project, actively invert your thinking.

**Ask these questions explicitly — write the answers out:**

1. **What's absent?** What features, patterns, capabilities, or safeguards should exist but don't? What would a user expect that isn't there? What would a competitor have?

2. **What assumptions are we making?** About the users, the environment, the requirements, the scale, the deployment context. List every assumption, then ask: what if each one is wrong?

3. **What failure modes haven't we considered?** Not bugs in existing code — entire categories of failure. What happens if the network is down? If the input is adversarial? If the project is used in a way the author didn't intend? If it needs to scale 100x?

4. **What would an adversary exploit?** Think like an attacker, a hostile user, a malicious dependency, a competitor doing a tear-down review. Where are the weakest points?

5. **What would change the entire assessment?** What single piece of new information — a requirement, a constraint, a use case — would flip a 7 to a 3? This reveals fragile assumptions.

6. **What am I anchored on?** Am I over-focusing on what's present (well-written code, clean architecture) and under-weighting what's missing (no auth, no monitoring, no graceful degradation)? Presence bias is the default — fight it.

7. **Pre-mortem:** Imagine this project failed in production 6 months from now. What went wrong? Write the post-mortem from the future.

8. **What exists that doesn't earn its maintenance cost?** For each waste signal noted during OBSERVE: who uses it? What breaks if deleted? Does its value exceed its maintenance tax (cognitive load, test surface, attack surface, merge conflicts)? Classify each as Remove, Simplify, Defer, or Keep. For a deep evaluation with the full waste taxonomy, run the **Muda** skill.

**Output format:**

```
## Blind Spot Analysis

### What's Missing
- [concrete absence — not vague]

### Assumptions at Risk  
- [assumption] — breaks if [scenario]

### Unexamined Failure Modes
- [failure mode] — consequence: [what happens]

### Pre-Mortem
> "The project failed because..." [write 2-3 sentences from the future]

### Pruning Candidates
| Item | Classification | Justification |
|------|:--------------:|---------------|
| [specific module/feature/abstraction] | Remove / Simplify / Defer / Keep | [why] |

(For a deep waste audit with the full 8-type taxonomy, run Muda.)

### Score Adjustment
After this analysis, do any dimension scores from Phase 2 need revision?
| Dimension | Before | Revised | Why |
|-----------|:------:|:-------:|-----|
| ...       |   X    |    Y    | [blind spot found or pruning candidate found] |
```

**Specificity test:** Every blind spot finding must reference a SPECIFIC artifact, feature, or scenario from this project. Generic findings like "could have better error handling" or "might need more tests" are not blind spots — they're filler. A real blind spot is: "There's no guidance for what happens when the agent's context window fills up mid-cycle" or "The CHALLENGE questions assume a software project but we just used this on a document." If you can copy-paste a finding into any project's audit and it still reads correctly, it's not specific enough — rewrite it or drop it.

**Empty sections are allowed.** If a CHALLENGE section genuinely has no specific findings, write "None found." Do NOT invent generic content to fill the template. An honest "None found" across multiple sections signals either a mature project or a shallow audit — either way, that's useful information.

**This phase may revise scores downward.** That's the point. A score that survives challenge is trustworthy. A score that drops was inflated by presence bias.

### Phase 4: ORIENT — Prioritize by ROI

Take all findings from Phase 2 (RATE) and Phase 3 (CHALLENGE) and rank them. Blind spot findings often have the highest ROI because they address risks nobody was tracking.

- **List all findings.** Every weakness, gap, and improvement opportunity from the audit AND every blind spot AND every pruning candidate from Phase 3. Pruning candidates classified as "Remove" or "Simplify" become findings alongside add/fix findings.
- **Score each finding** on two axes:
  - **Impact** (1-5): How much does fixing this improve the overall score? Does it unlock other improvements? Does it reduce risk?
  - **Effort** (1-5): How much work? 1 = trivial tweak, 5 = major redesign.
- **Compute ROI** = Impact / Effort. Sort descending.
- **Select the top items.** Pick the 2-5 highest-ROI items that can be done in this cycle. Don't overcommit — it's better to do 2 things well than 5 things poorly.

**Output format:**

```
## Priority Queue — ROI Ranking

| # | Finding | Type | Impact | Effort | ROI | Solve-by-Design? |
|---|---------|:----:|:------:|:------:|:---:|:----------------:|
| 1 | ...     | Prune |   5    |   1    | 5.0 | Yes — removal IS the design |
| 2 | ...     | Fix  |   4    |   2    | 2.0 | No               |
| 3 | ...     | Add  |   3    |   2    | 1.5 | Yes — [how]      |

Selected for this cycle: #1, #2, #3
```

**Finding types:** `Add` (new capability/test/doc), `Fix` (repair existing), `Prune` (remove/simplify existing). Pruning findings are first-class — removing dead code, collapsing unused abstractions, or deleting orphaned tests often has the highest ROI because effort is low (deletion is easy) and impact is high (less to maintain, less to break, less to learn).

The "Solve-by-Design?" column is critical. If a problem can be prevented by design (making wrong states unrepresentable, using type system constraints, choosing a data structure that guarantees invariants), that solution is always preferred over runtime checks or documentation. For pruning findings, removal IS often the solve-by-design: the best way to prevent bugs in dead code is to have no dead code.

### Phase 5: DECIDE — Research & Plan

For each selected item, research and design a solution.

- **Research online.** For each item, search for:
  - State-of-the-art approaches in the relevant language/framework
  - How well-known projects solve the same problem
  - Best practices and common pitfalls
  - Relevant libraries, patterns, or techniques

  Use targeted queries like:
  - "[framework] best practices [specific area]"
  - "[language] [pattern] implementation"
  - "how does [well-known project] handle [specific problem]"

  If web research tools are unavailable, use training knowledge but note the limitation in the output: "Based on training data, not live research."

- **Design the solution.** For each item, produce a plan that is:
  - **Specific** — name the files, functions, and patterns. No hand-waving.
  - **Minimal** — smallest change that achieves the goal. What can you NOT change?
  - **Preventive** — does this prevent the problem class, or just this instance? What design would make the problem impossible to recur?
  - **Reasoned** — explain why this approach over alternatives. What did you consider and reject?

- **Check for interactions.** Will any of the planned changes conflict? Can they share infrastructure? Should they be ordered?

**Output format:**

```
## Plan — Cycle N

### Item 1: [title]
**Problem:** [specific description]
**Research:** [what we found — cite sources]
**Solution:** [concrete plan — files, patterns, approach]
**Solve-by-design:** [how this prevents the problem class]

### Item 2: [title]
...
```

- **Present the plan to the user.** Before implementing, show the complete plan. Wait for approval or adjustments. If the user says "go" or "do it" or doesn't object, proceed.

### Phase 6: ACT — Implement

- **Implement one item at a time.** For each selected item:
  - Make the changes
  - Run tests (if applicable) to verify nothing broke
  - Verify the change achieves its goal
- **Keep changes minimal.** Don't refactor adjacent code. Don't add features beyond the plan. Don't "improve" things that weren't in the priority queue.
- **If something doesn't work**, diagnose and fix — don't skip it. But if it turns out to be much harder than estimated (Effort was wrong), note it and move on to the next item.

### Phase 7: CHECK — Re-Audit

**Evaluator consistency (CHECK):** Re-use the Phase 2 evaluator for CHECK when possible. Keep evaluator and implementer separate when possible; if not, note the limitation.

**De-anchoring rule (cycle 2+):** Do NOT adjust the prior score — re-evaluate from scratch. Re-read the actual artifact. Ask: "If I had never seen the prior score, what would I rate this?" Anchoring to prior ratings is a documented cognitive bias. The prior score is for computing deltas, not for informing the new score.

- **Re-score the affected dimensions.** Don't re-audit everything — only the dimensions that the implemented changes should have improved.
- **Run a mechanical integrity scan on touched files.** Before final scoring, run `verify-suite.ps1` from the skills suite root — it validates encoding integrity, placeholders, cross-references, version alignment, ledger consistency, and writes file-hash snapshots. If the script is unavailable (e.g., non-Windows environment or non-skill-suite target), fall back to a manual text scan for `existing code`, `â€`, `â†`, `Ã` in changed files and ledgers. Treat any hit as a defect unless it is an intentional quoted literal.
- **Show the delta:**

```
## Re-Audit — Post-Cycle N

| Dimension      | Before | After | Delta |
|----------------|:------:|:-----:|:-----:|
| Architecture   |   7    |   8   |  +1   |
| Reliability    |   6    |   7   |  +1   |
| **Overall**    | **6.8**|**7.5**|**+0.7**|
```

- **Evaluate the exit condition:**
  - If Overall ≥ target (default 8.5): **"Target reached. The project scores X.X/10."**
  - If audit shows the project is novel/mature and the only gap is real-world usage: **"The project is novel and well-engineered. What remains is test runs and implementation proof — the code itself is there."**
  - If Phase 1 revealed fundamental brokenness (doesn't build, no working code, wrong problem entirely): **"The project needs foundational work before kaizen is useful. Recommended: [specific foundational fix] first, then invoke kaizen."**
  - If two consecutive cycles show delta of 0 or within ±0.2 with the **same evaluator**: **"Local plateau. Further single-model cycles unlikely to help. Per Principle 3 (Convergence Is Silence) this is *not* convergence — convergence requires 3 consecutive runs by 3 distinct evaluators with the same score and zero artifact changes. Schedule a cross-model run."**
  - If 3 consecutive runs by 3 distinct evaluators have the same score AND made zero artifact changes: **"Converged per Principle 3. The loop has nothing left to add."**
  - Otherwise: **"Current score: X.X. Invoke kaizen again for the next cycle."** List what the next cycle should focus on.

**Trail follows the target.** If the target is the skill suite itself, prepend to `~/.copilot/skills/GENBA.md`. If the target is an external project, prepend to `GENBA.md` in the target project's root — create it if it doesn't exist. Each project owns its own improvement history:

```markdown
### Kaizen — [date]
- **Target:** [what was improved]
- **Model:** [which LLM]
- **Score:** [before] → [after] (+delta)
- **Fixes:** [N items — brief list]
- **Net content:** [positive / negative / zero]
- **Regression vs prior run:** [better / same / regressed — if regressed, what returned and why?]
```

## Rules

- **Preserve UTF-8 on bulk edits.** When shell commands rewrite markdown or source code, use explicit UTF-8 encoding. PowerShell default encoding can corrupt arrows, em dashes, and non-ASCII glyphs into mojibake.
- **One cycle per invocation.** Don't try to loop internally. The user decides when to run the next cycle.
- **Challenge phase is NOT optional.** Phase 3 (CHALLENGE) is where the real value is. Skipping it produces audits that confirm what you already see. The point is to find what you DON'T see.
- **Evaluator independence.** The model that rates (Phase 2) and checks (Phase 7) should ideally differ from the model that implements (Phase 6). If they are the same, say so.
- **ROI trumps preference.** Always do the highest-leverage item first, even if another item is more interesting.
- **Respect existing style.** Match the project's conventions, naming patterns, and structure.
- **Show your work.** The user values transparency. Show the scorecard, the priority queue, the research findings, and the plan before implementing.
- **Prior iterations matter.** If this isn't the first cycle, check for notes from prior cycles (session memory, changelog entries, or conversation context). Build on previous work, don't repeat audits of unchanged areas.
- **The target is configurable.** If the user specifies a target rating, use it. Default is 8.5.
- **Partial cycles are allowed.** If the user only wants an audit ("just rate it"), run Phases 0–3 and stop. If they want a plan but no implementation, stop after Phase 5. Match the user's intent — don't force a full cycle.
- **Know when to hand off.** If waste is the primary finding, suggest **Muda**. If unevenness dominates, suggest **Mura**. If overburden is the issue, suggest **Muri**. If kaizen converges below target, suggest **Kaikaku**. For the full diagnostic cycle, suggest **Kata**. Kaizen is incremental improvement — other tools exist for other problems.

