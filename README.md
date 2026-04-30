# Skills

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19842994.svg)](https://doi.org/10.5281/zenodo.19842994)

An autonomous improvement loop — and the four skills that power it. The loop can target any codebase and has run more than 100 times on this repository, understanding its own mechanics, deciding how to improve it — with the [three principles](./PRINCIPLES.md) as the requirements. During the process, it decided on its own to refactor itself, twice.

## The four skills

| Skill | What it does |
|---|---|
| **[Intent](./intent/SKILL.md)** | Surfaces the agent's interpretation of the ask *before* any work begins. Catches misreading at the cheapest moment. Start here. |
| **[Improve](./improve/SKILL.md)** | Examine, decide, change, verify, record — or argue convincingly that nothing should change. The core autonomous loop. |
| **[Probe](./probe/SKILL.md)** | Constructs two cases that look similar but differ materially. If the agent's response doesn't diverge where it should, you have evidence of pattern-matching, not reasoning. Measures [Autonomous Reasoning Fidelity (ARF)](./PRINCIPLES.md). |
| **[Trail](./trail/SKILL.md)** | Appends a structured entry to `trail/log.md` after every session. Knowledge accumulates; each run reads all prior decisions before acting. |

Each skill is standalone. Install only what you need. Any combination works.

## Quick start

See [INSTALLING.md](./INSTALLING.md) for setup details.

1. Copy `intent/`, `improve/`, `probe/`, and `trail/` into your repo's `.copilot/skills/`.
2. Run an agent on your codebase with the Improve skill — it reads the code, decides what to change, makes it, appends a trail entry.
3. Commit. Run again. Each run reads the full trail of prior decisions.
4. When a run finds nothing actionable, that's one silence vote. Repeat with a different model family. Three independent silences from distinct model families = convergence.

## How it works

No orchestrator. No scoring rubric. No human in the loop between iterations.

Each run reads the complete trail of every prior decision before acting. That accumulated context is both log and memory. The agent doesn't repeat the same analysis; it builds on what it already concluded, and challenges it. After enough iterations on this repo, it stopped making incremental fixes and proposed restructuring the suite entirely. Twice. Both times the reasoning was in the trail before any human saw it.

The reasoning follows a specific sequence, drawn from Toyota Production System (TPS) and military doctrine:

**Intent first.** Before touching anything, the agent applies Commander's Intent in reverse — decoding what the human actually wants, not what they literally wrote. It names the interpretation and one rejected alternative, Coaching Kata style: what is the target condition, what is the actual condition, what is in the way. The user sees the interpretation before work begins and can correct it at zero cost.

**Then Genba** — go to where the work is. Read the actual code, the actual trail, the actual output. Not a summary, not an assumption. The agent forms its model from what is there, not what should be there.

**Then the three TPS lenses:** **Waste** (what carries no value), **Overburden** (what is asked to do too much), **Inconsistency** (where the target contradicts itself). Applied as thinking tools, not a checklist — and only the ones the target invites.

**Then Hansei** — structured reflection after acting. Did the loop converge or churn? What should the next run look at? Every decision names what was rejected and why. A decision without a rejected alternative isn't a decision — it's an output.

Every decision, reversal, and dead end is recorded in `trail/log.md`. That file is the proof that the autonomy was real — not that it produced good outputs, but that the reasoning behind each output can be reconstructed, audited, and challenged by anyone who wasn't there.

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
