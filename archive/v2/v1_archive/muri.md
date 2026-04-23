---
name: muri
version: 1.34.0
description: 'Muri (無理) — Overburden detection and simplification for software projects. Find code, modules, functions, and architecture that are asked to do too much. God objects, deep nesting, high parameter counts, excessive responsibilities, overstretched modules. Overburden causes errors, slows development, and creates waste. Adapted from Toyota Production System. Standalone skill — no dependencies. USE WHEN: too complex, god object, do too much, simplify, decompose, split this, responsibilities, muri, overloaded, overburdened, SRP, single responsibility, this file is too big, too many parameters, spaghetti.'
argument-hint: 'Optional: specify target (module, class, function, file), threshold overrides (max params, max lines, max responsibilities), or focus (structural vs cognitive overburden)'
---

# Muri (無理) — Overburden Detection & Simplification

Find what's asked to do too much. Decompose it.

> **Governing principles:** [Commander's Intent](../PRINCIPLES.md) — this skill teaches you the concept of overburden; how you detect and decompose it is your call. [Observable Autonomy](../PRINCIPLES.md) — show what signals you found and why they indicate overburden; make your decomposition rationale visible.

Muri means "unreasonableness; beyond one's power." In Toyota's system, it's asking a workstation to exceed its capacity. In software, it's a module, class, or function that carries more responsibility than it can sustain cleanly.

**The causal chain:** Mura → **Muri** → Muda. Overburden is often caused by inconsistency upstream (no standard place for X, so everything accumulates in one place) and produces waste downstream (bugs, duplication, abandoned refactoring).

**Muri is not about size alone.** A 500-line file doing one focused thing well is not overburdened. A 200-line file doing 7 unrelated things is. The question is always: how many reasons does this have to change?

**Part of the TPS skill family:** For waste elimination, see **Muda**. For unevenness detection, see **Mura**. For incremental improvement, see **Kaizen**. For radical redesign, see **Kaikaku**. For reflection on the improvement loop itself, see **Hansei**. For novelty probes that test reasoning quality, see **Shiken**. For the full treatment, see **Kata**.

## When to Use

- "this class does too much", "god object", "too complex"
- "muri", "overloaded", "overburdened", "simplify this", "decompose"
- "single responsibility", "split this up", "this file is too big"
- "too many parameters", "deep nesting", "spaghetti"
- When modifying one part of a module requires understanding all other parts
- When new contributors consistently struggle with a specific module
- When bugs cluster in the same files (complexity breeds defects)

## Core Principles

1. **Responsibility, not size.** How many reasons does this have to change? That's the measure of overburden — not line count.
2. **Measure the tax.** What does the overburden cost? Time to understand, risk of breaking unrelated behavior, difficulty of testing in isolation — quantify when you can.
3. **Decompose along natural seams.** Where are the responsibility boundaries that already exist? Look for clusters of methods that collaborate internally but don't interact with other clusters.
4. **Simplify before splitting.** Would fewer parameters, flatter nesting, or clearer control flow solve this without splitting? Splitting an inherently simple thing into 3 files adds Mura and makes things worse.
5. **One level at a time.** Don't go from God object to 20 micromodules. Split into 2-4 focused pieces, verify, then reassess.

## Procedure

### Phase 1: SCOPE — What Are We Examining?

Identify the target. Muri analysis can target different levels:

- **System** — module/package boundaries. Look at how the pieces of the system relate to each other.
- **Module** — files within a module. Look at how concerns are distributed.
- **Class/Object** — a single class or object. Look at method cohesion and state use.
- **Function** — a single function. Look at parameters, control flow, and length against purpose.

The signals that indicate overburden at each level are covered in SCAN — they are not fixed checklists, they depend on the project.

### Phase 2: SCAN — Detect Overburden

Read the target. Ask: **what here is asked to do too much?**

Overburden has two faces. Look for both:

**Structural signals** — things you can measure. What thresholds indicate overburden depends on the project's conventions and language norms, but consider: parameter counts, function length, file length, method counts, nesting depth, import counts, cyclomatic complexity, fan-in/fan-out. Determine what thresholds are appropriate for this specific codebase — don't apply universal numbers blindly. A 60-line function doing one complex algorithm may be fine; a 30-line function mixing HTTP, validation, business logic, and database access is overburdened regardless of length.

**Cognitive signals** — things you can sense. Does the description of what this component does require the word "and" more than once? Do methods on a class reference unrelated state? Does changing one behavior require understanding all other behaviors in the same module? Would a new contributor need to understand the whole thing before safely changing any part? Is there fear around modifying this code?

**Narrate what you find and why it qualifies as overburden.** State which signals you detected, what they tell you about responsibility density, and what the downstream impact is (bugs, confusion, coupling). The reasoning is the proof.

### Phase 3: ASSESS — Severity and Impact

For each overburdened component, assess:

```
## Overburden Assessment

| # | Component | Level | Signals Triggered | Responsibilities | Severity | Impact |
|---|-----------|:-----:|:-----------------:|:----------------:|:--------:|:------:|
| 1 | UserService | Class | 22 methods, 14 imports, mixed abstraction | Auth, Profile, Permissions, Notifications, Billing | Critical | Every user story touches this |
| 2 | process_order() | Function | 8 params, 75 lines, nesting 5 deep | Validate, price, discount, tax, inventory, payment | High | Bug cluster — 4 of last 10 bugs |
| 3 | utils.py | File | 450 lines, 18 functions | String, date, HTTP, file, crypto helpers | Medium | Grab-bag, but stable |
```

**Severity guide:**
How severe is the overburden in each component? Consider: how many signals are triggered, whether structural and cognitive signals coincide, whether bugs cluster here, and how much team velocity is affected. Severity is your judgment — a large component might be Low if it's stable and well-understood, or Critical if it's a recurring source of bugs and requires tribal knowledge to change.

### Phase 4: DECOMPOSE — Plan the Simplification

For each component worth addressing (Critical and High priority), design the decomposition.

**Step 1: Identify responsibilities.** List every distinct concern the component handles. A responsibility is a "reason to change."

**Step 2: Find the seams.** Look for clusters of methods/code that are internally cohesive but loosely coupled to other clusters. These are the natural split points.

**Step 3: Choose the decomposition approach.**

What's the right way to simplify this specific component? The answer depends on what kind of overburden you found:
- If the problem is too many unrelated responsibilities in one place, the answer is probably extraction (separate into focused units).
- If the problem is too many parameters, the answer might be grouping related params into a meaningful concept.
- If the problem is deep nesting or tangled control flow, the answer might be simplification without splitting (guard clauses, early returns).
- If you can't split yet but the interface confuses callers, clarifying the API might be the first step.

What strategy fits this case? Explain your reasoning.

**Step 4: Verify the split is clean.**
- Each new piece should have a clear single responsibility.
- Dependencies should flow in one direction.
- The split should not introduce new Mura (inconsistency with how the rest of the project is structured).
- The total complexity should decrease, not just redistribute.

```
## Decomposition Plan

### Component: [name]
**Current responsibilities:** [list]
**Strategy:** [extract class / extract function / etc.]

**Proposed split:**
| New Component | Responsibility | Takes from original |
|---------------|---------------|:-------------------:|
| AuthService | Authentication, authorization | Methods 1-6, fields: user_repo, token_svc |
| ProfileService | User profile CRUD | Methods 7-12, fields: profile_repo |
| BillingService | Billing, invoicing | Methods 13-18, fields: stripe_client |

**Dependency direction:** AuthService ← ProfileService (profiles need auth check). BillingService independent.
**Risk:** [what could go wrong]
**Verification:** [how to confirm the split works — tests, imports, no circular deps]
```

### Phase 5: ACT — Implement

Execute the decomposition plan one component at a time.

1. **Extract the new component.** Move code to the new location.
2. **Update callers.** Redirect imports and calls.
3. **Run tests.** Verify behavior is unchanged.
4. **Check for new Mura.** Does the extracted component follow the same patterns as existing components in the project?
5. **Measure improvement.** Re-check the overburden signals. Did they improve?

**Simplification discipline:**
- Don't add features during decomposition. Extract behavior as-is, then improve in a separate kaizen cycle.
- Don't over-split. If the extracted component has only one method, it might not need to be separate.
- Don't change interfaces unless the overburden is IN the interface (too many params, mixed concerns in the API).

### Phase 6: REPORT

```
## Muri Report — [Target] — [Date]

### Summary
| Metric | Before | After |
|--------|:------:|:-----:|
| Components assessed | X | — |
| Critical overburden | N | M |
| High overburden | N | M |
| Avg function length (target area) | X lines | Y lines |
| Max parameter count (target area) | X | Y |

### Decompositions
| # | Component | Strategy | Split Into | Signals Resolved |
|---|-----------|----------|:----------:|:----------------:|
| 1 | UserService | Extract class | 3 services | Method count: 22→8, imports: 14→5 |
| 2 | process_order() | Extract function + param object | 4 functions + OrderRequest | Params: 8→2, nesting: 5→2 |

### Deferred
| # | Component | Severity | Reason |
|---|-----------|:--------:|--------|
| 1 | utils.py | Medium | Stable, low bug rate — not worth splitting now |

### Downstream Impact
- [Did reducing Muri reduce any Muda? Note it here]
```

**Trail follows the target.** If the target is the skill suite itself, prepend to `~/.copilot/skills/GENBA.md`. If the target is an external project, prepend to `GENBA.md` in the target project's root — create it if it doesn't exist. Each project owns its own improvement history:

```markdown
### Muri — [date]
- **Target:** [what was decomposed]
- **Model:** [which LLM]
- **Components treated:** [N critical, M high]
- **Strategy:** [extract class / extract function / etc.]
- **Key metric change:** [e.g., "UserService: 22 methods → 8, split into 3 services"]
- **Downstream impact:** [Muda prevented or reduced]
- **Regression vs prior run:** [better / same / regressed — if regressed, what re-accumulated and why?]
```

## Rules

- **Preserve UTF-8 on bulk edits.** When shell commands rewrite markdown or source code, use explicit UTF-8 encoding. PowerShell default encoding can corrupt arrows, em dashes, and non-ASCII glyphs into mojibake.
- **Muri simplifies, it doesn't restructure.** If the overburden is architectural (wrong paradigm, wrong boundaries), that's kaikaku's job. Muri decomposes within the existing architecture.
- **Measure before and after.** Without metrics, you can't prove the overburden was reduced. Re-check signals after every decomposition.
- **Don't split what's merely large.** A 400-line file with one cohesive responsibility is fine. Verify responsibility count before splitting.
- **Trace upstream.** If overburden keeps recurring in the same area, the cause is likely Mura (inconsistency) upstream. A missing standard pushes everything into one catch-all. Note this for a Mura pass.
- **Partial passes are fine.** User can target one function, one class, or one module. Match the user's intent.
- **Simplify before splitting.** Try guard clauses, parameter objects, and flatten-nesting before extracting new components. The simplest fix wins.

