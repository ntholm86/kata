# Skills

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19842994.svg)](https://doi.org/10.5281/zenodo.19842994)

Four markdown files an AI agent reads at the start of a session. Drop them into any repo and your agent gets structured intent, autonomous improvement, reasoning verification, and a persistent audit trail.

## The four skills

| Skill | What it does |
|---|---|
| **[Intent](./intent/SKILL.md)** | Surfaces the agent's interpretation of the ask *before* any work begins. Catches misreading at the cheapest moment. Start here. |
| **[Improve](./improve/SKILL.md)** | Examine, decide, change, verify, record — or argue convincingly that nothing should change. The core autonomous loop. |
| **[Probe](./probe/SKILL.md)** | Constructs two cases that look similar but differ materially. If the agent's response doesn't diverge where it should, you have evidence of pattern-matching, not reasoning. |
| **[Trail](./trail/SKILL.md)** | Appends a structured entry to `trail/log.md` after every session. Knowledge accumulates; each run reads all prior decisions before acting. |

Each skill is standalone. Install only what you need. Any combination works.

## Quick start

See [INSTALLING.md](./INSTALLING.md) for setup details.

1. Copy `intent/`, `improve/`, `probe/`, and `trail/` into your repo's `.copilot/skills/`.
2. Run an agent on your codebase with the Improve skill — it reads the code, decides what to change, makes it, appends a trail entry.
3. Commit. Run again. Each run reads the full trail of prior decisions.
4. When a run finds nothing actionable, that's one silence vote. Repeat with a different model family. Three independent silences from distinct model families = convergence.

## How it works

No code to run, no orchestrator, no scoring rubric. The skills define the shape; the agent does the reasoning. The trail is the proof.

Trail entries accumulate in `trail/log.md`. Each run reads the full history before acting — this accumulated reflection is what surfaced the need for structural change rather than incremental fixes. Over 100+ runs on this repo, the loop refactored itself twice.

## The three principles

Every iteration runs under three constraints, from the [autonomous-agent-principles](https://github.com/ntholm86/autonomous-agent-principles) governance framework:

1. **Commander's Intent** — define the destination, never prescribe the route. Agents reason about goals; they don't execute checklists.
2. **Observable Autonomy** — every autonomous step produces a continuous trail. If you can't see it, it shouldn't be doing it.
3. **Convergence Is Silence** — convergence requires silence from evaluators that don't share the same training, reasoning patterns, or failure modes. One model's silence is not convergence.

Full statement: [PRINCIPLES.md](./PRINCIPLES.md).

## Evidence

This repository is the loop it describes. Applied to itself, 100+ times, until three independent evaluators from distinct model families — Anthropic (Claude Sonnet 4.6), xAI/Grok, Google/Gemini — found nothing left to change. That is the convergence baseline at v3.1.0 (2026-04-24).

All runs are recorded in [trail/log.md](./trail/log.md). Earlier iterations in `archive/v2/`.

## Reference

**Verify integrity:**
```bash
python tools/verify.py
```

**Append a trail entry:**
```bash
python tools/record.py new --slug=my-operation --target=some-repo
python tools/record.py summary
```

**Version:** v3.6.0 (2026-04-30) — [CHANGELOG.md](./CHANGELOG.md)  
**Convergence baseline:** v3.1.0 (2026-04-24) — three silence runs, cross-layer coherence check, all in [trail/log.md](./trail/log.md).  
**Future direction:** [archive/OBSERVABLE-LOOPS.md](./archive/OBSERVABLE-LOOPS.md) — draft spec for making any Observable Loop portable and verifiable by CI.

## License

MIT (this suite). `PRINCIPLES.md` is CC BY-SA 4.0 from the [autonomous-agent-principles](https://github.com/ntholm86/autonomous-agent-principles) repo.

## Citation

[CITATION.cff](./CITATION.cff) · Zenodo: [10.5281/zenodo.19842994](https://doi.org/10.5281/zenodo.19842994) (v3.2.0) · All versions: [10.5281/zenodo.19732826](https://doi.org/10.5281/zenodo.19732826).
