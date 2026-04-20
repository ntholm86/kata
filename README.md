# TPS Skill Suite

A set of skills for autonomous improvement work. Each skill is a self-contained instruction file that an AI agent (or human) loads when the situation calls for it.

## Skills

| Skill | Purpose |
|-------|---------|
| **[kata](kata/SKILL.md)** | Orchestrate an improvement cycle: diagnose, select methodology, execute, record, persist |
| **[kaizen](kaizen/SKILL.md)** | Incremental improvement — diagnose with unevenness/overburden/waste lenses, prioritize, fix, verify |
| **[kaikaku](kaikaku/SKILL.md)** | Radical redesign — when incremental improvement has converged too low or the architecture is wrong |
| **[hansei](hansei/SKILL.md)** | Reflect on the improvement loop itself — surface blind spots, recurring findings, methodology gaps |
| **[shiken](shiken/SKILL.md)** | Construct novelty probes that distinguish genuine reasoning from pattern-matching |
| **[kiroku](kiroku/SKILL.md)** | Evidence trail management — start sessions, record decisions, close sessions, validate trail integrity |

## Principles

Everything derives from three principles in [PRINCIPLES.md](PRINCIPLES.md):

1. **Commander's Intent** — State the desired end-state, not the steps to get there
2. **Observable Autonomy** — Autonomy without evidence is abdication; the trail earns trust
3. **Convergence Is Silence** — When distinct evaluators independently agree, stop

## Structure

```
skills/
  kata/SKILL.md           # Improvement cycle orchestrator
  kaizen/SKILL.md         # Incremental improvement
  kaikaku/SKILL.md        # Radical redesign
  hansei/SKILL.md         # Loop reflection
  shiken/SKILL.md         # Novelty probes
  kiroku/SKILL.md         # Evidence trail management
  kiroku/*.ps1            # Trail lifecycle scripts
  PRINCIPLES.md           # Constitutional layer
  PROBLEM.md              # What the suite solves
  STANDARDS.md            # External framework alignment (PDCA, DMAIC, CMMI, NIST)
  SCORECARD.md            # Cross-model evaluation trajectory
  CHANGELOG.md            # Release history
  verify-suite.ps1        # Mechanical integrity checks (14 checks)
  metrics.ps1             # Computable objective metrics
  TRAIL/                  # Evidence trail for the suite itself
  v1_archive/             # Historical v1 skill files and rebuild documents
```

## Getting Started

1. Read [PRINCIPLES.md](PRINCIPLES.md) — everything else derives from these
2. Read [kata/SKILL.md](kata/SKILL.md) — it orchestrates the others
3. Point Kata at a target and run the cycle
