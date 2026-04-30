# Skills

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19842994.svg)](https://doi.org/10.5281/zenodo.19842994)

An autonomous improvement loop — and the four skills that power it. The loop can target any codebase. The loop has run more than 100 times on this repository, understanding its own mechanics, deciding how to improve it — with the three principles as the only human input.

During the process, it decided on its own to refactor itself, twice. Each run reads the full trail of prior iterations before acting — that accumulated reflection (called hansei in v2) is what surfaced the need for structural change rather than incremental improvement.

Every v3 iteration is recorded in `trail/log.md` — including the reasoning behind every autonomous decision. Earlier iterations are preserved in `archive/v2/TRAIL/` (v2) and `archive/v2/v1_archive/` (v1). The reasoning framework is inspired by Toyota Production Systems Philosophy (TPS).

## What this is

This repository is the loop it describes — the four skills are both the tool and the proof of concept. Applied to this repo itself, repeatedly, under observation, until independent evaluators from three different model families found nothing left to change.

This is one implementation of the [autonomous-agent-principles](https://github.com/ntholm86/autonomous-agent-principles) governance framework. The principles come from that repo (CC BY-SA 4.0); this repo is one tool suite that operates under them (MIT).

The three principles that govern every iteration, in 60 seconds:

1. **Commander's Intent** — define the destination, never prescribe the route. Agents reason about goals; they don't execute checklists.
2. **Observable Autonomy** — every autonomous step produces a continuous, multi-resolution trail. If you can't see it, it shouldn't be doing it.
3. **Convergence Is Silence** — the system has converged when diverse, independent evaluators find nothing to change. Score stability alone is not convergence. One model's silence is not convergence either — it may just be that model's blind spots. Convergence requires silence from evaluators that don't share the same training, reasoning patterns, or failure modes.

The full statement is in [PRINCIPLES.md](./PRINCIPLES.md).

## Research intent

The goal is a skillset that reaches independent silence convergence: three consecutive silence outcomes from distinct model families, each applied cold to the live tree. That is the done condition for this repo.

The broader research context (problem definition, principles convergence, cross-layer coherence) is governed by the [autonomous-agent-principles](https://github.com/ntholm86/autonomous-agent-principles) repo. This repo is one artifact in that chain.

## What's here

```
improve/
PRINCIPLES.md
README.md
LICENSE
CITATION.cff

intent/           # The intent skill. Surfaces the agent's interpretation of the ask before
                  # any work begins — the operator catches misreading at the cheapest moment.
                  # Runs first; Improve and Probe delegate to it when it is installed.

improve/          # The improvement skill. Examine, decide, change, verify, record. Or argue
                  # convincingly that nothing should change. Combines what v2 split into
                  # Kaizen (incremental), Kaikaku (radical), and Hansei (reflection).

probe/            # The reasoning probe. Construct paired cases that look similar but differ
                  # materially; observe whether the agent's response diverges where it should.
                  # Operationalizes ARF measurement.

trail/
  SKILL.md        # The trail skill. Append a structured log entry after every session.
  README.md       # Trail format spec.
  log.md          # The append-only trail. One entry per autonomous operation.

tools/
  verify.py       # Mechanical integrity check (replaces v2's verify-suite.ps1).
  record.py       # Append entries; print digest of latest entry. (Replaces v2's kiroku-*.ps1.)

archive/v2/       # The previous version of this suite, kept as evidence and for rollback.
                  # If you want to know what was removed and why, REDESIGN.md is the digest.
```

## Using the skills

**New here?** See [INSTALLING.md](./INSTALLING.md) for how to copy the skills into your own repo and why the folder structure matters.

The basic loop:
1. Install the skills into your repo's `.copilot/skills/`.
2. Run an agent (any model) on your codebase with the Improve skill — it reads the code, decides what to change, makes it, and appends a trail entry.
3. Commit. Run again. Knowledge compounds: each run reads the full trail of prior decisions.
4. When a run finds nothing actionable, that is one silence vote. Repeat with a different model family. Three independent silences from distinct families = convergence.

All four skills are markdown files an agent reads at the start of an autonomous operation. Each works standalone; any combination works. Install only what you need.

- **Intent** is the entry point. One skill, immediate impact — the agent surfaces its interpretation before acting. Start here if you want one thing that makes AI agents less wrong from the first message.
- **Trail** makes Intent durable. Without Trail, the interpretation from one session is gone by the next. With Trail, it accumulates in `trail/log.md` and Intent reads it on every future session.
- **Improve** is the examination and change skill. Use it for any audit, refactor, redesign, or fix. Delegates to Intent (step 1) and Trail (step 7) when they are installed.
- **Probe** answers the question everyone asks but nobody has a tool for: is the agent *actually reasoning*, or is it pattern-matching against the prompt? It constructs two cases that look similar but differ in one material way, then observes whether the agent's response diverges where it should. If it doesn't, you have evidence of shallow compliance, not reasoning. Delegates to Trail (step 5) when installed.

There is no orchestrator and no scoring rubric. The skills define the shape; the agent does the reasoning. The trail is the proof.

## Trail format

One file: `trail/log.md`. Append-only. Every autonomous operation adds an entry. Multi-resolution evidence (full / indexed / digested) is achieved within the file (entry body / inline `[!DECISION]` markers / `tools/record.py summary`), not across separate files. Format spec: [trail/README.md](./trail/README.md).

## Verifying

```bash
python tools/verify.py
```

Checks: required files exist, log entries parse, dates are non-decreasing, mandatory metadata fields are present, no UTF-8 corruption in the live tree.

## Recording

```bash
python tools/record.py new --slug=my-operation --target=some-repo
python tools/record.py summary
```

`new` appends a stub entry you fill in. `summary` prints the latest entry — the 60-second observer view.

## Versioning and convergence

**Current version: v3.6.0** (2026-04-30). Skills are actively maintained; see [CHANGELOG.md](./CHANGELOG.md) for the full history.

**Convergence baseline: v3.1.0** (2026-04-24) is the last release with full convergence evidence.

- Skills convergence: three independent silence runs from distinct model families — Anthropic (Claude Sonnet 4.6), xAI/Grok, Google/Gemini — each applied cold to the live tree. No material changes proposed.
- Cross-layer coherence: a fourth evaluation found no contradiction between the problem artifact, principles artifact, and skills.
- All four results are recorded in [trail/log.md](./trail/log.md).

**Future direction:** [OBSERVABLE-LOOPS.md](./OBSERVABLE-LOOPS.md) is a draft packaging contract that would make any Observable Loop portable across runtimes and verifiable by CI — the trail-mandatory, cross-family-evaluator model as a standard format. Draft only; no runtime conforms to it yet.

## License

MIT (this suite). The principles documents (`PRINCIPLES.md`) are licensed under CC BY-SA 4.0 by the manifesto repo.

## Citation

See [CITATION.cff](./CITATION.cff). Archived on Zenodo: [10.5281/zenodo.19842994](https://doi.org/10.5281/zenodo.19842994) (v3.2.0). All versions: [10.5281/zenodo.19732826](https://doi.org/10.5281/zenodo.19732826).
