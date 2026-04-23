---
name: mura
version: 1.34.0
description: 'Mura (斑) — Unevenness detection and leveling for software projects. Find inconsistencies in style, patterns, coverage, error handling, API design, naming, and quality distribution. Unevenness is the root cause of overburden (Muri) and waste (Muda). Adapted from Toyota Production System. Standalone skill — no dependencies. USE WHEN: inconsistent, uneven, mixed styles, naming conventions, standardize, level, harmonize, mura, why does this feel messy, normalize, make consistent, code style, pattern consistency.'
argument-hint: 'Optional: specify focus area (naming, error handling, API style, test coverage, patterns), scope (full project, module, file pair), or reference standard to level against'
---

# Mura (斑) — Unevenness Detection & Leveling

Find where the project contradicts itself. Level it.

> **Governing principles:** [Commander's Intent](../PRINCIPLES.md) — this skill gives you the vocabulary for unevenness; what you find and how you level it is your judgment call. [Observable Autonomy](../PRINCIPLES.md) — show the landscape of inconsistency as you map it; make your leveling rationale visible.

Mura means "unevenness, irregularity, lack of uniformity." In Toyota's system, it's the ROOT CAUSE of the causal chain:

$$\text{Mura (unevenness)} \xrightarrow{\text{causes}} \text{Muri (overburden)} \xrightarrow{\text{causes}} \text{Muda (waste)}$$

Inconsistency forces developers to carry mental models for each variant (overburden), which produces errors, duplication, and abandoned approaches (waste). Fix the unevenness and you often prevent the downstream problems.

**Part of the TPS skill family:** For waste elimination, see **Muda**. For overburden reduction, see **Muri**. For incremental improvement, see **Kaizen**. For radical redesign, see **Kaikaku**. For reflection on the improvement loop itself, see **Hansei**. For novelty probes that test reasoning quality, see **Shiken**. For the full treatment, see **Kata**.

## When to Use

- "this feels inconsistent", "why are there two ways to do this?", "standardize this"
- "mura", "level this", "harmonize", "normalize", "make consistent"
- "naming conventions", "mixed patterns", "code style is all over the place"
- When onboarding is hard because "it depends which module you're in"
- When you can't predict how a new module should be structured because existing modules disagree
- After a project has multiple contributors with different habits

## Core Principles

1. **Consistency over local perfection.** Is the cost of having two approaches higher than the benefit of either? A project where everything uses pattern A is often better than one where half uses superior B and half uses adequate A.
2. **Name the standard, then measure against it.** What is the dominant pattern here? How far does each area deviate from it?
3. **Level toward the majority, not the ideal.** Which direction of change touches fewer files? Changing 3 files to match 30 is cheaper than changing 30 to match 3 — unless the 3 represent a strictly necessary improvement.
4. **Some unevenness is intentional.** Does this variation exist because the situation demands a different approach? Distinguish inconsistency (same job, different approach) from diversity (different job, different approach).
5. **Mura causes Muri causes Muda.** Is this unevenness causing overburden or waste downstream? If yes, the leveling ROI is higher than it appears.
6. **Ask why, not just where.** When the same unevenness spans multiple areas, what's the root cause? Missing convention? Missing tooling? Missing onboarding? Organizational boundary?

## Procedure

### Phase 1: SCOPE — What Are We Leveling?

Identify the target and the dimensions to check.

**Where to look for unevenness:**

The central question: *"If a new contributor has seen one part of this project, can they predict how the next part works?"*

Consider any dimension where inconsistency might hide — naming, error handling, API design, patterns, test style, documentation, coverage distribution, dependency choices, configuration, logging, and anything else that repeats across the codebase. What you check depends on what this project does and where you notice variation.

Some projects will have perfect naming but wildly inconsistent error handling. Others will be the reverse. The goal is to map what ACTUALLY varies — not to mechanically check a fixed list. If you discover a dimension of unevenness not mentioned above, that's a valuable finding.

### Phase 2: SCAN — Map the Variants

For each dimension, map what exists. Don't judge yet — just document the landscape.

**Narrate as you scan.** State what you're examining, what variants you find, and how you're counting. The landscape you're mapping is the foundation for every phase that follows — make it visible.

**For each dimension, identify:**
1. **All variants** — every distinct approach used.
2. **Count** — how many files/modules use each variant.
3. **The dominant pattern** — whichever variant has the most usage.
4. **Outliers** — files/modules that deviate from the dominant pattern.

**Output:**

```
## Unevenness Map

### [Dimension: e.g., Error Handling]

| Variant | Count | Files/Modules | Example |
|---------|:-----:|---------------|---------|
| Result<T, E> return types | 12 | core/, engine/, parser/ | `fn parse() -> Result<Ast, ParseError>` |
| Exception throwing | 4 | api/, legacy/, utils/ | `raise ValueError("bad input")` |
| None/null returns | 2 | cache.py, config.py | `return None  # on miss` |

**Dominant pattern:** Result types (12/18 = 67%)
**Deviation:** 6 files use exceptions or null returns

### [Next dimension...]
...
```

### Phase 3: ASSESS — Intentional vs Accidental

For each deviation from the dominant pattern, determine: is this inconsistency intentional or accidental?

The key question: **does this deviation exist because the situation genuinely demands a different approach, or because it was written by a different person/at a different time/with different habits?**

Intentional variation is appropriate diversity — keep it. Accidental variation is inconsistency — level it. If you're not sure, investigate — and say you're not sure.

**Narrate your reasoning for each classification.** The human (or the next model reviewing this) needs to understand why you judged each deviation as intentional, accidental, or unclear.

**Output:**

```
## Unevenness Assessment

### Intentional (keep)
| Dimension | Deviation | Justification |
|-----------|-----------|---------------|
| Error handling | api/ uses exceptions | Framework boundary — FastAPI expects exceptions |

### Accidental (level)
| Dimension | Deviation | Files | Level toward |
|-----------|-----------|-------|:------------:|
| Error handling | utils/ uses null returns | cache.py, config.py | Result types (dominant) |
| Naming | legacy/ uses camelCase | 4 files | snake_case (dominant, PEP 8) |
| Logging | api/ uses printf-style | 3 files | Structured logging (dominant) |

### Unclear (investigate)
| Dimension | Deviation | Question |
|-----------|-----------|----------|
| Patterns | auth/ uses raw SQL | Performance reason or just different author? |

### Root Cause — 5 Whys (for recurring or widespread unevenness)
When unevenness spans ≥3 modules or ≥2 dimensions, the cause is likely systemic. Trace it:
1. Why is error handling inconsistent? → No project convention documented.
2. Why is there no convention? → The project grew organically with multiple contributors.
3. Why didn't contributors converge? → No linter rule or PR review checklist enforces it.
4. Why no enforcement? → Nobody nominated a standard.
5. **Root cause:** Missing decision — the convention was never explicitly chosen.
**Fix:** Choose the dominant pattern, document it, add a lint rule. Prevents recurrence.
```

### Phase 4: MEASURE — Unevenness Score

Quantify the overall unevenness. This makes progress trackable across cycles.

```
## Unevenness Score

| Dimension | Variants | Dominant % | Deviations | Severity |
|-----------|:--------:|:----------:|:----------:|:--------:|
| Naming | 2 | 85% | 6 files | Low |
| Error handling | 3 | 67% | 6 files | Medium |
| API style | 1 | 100% | 0 | None |
| Patterns | 3 | 55% | 9 files | High |
| Test style | 2 | 75% | 4 files | Low |
| Coverage dist. | — | — | 40% range | High |

**Overall Mura score:** [1-10, where 10 = perfectly uniform, 1 = every module is a snowflake]
```

**Severity guide:**
How severe is the unevenness in each dimension? Consider: how many variants exist, what percentage follows the dominant pattern, and how much confusion or downstream harm the deviation causes. Severity is your judgment — a dimension with 3 variants might be Low severity if the variants are well-understood, or High severity if they cause bugs.

### Phase 5: LEVEL — Plan the Standardization

For each accidental deviation, plan the leveling action.

**Prioritize by:**
1. **Downstream impact** — Does this Mura cause Muri or Muda? If yes, fix it first.
2. **Developer confusion** — Does this trip up new contributors? Higher priority.
3. **Blast radius** — How many files need to change? Smaller changes first to build confidence.

```
## Leveling Plan

| # | Dimension | Action | Files | Risk | Priority |
|---|-----------|--------|:-----:|:----:|:--------:|
| 1 | Error handling | Convert null returns → Result types in cache.py, config.py | 2 | Low | High (causes bugs) |
| 2 | Naming | Rename camelCase → snake_case in legacy/ | 4 | Medium (public API?) | Medium |
| 3 | Logging | Convert printf → structured in api/ | 3 | Low | Low |
```

### Phase 6: ACT — Implement Leveling

Execute the leveling plan. For each item:

1. Make the change — align the deviation toward the dominant pattern.
2. Run tests — verify nothing broke.
3. Check that no NEW unevenness was introduced.

**Leveling discipline:**
- One dimension at a time. Don't mix naming changes with error handling changes.
- Use automated tools where possible: formatters for naming, codemods for pattern migration.
- If leveling one file reveals that the "dominant" pattern is actually worse, stop and reassess. Sometimes the minority is right — but document why.

### Phase 7: REPORT

```
## Mura Report — [Target] — [Date]

### Unevenness Score
| Metric | Before | After |
|--------|:------:|:-----:|
| Mura score | X/10 | Y/10 |
| Dimensions with High severity | N | M |
| Total accidental deviations | N | M |

### Leveling Actions
| # | Dimension | Files Changed | Leveled Toward |
|---|-----------|:-------------:|----------------|
| 1 | Error handling | 2 | Result types |
| 2 | Naming | 4 | snake_case |

### Remaining Unevenness
| Dimension | Status | Reason |
|-----------|:------:|--------|
| Patterns | Deferred | Needs team input on preferred approach |

### Downstream Impact
- [Did leveling reduce any Muri or Muda? Note it here]
```

**Trail follows the target.** If the target is the skill suite itself, prepend to `~/.copilot/skills/GENBA.md`. If the target is an external project, prepend to `GENBA.md` in the target project's root — create it if it doesn't exist. Each project owns its own improvement history:

```markdown
### Mura — [date]
- **Target:** [what was leveled]
- **Model:** [which LLM]
- **Mura score:** [before] → [after]
- **Dimensions leveled:** [which]
- **Downstream impact:** [Muri/Muda prevented or reduced]
- **Regression vs prior run:** [better / same / regressed — if regressed, what re-emerged and why?]
```

## Rules

- **Preserve UTF-8 on bulk edits.** When shell commands rewrite markdown or source code, use explicit UTF-8 encoding. PowerShell default encoding can corrupt arrows, em dashes, and non-ASCII glyphs into mojibake.
- **Mura is about consistency, not correctness.** The goal is to have one way of doing things, even if a "better" way exists in isolation. The cost of inconsistency is often higher than the benefit of local optimization.
- **Level toward the dominant pattern.** Unless there's a compelling reason not to, the cheapest and safest path is to make the outliers match the majority.
- **Document the standard.** Once leveled, the dominant pattern becomes the official standard. If it's not already documented, add it to the project's conventions.
- **Some unevenness is intentional.** Not all variation is accidental. If a deviation exists for a good reason (e.g., a performance-critical path using a different pattern), document it as an intentional exception, don't "level" it.

