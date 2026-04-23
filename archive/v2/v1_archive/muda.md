---
name: muda
version: 1.34.0
description: 'Muda (無駄) — Waste elimination for software projects. Systematically find and remove what does not earn its maintenance cost. Adapted from Toyota Production System''s 7+1 waste types for codebases, documents, and designs. Standalone skill — no dependencies. USE WHEN: prune, simplify, what should I remove, reduce complexity, eliminate waste, dead code, unused, clean up, slim down, muda, declutter, lighten, trim, what here is unnecessary.'
argument-hint: 'Optional: specify target (codebase, file, module, doc), focus area (deps, abstractions, tests, docs), or severity threshold (type-I only, type-II only, all)'
---

# Muda (無駄) — Waste Elimination

Find what doesn't earn its keep. Remove it. Prove each removal.

> **Governing principles:** [Commander's Intent](../PRINCIPLES.md) — this skill gives you the thinking framework; you decide what to find and how to act on it. [Observable Autonomy](../PRINCIPLES.md) — narrate your reasoning as you work; every finding must show the *why*, not just the *what*.

Muda is one of three deviations in the Toyota Production System (alongside Mura and Muri). Taiichi Ohno identified 7 forms of waste; an 8th (unused talent) was added later. This skill provides the vocabulary — you provide the judgment.

**The causal chain:** Mura → Muri → Muda. Waste is often the symptom, not the root cause. For root-cause analysis, see Mura and Muri.

**Part of the TPS skill family:** For unevenness detection, see **Mura**. For overburden reduction, see **Muri**. For incremental improvement, see **Kaizen**. For radical redesign, see **Kaikaku**. For reflection on the improvement loop itself, see **Hansei**. For novelty probes that test reasoning quality, see **Shiken**. For the full treatment, see **Kata**.

**Two types of waste (Shigeo Shingo):**
- **Type I:** Non-value-adding but currently necessary. Can't be removed yet — flag, minimize, and set a revisit condition.
- **Type II:** Non-value-adding and unnecessary. Remove — after proving it's safe.

## When to Use

- "prune this", "what should I remove?", "slim this down", "clean up"
- "muda", "eliminate waste", "reduce complexity", "declutter"
- "dead code", "unused dependencies", "what here is unnecessary?"
- Any request to simplify, trim, or lighten a project
- When kaizen converges but the project still feels heavy
- After a pivot, reorg, or major direction change — to clear residue from the old direction

## Core Principles

1. **Every line has a maintenance tax.** What is that tax here? Consider: cognitive load, test surface, attack surface, merge conflict potential, onboarding friction. Does the value exceed it?
2. **Deletion is a feature.** What improves if this disappears? Quantify when you can.
3. **Challenge existence, not quality.** Don't ask "is this well-written?" Ask "should this exist at all?" Well-engineered waste is still waste — and harder to spot because it looks legitimate.
4. **Prove before removing.** How do you know nothing depends on this? Show your evidence.
5. **Respect uncertainty.** If you can't determine whether something is waste, say so explicitly. Flag it as Type I. Intellectual honesty about what you don't know is a feature, not a weakness.

## Procedure

### Phase 1: SCOPE — What Are We Pruning?

Identify the target and its boundaries.

**Target types:**
- **Full codebase** — scan everything: source, tests, config, deps, docs, CI.
- **Module/directory** — focused prune on a specific subsystem.
- **Single file** — line-by-line waste audit.
- **Dependencies** — dependency tree only (package.json, pyproject.toml, Cargo.toml, etc.).
- **Documentation** — remove stale docs, outdated guides, orphaned references.
- **Test suite** — find tests that test nothing, test removed behavior, or duplicate coverage.

Note what you're pruning and what's out of scope. Scope creep in a pruning pass is ironic.

### Phase 2: SCAN — Think Through Ohno's 8 Lenses

Read the target carefully. Use these eight lenses — each poses a question about a different form of waste. The lenses are your thinking framework, not a checklist to iterate mechanically. How deeply you explore each one, and what you find, depends on this specific target.

| Lens | The Question |
|------|-------------|
| **Overproduction** (過剰生産) | What here was built ahead of demand? What exists because someone imagined a future need rather than responding to a present one? |
| **Waiting** (待ち) | Where does the system — or the developer — wait when it doesn't have to? Where is time lost between value-adding steps? |
| **Transport** (運搬) | Where does data move unnecessarily? Where is it copied, serialized, or reformatted when a simpler path exists? |
| **Over-processing** (加工過剰) | Where is more work done than the result requires? What abstraction, validation, or ceremony goes beyond what the situation actually demands? |
| **Inventory** (在庫) | What's sitting around unfinished, unused, or unintegrated? What was started but never completed — or completed but never cleaned up? |
| **Motion** (動作) | Where are developers forced into unnecessary movement — long navigation paths, scattered configs, context switches, mental translation between inconsistent patterns? |
| **Defects** (欠陥) | What work exists only to manage problems that may no longer exist? What workarounds have outlived the bugs they were built for? |
| **Unused Talent** (未使用の才能) | What capabilities does the language, framework, or platform already offer that this project ignores or reimplements by hand? |

**How you apply each lens is up to you.** Some lenses will reveal nothing for this target. Others will reveal clusters. Follow what you find — don't force every lens to produce output.

**Narrate as you scan.** For each finding, explain what you found and why you believe it qualifies as waste. The reasoning is as important as the conclusion — it's what makes your work auditable and trustworthy.

### Phase 3: CLASSIFY — Type I or Type II

For each waste instance found, classify:

```
## Waste Inventory

### Type II — Remove (non-value, unnecessary)
| # | Waste Type | Location | Description | Confidence |
|---|:----------:|----------|-------------|:----------:|
| 1 | Inventory  | src/old_api.py | Module with 0 imports after v2 migration | High |
| 2 | Over-processing | src/core/factory.py | AbstractWidgetFactory builds only ConcreteWidget | High |
| 3 | Overproduction | tests/test_edge.py:45-80 | Tests scenarios that violate type constraints | Medium |

### Type I — Flag (non-value, but currently necessary)
| # | Waste Type | Location | Description | Revisit When |
|---|:----------:|----------|-------------|:------------:|
| 1 | Defects    | src/compat.py | Workaround for dep v2.3 bug | dep releases v2.4 |
| 2 | Transport  | src/api/mapper.py | DTO→Entity mapping | after API v3 unifies models |

### Challenged & Kept
| # | Location | Why it looked like waste | Why it stays |
|---|----------|------------------------|--------------|
| 1 | src/plugin_loader.py | Plugin system with 1 plugin | 3 community plugins in development |
```

**Confidence levels:**
- **High:** Verified — no callers, no imports, no references. Safe to remove.
- **Medium:** Likely unused but couldn't fully verify (e.g., dynamically referenced, used in deployment scripts not in repo).
- **Low:** Suspicious but unclear. Needs human input.

**Verification methods:**
- Search for all references (imports, calls, config references).
- Check git blame: when was it last meaningfully changed? (Not formatting — meaningful logic changes.)
- Check test coverage: is anything testing this? If yes, are those tests also waste?
- Check deployment: is this used in production configs, scripts, or infra not visible in the repo?

### Phase 4: PRIORITIZE — ROI of Removal

Rank Type II findings by removal value. For each item, consider:
- **How much maintenance does this cost?** Lines, cognitive load, test surface, coupling.
- **How much simpler does the system become if it's gone?** Removing a 10-line function matters less than removing a 10-line abstraction layer that 20 files work around.
- **What's the risk if we're wrong?** Can it be reversed easily?

Use your judgment to rank by return on removal effort. The highest-value removals are usually: high maintenance cost, low risk, and the system simplifies meaningfully when they're gone.

### Phase 5: ACT — Remove

For each approved item, execute the removal:

1. **Delete the code/file/dependency.**
2. **Delete orphaned tests.** Tests that only test the removed code.
3. **Delete orphaned docs.** Documentation that only describes the removed code.
4. **Update references.** Imports, configs, indexes, table of contents.
5. **Run tests.** Verify nothing broke. If something breaks, it wasn't waste — revert and reclassify.
6. **Run the build.** Verify it still compiles/packages.

**Removal discipline:**
- Remove one item at a time. Verify after each.
- If a removal causes a cascade of failures, stop and assess: either the classification was wrong, or there's hidden coupling that's itself a finding worth noting.
- Never remove and add in the same pass. Muda is purely subtractive. If removal reveals something that needs adding, note it for a kaizen cycle.

### Phase 6: REPORT — Waste Ledger

Summarize what was done. This is the proof trail.

```
## Muda Report — [Target] — [Date]

### Summary
| Metric | Value |
|--------|:-----:|
| Lines scanned | X |
| Type II items found | X |
| Type I items flagged | X |
| Items challenged & kept | X |
| Lines removed | X |
| Files removed | X |
| Dependencies removed | X |
| Tests still passing | X/X |

### Removals
| # | What | Lines | Type | Confidence |
|---|------|:-----:|:----:|:----------:|
| 1 | old_api.py | 280 | Inventory | High |
| 2 | test_old_api.py | 60 | Inventory | High |
| 3 | AbstractWidgetFactory | 85 | Over-processing | High |

### Flagged for Revisit (Type I)
| # | What | Revisit When |
|---|------|:------------:|
| 1 | compat.py | dep v2.4 release |

### Not Waste (Challenged & Kept)
| # | What | Justification |
|---|------|---------------|
| 1 | plugin_loader.py | Community plugins in active development |
```

**Trail follows the target.** If the target is the skill suite itself, prepend to `~/.copilot/skills/GENBA.md`. If the target is an external project, prepend to `GENBA.md` in the target project's root — create it if it doesn't exist. Each project owns its own improvement history:

```markdown
### Muda — [date]
- **Target:** [what was pruned]
- **Model:** [which LLM]
- **Removed:** [X lines, Y files, Z deps]
- **Flagged:** [N Type I items for revisit]
- **Tests:** [pass/fail count unchanged]
- **Regression vs prior run:** [better / same / regressed — if regressed, what returned and why?]
```

## Rules

- **Preserve UTF-8 on bulk edits.** When shell commands rewrite markdown or source code, use explicit UTF-8 encoding. PowerShell default encoding can corrupt arrows, em dashes, and non-ASCII glyphs into mojibake.
- **Muda is subtractive only.** Never add code, features, or abstractions in a muda pass. If you find something to add, note it for kaizen.
- **Prove it's waste before removing.** "Looks unused" is not sufficient. Verify: no callers, no imports, no config references, no dynamic loading.
- **When in doubt, Type I.** If you can't prove it's unnecessary, flag it and move on. False positives (deleting something needed) are worse than false negatives (keeping something unnecessary).
- **Respect the blast radius.** Start with isolated, high-confidence removals. Build trust before tackling coupled items.
- **Don't refactor.** Muda removes, it doesn't reshape. Refactoring is kaizen's job. If removal creates an opportunity to simplify what remains, note it — don't do it now.
- **Partial passes are fine.** User can scope to one waste type ("just check dependencies"), one directory, or one confidence level ("only high-confidence items"). Match the user's intent.
- **Track what you keep and why.** The "Challenged & Kept" section is as valuable as the removals. It's proof that remaining code was examined and justified — not just inherited.

