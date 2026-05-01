# Autonomous Development Skills Suite

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19842994.svg)](https://doi.org/10.5281/zenodo.19842994)

Four skills that give any AI agent a complete improvement loop for any codebase: interpret the prompt, observe the target, find the highest-leverage change, make it, and record the evidence. The loop ran on this repository more than 100 times and restructured the suite twice. It converged when three independent evaluators from distinct model families found nothing left to change. Guided by the [three principles](./PRINCIPLES.md).

## The goal

The skills work on any codebase. This repo is both the workshop and the proof — if the loop can't improve itself, the claim that it improves anything else is empty.

Convergence is the only finish line: three independent evaluators from distinct model families find nothing left to change. The [trail](./.trail/log.md) is the record.

## The four skills

| Skill | What it does |
|---|---|
| **[Intent](./intent/SKILL.md)** | States the agent's interpretation of the ask before work begins. Catches misreading early. Start here. |
| **[Improve](./improve/SKILL.md)** | Examine, decide, change, verify, record. The core autonomous loop. |
| **[Probe](./probe/SKILL.md)** | Builds two similar-looking cases that differ in one material way. If the response does not change, you have evidence of pattern-matching. Measures [Autonomous Reasoning Fidelity (ARF)](./PRINCIPLES.md). |
| **[Trail](./trail/SKILL.md)** | Appends a structured entry to `.trail/log.md` after each session. Each run starts with the full record of prior decisions. |

Each skill is standalone. Install only what you need. Any combination works.

## Quick start

See [INSTALLING.md](./INSTALLING.md) for setup details.

1. Copy `intent/`, `improve/`, `probe/`, `trail/`, and `tools/` into your repo's `.copilot/skills/`.
2. Run an agent on your codebase with the Improve skill. It reads the code, decides what to change, makes the change, and appends a trail entry.
3. Commit. Run again. Each run reads the full trail of prior decisions.
4. When a run finds nothing actionable, count one silence. Repeat with a different model family. Convergence requires three independent silences from distinct model families.

## How it works

The user still sets the direction in the prompt. The agent is autonomous in how it gets there.

Each run starts by reading the full trail of prior decisions. That trail is both evidence and memory. The agent builds on earlier conclusions instead of starting cold. On this repo, that process eventually led it to stop making incremental fixes and propose a full restructure of the suite. Twice.

The reasoning follows a specific sequence, drawn from Toyota Production System (TPS) and military doctrine:

**Intent** — the agent starts with the prompt the user actually wrote. It extracts the goal, constraints, and success condition behind that prompt, states its interpretation and one considered alternative, and lets the user correct drift before work begins.

> [!IMPORTANT]
> **[Commander's Intent](./PRINCIPLES.md), Principle 1** — the user defines the destination in the prompt. The Intent skill makes that direction explicit before the agent acts.

**Observe** — go to where the work is. The agent reads the code, the trail, and the output as they are, and builds its model from that. No assumptions, no summaries.

**Examine** — three TPS lenses applied as thinking tools, not a checklist: **Waste** (what adds no value), **Overburden** (what is carrying too much), **Inconsistency** (where the target contradicts itself).

**Challenge** — the agent explicitly asks what it is not seeing. Is it anchored to the most obvious finding? Is the structure itself wrong, such that no incremental fix will help? This is the step that can trigger a full redesign argument instead of another incremental patch.

**Decide** — pick one: make one high-leverage change, argue for redesign, or declare silence. One answer. Ranked alternatives stated.

**Act** — make the change. State what and why before touching anything. Verify after.

**Reflect** — reread the full trail of prior iterations. Is the loop converging or drifting? What should the next run examine? Each decision records the alternatives considered and why one path won.

> [!IMPORTANT]
> **[Observable Autonomy](./PRINCIPLES.md), Principle 2** — every autonomous step leaves a trail. `.trail/log.md` is the proof: an outside reader can reconstruct, audit, and challenge the reasoning.

## Evidence

This repository is the loop it describes. It was applied to itself more than 100 times until three independent evaluators from distinct model families — Anthropic (Claude Sonnet 4.6), xAI/Grok, Google/Gemini — found nothing left to change. That is the convergence baseline at v3.1.0 (2026-04-24).

> [!IMPORTANT]
> **[Convergence Is Silence](./PRINCIPLES.md), Principle 3** — the model families are named separately because convergence only counts when independent evaluators with different training and failure modes all find nothing left to change.

All runs are recorded in [.trail/log.md](./.trail/log.md). Earlier iterations in `archive/v2/`.

## Reference

**Verify integrity:**
```bash
python verify.py
```

**Append a trail entry:**
```bash
python <skills>/tools/record.py new --slug=my-operation --target=some-repo
python <skills>/tools/record.py summary
```

**Version:** v3.7.3 (2026-05-01) — [CHANGELOG.md](./CHANGELOG.md)  
**Convergence baseline:** v3.1.0 (2026-04-24) — three silence runs, cross-layer coherence check, all in [.trail/log.md](./.trail/log.md).  
**Future direction:** [archive/OBSERVABLE-LOOPS.md](./archive/OBSERVABLE-LOOPS.md) — draft spec for making any Observable Loop portable and verifiable by CI.

## License

MIT (this suite). `PRINCIPLES.md` is CC BY-SA 4.0 from the [autonomous-agent-principles](https://github.com/ntholm86/autonomous-agent-principles) repo.

## Citation

[CITATION.cff](./CITATION.cff) · Zenodo: [10.5281/zenodo.19842994](https://doi.org/10.5281/zenodo.19842994) (v3.2.0) · All versions: [10.5281/zenodo.19732826](https://doi.org/10.5281/zenodo.19732826).
