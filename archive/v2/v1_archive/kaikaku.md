---
name: kaikaku
version: 1.34.0
description: 'Kaikaku (改革) — Radical redesign evaluation. When incremental improvement (kaizen) has converged or the architecture is fundamentally wrong, kaikaku asks: should we throw this away and rebuild? Evaluates whether the current system can reach the target through incremental changes or needs structural replacement. Produces a migration plan if redesign is warranted. USE WHEN: redesign, start over, rethink, rewrite this, architecture is wrong, kaizen isn''t working, converged too low, fundamental change, kaikaku, radical change, clean slate, rearchitect, pivot.'
argument-hint: 'Optional: specify what feels wrong (architecture, data model, paradigm), target state if known, or constraints on the redesign (budget, timeline, backwards compatibility)'
---

# Kaikaku (改革) — Radical Redesign

When incremental improvement can't reach the target, ask whether the foundation itself needs replacing.

> **Governing principles:** [Commander's Intent](../PRINCIPLES.md) — this skill defines when radical change is warranted and what a migration plan must contain; how you diagnose, envision, and execute is your reasoned judgment. [Observable Autonomy](../PRINCIPLES.md) — the diagnosis, evidence, and migration plan must be fully visible to the human before any execution begins.

Kaikaku means "radical change." In Toyota's system, it's triggered when kaizen converges at an unsatisfying level — the machine is optimized, but it's the wrong machine.

**Kaikaku is NOT bigger kaizen.** It's a different mindset:
- Kaizen asks: "How do we improve what we have?"
- Kaikaku asks: "Should we have something else entirely?"

Kaizen preserves. Kaikaku replaces. They complement each other — kaikaku creates a new baseline, then kaizen optimizes from there.

**Part of the TPS skill family:** For incremental improvement, see **Kaizen**. For waste elimination, see **Muda**. For unevenness detection, see **Mura**. For overburden reduction, see **Muri**. For reflection on the improvement loop itself, see **Hansei**. For novelty probes that test reasoning quality, see **Shiken**. For the full diagnostic + treatment cycle, see **Kata**.

## When to Use

- "this architecture is fundamentally wrong", "should I rewrite this?"
- "kaikaku", "radical change", "clean slate", "rearchitect", "start over"
- "kaizen converged at X but I need Y", "incremental changes aren't enough"
- When kaizen runs show diminishing returns (≤ +0.2 per cycle) but score is below target
- After a major pivot — the business changed but the code didn't
- When you feel you're polishing something that shouldn't exist in its current form

## Core Principles

1. **Prove the need.** Kaikaku is expensive. What specific evidence makes you believe incremental improvement can't reach the target?
2. **Name the ceiling.** What structural limitation prevents kaizen from breaking through? If you can't articulate it in one sentence, you may not need kaikaku — you may need more (or different) kaizen.
3. **Respect what works.** What knowledge, logic, tests, and domain expertise from the current system carries forward? Kaikaku replaces architecture, not understanding.
4. **Plan the migration.** How do you get from here to there without stopping the world? A redesign without a migration path is a fantasy.
5. **One kaikaku at a time.** Redesigning multiple systems simultaneously is Muri. What's the single highest-leverage structural change?

## Procedure

### Phase 1: DIAGNOSE — Is Kaikaku Warranted?

This is the critical gate. Most "I need a rewrite" impulses are wrong. Rigorously evaluate before proceeding.

**Narrate your diagnosis.** Walk through each evidence category, state what you found (or didn't find), and explain why it matters (or doesn't). The human needs to follow your reasoning to trust the verdict.

**Evidence to look for — you need to find compelling evidence across multiple signals to proceed:**

Consider these categories, but determine for yourself which ones apply and how strongly they indicate a structural problem:

- **Kaizen convergence** — Are improvement cycles producing diminishing returns? Is the score plateauing below the target?
- **Structural ceiling** — Is there a specific capability the architecture fundamentally cannot support? What would have to change to support it?
- **Accidental complexity** — Is more code managing complexity than delivering value? Do shims, adapters, and workarounds outnumber core logic?
- **Business misalignment** — Was the system designed for requirements that no longer apply? Has the domain pivoted?
- **Performance wall** — Have optimization attempts hit diminishing returns due to architectural constraints?
- **Ecosystem obsolescence** — Are core dependencies unmaintained or incompatible with modern tooling?
- **Knowledge rot** — Does anyone understand why parts of the system exist? Has tribal knowledge left?

Weigh the evidence. How many signals are present? How strong is each one? Document your reasoning — the human needs to see why you believe kaikaku is warranted (or not).

**If the evidence is insufficient in your judgment:** Stop. Return to kaizen. The system likely doesn't need a rewrite — it needs more (or different) incremental improvement. Suggest which kaizen focus area might break through the perceived ceiling.

### Phase 2: ENVISION — Design the Target State

If Phase 1 approved kaikaku, design what the replacement looks like. This is clean-slate thinking — unconstrained by the current implementation.

1. **State the requirements.** What must the new system do? Pull from: current functionality (minus waste — run Muda first if not already done), unmet requirements that triggered kaikaku, and foreseeable future needs (next 1-2 years, not 5).

2. **Choose the paradigm.** What fundamental approach fits the requirements?
   - Architecture style: monolith, microservices, serverless, event-driven, ECS, pipes-and-filters
   - Data model: relational, document, graph, event-sourced, CQRS
   - Concurrency model: sync, async, actor, CSP, data-parallel
   - Language/runtime: same or different? Does the current stack limit the target state?

3. **Design the structure.** High-level boxes-and-arrows. Module boundaries, data flow, API contracts. Not implementation details — architecture.

4. **Validate against the ceiling.** Does this design specifically eliminate the structural limitation identified in Phase 1? If it doesn't, the redesign is misdirected.

5. **Identify what carries forward.** Business logic, domain models, test scenarios, deployment infrastructure, monitoring. These are assets, not waste.

**Output:**

```
## Target State Design

### Requirements
- [must-have requirement from current system]
- [unmet requirement that triggered kaikaku]
- [foreseeable need]

### Paradigm Choices
| Aspect | Current | Target | Why |
|--------|---------|--------|-----|
| Architecture | [current] | [target] | [solves ceiling because...] |
| Data model | [current] | [target] | [enables...] |
| Concurrency | [current] | [target] | [removes bottleneck...] |

### Structure
[high-level architecture description or diagram]

### Ceiling Resolution
[How this design specifically eliminates the structural limitation]

### Carried Forward
- [asset 1: business logic in X]
- [asset 2: test scenarios in Y]
- [asset 3: domain expertise in Z]
```

### Phase 3: PLAN — Migration Path

A redesign without a migration path is a fantasy. Plan how to get from current state to target state without stopping the world.

**Migration strategies (pick one or combine):**

| Strategy | When to use |
|----------|-------------|
| **Strangler Fig** | Can wrap old system in new API. Replace piece by piece. |
| **Parallel Run** | New system can run alongside old. Switch traffic gradually. |
| **Big Bang** | Small system, good test coverage, clear requirements. |
| **Branch by Abstraction** | Can introduce abstraction layer, then swap implementation behind it. |

**For each phase of migration:**

```
## Migration Plan

### Strategy: [chosen strategy]
### Rationale: [why this strategy fits]

#### Phase 1: [name]
- **What changes:** [specific modules/systems]
- **What stays:** [everything else]
- **Verification:** [how we know this phase succeeded]
- **Rollback:** [how we undo this phase if it fails]
- **Duration estimate:** [relative: small/medium/large]

#### Phase 2: [name]
...

### Risks
| Risk | Likelihood | Impact | Mitigation |
|------|:----------:|:------:|------------|
| [specific risk] | H/M/L | H/M/L | [how to prevent or respond] |

### Success Criteria
- [measurable outcome 1]
- [measurable outcome 2]
- The ceiling named in Phase 1 is eliminated
```

### Phase 4: VALIDATE — Stress-Test the Plan

Before executing, challenge the kaikaku plan itself.

1. **Second-system effect check.** Are we adding complexity the current system doesn't have because "we're redesigning anyway"? Strip the target state to ONLY what's needed to break the ceiling + carry forward current capabilities.

2. **Scope creep check.** Is the migration plan growing beyond the structural change? Kaikaku replaces architecture, not features. New features wait for kaizen on the new baseline.

3. **Reversibility check.** For each migration phase, can we roll back? If any phase is irreversible, it needs extra scrutiny and higher test coverage.

4. **Cost/benefit.** Is the expected improvement (breaking the ceiling) worth the migration cost? Be honest. Sometimes the answer is "live with the ceiling."

5. **Present to user.** Show the full diagnosis, target state, and migration plan. Get explicit approval before proceeding. Kaikaku is high-stakes — never auto-execute.

### Phase 5: EXECUTE — Implement the Migration

Execute the migration plan phase by phase. After each phase:

1. Run all tests (existing + new).
2. Verify the phase's success criteria.
3. Confirm rollback is still possible before proceeding.
4. Report progress.

**After migration completes:**
- Verify the ceiling is eliminated.
- Run Muda on the old system's residue — migration often leaves scaffolding.
- Establish the new baseline score (run kaizen Phases 1-3).
- Resume kaizen from the new baseline.

### Phase 6: REPORT

```
## Kaikaku Report — [Project] — [Date]

### The Ceiling
[What couldn't be achieved incrementally]

### Evidence (Phase 1)
[Summary of signals that warranted kaikaku]

### What Changed
| Aspect | Before | After |
|--------|--------|-------|
| Architecture | [old] | [new] |
| [other aspects] | ... | ... |

### Migration
- Strategy: [which]
- Phases completed: [N/M]
- Rollbacks needed: [any?]

### Outcome
- Ceiling eliminated: [yes/no]
- Baseline score (new): [X.X via kaizen audit]
- Kaizen can now target: [what incremental improvements are newly possible]
```

**Trail follows the target.** If the target is the skill suite itself, prepend to `~/.copilot/skills/GENBA.md`. If the target is an external project, prepend to `GENBA.md` in the target project's root — create it if it doesn't exist. Each project owns its own improvement history:

```markdown
### Kaikaku — [date]
- **Target:** [what was redesigned]
- **Model:** [which LLM]
- **Ceiling:** [the structural limitation]
- **Strategy:** [strangler fig / parallel run / big bang / branch by abstraction]
- **Outcome:** [ceiling eliminated / partially resolved / abandoned]
- **New baseline:** [kaizen score on new architecture]
- **Regression vs prior run:** [better / same / regressed — if regressed, what failed and why?]
```

## Rules

- **Preserve UTF-8 on bulk edits.** When shell commands rewrite markdown or source code, use explicit UTF-8 encoding. PowerShell default encoding can corrupt arrows, em dashes, and non-ASCII glyphs into mojibake.
- **Never skip Phase 1.** The diagnosis gate exists because most rewrites are unnecessary. Prove the need.
- **Kaikaku is not an escape from kaizen.** It's triggered BY kaizen convergence. If you haven't run kaizen, run kaizen first.
- **One structural change at a time.** Redesigning the data model AND the concurrency model AND the deployment architecture simultaneously is Muri. Sequence them.
- **The user decides.** Always present the diagnosis and plan before executing. Kaikaku is a high-stakes decision — never auto-proceed.
- **Run Muda first.** Before redesigning, eliminate waste. A system that looks like it needs kaikaku might just need aggressive pruning. Muda is cheaper — try it first.
- **New baseline, then kaizen.** After kaikaku, immediately establish a new kaizen baseline. The redesigned system has its own improvement trajectory.
- **Chronicle in SCORECARD.md.** After the run, the orchestrator (Kata) should update the high-level `SCORECARD.md` with the final outcome.

