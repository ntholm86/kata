# Skills

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19732827.svg)](https://doi.org/10.5281/zenodo.19732827)

Two skills and a trail format that operationalize three principles for autonomous agents.

> **The repository is named `kata` for historical reasons.** v1 and v2 of this suite were named after Toyota Production System concepts (Kata, Kaizen, Kaikaku, Hansei, Shiken, Kiroku). v3 dropped that vocabulary in favour of plain English. The repository name is kept as a project codename to preserve URL, DOI, and citation lineage.

## What this is

An implementation of the [autonomous-agent-principles](https://github.com/ntholm86/autonomous-agent-principles) governance framework. The principles come from that repo (CC BY-SA 4.0); this repo is one tool suite that operates under them (MIT).

The three principles, in 60 seconds:

1. **Commander's Intent** — define the destination, never prescribe the route. Agents reason about goals; they don't execute checklists.
2. **Observable Autonomy** — every autonomous step produces a continuous, multi-resolution trail. If you can't see it, it shouldn't be doing it.
3. **Convergence Is Silence** — the system has converged when diverse, independent evaluators find nothing to change. Score stability alone is not convergence.

The full statement is in [PRINCIPLES.md](./PRINCIPLES.md).

## Research intent and done condition

The intent of this research is to produce publishable, externally auditable evidence that the defined problem is addressed by the principles and operationalized by the v3 skillset. Convergence is not the objective by itself; it is the stopping signal that this intent has been satisfied.

Work is done only when all of the following hold, in order:

1. The problem artifact has independent silence convergence.
2. The principles artifact has independent silence convergence.
3. The v3 skillset artifact has independent silence convergence.
4. A cross-layer coherence check finds no contradiction between problem, principles, and skills.
5. The evidence package is complete and reviewable for external publication (GitHub and Zenodo).

Operational scoping rules for convergence are defined in [CONVERGENCE_SCOPE_PROTOCOL.md](./CONVERGENCE_SCOPE_PROTOCOL.md).

## What's here

```
PRINCIPLES.md     # Copy of the canonical principles (manifesto repo wins on conflict).
REDESIGN.md       # Why v3 exists. The audit trail for the v2 → v3 rebuild.
README.md         # This file.
LICENSE           # MIT.
CITATION.cff      # Academic citation metadata (Zenodo will pick this up on release).

improve/          # The improvement skill. Examine, decide, change, verify, record. Or argue
                  # convincingly that nothing should change. Combines what v2 split into
                  # Kaizen (incremental), Kaikaku (radical), and Hansei (reflection).

probe/            # The reasoning probe. Construct paired cases that look similar but differ
                  # materially; observe whether the agent's response diverges where it should.
                  # Operationalizes ARF measurement.

trail/
  README.md       # Trail format spec.
  log.md          # The append-only trail. One entry per autonomous operation.

tools/
  verify.py       # Mechanical integrity check (replaces v2's verify-suite.ps1).
  record.py       # Append entries; print digest of latest entry. (Replaces v2's kiroku-*.ps1.)

archive/v2/       # The previous version of this suite, kept as evidence and for rollback.
                  # If you want to know what was removed and why, REDESIGN.md is the digest.
```

## Using the skills

Both skills are markdown files an agent reads at the start of an autonomous operation.

- **Improve** is the default skill. Use it for any examine-and-change cycle: audit, refactor, redesign, evaluate, fix. It does both incremental and radical work; it picks which mode the situation calls for.
- **Probe** tests whether the agent is actually reasoning about a situation or pattern-matching against a template. Use it when you want evidence (one way or the other) about reasoning quality.

There is no orchestrator, no scoring rubric, no separate intent step. The skills define the shape; the agent does the reasoning. The trail is the proof.

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

**Converged.** v3.1.0 (2026-04-24) is the first release with full convergence evidence.

- Skills convergence: three independent silence runs from distinct model families — Anthropic (Claude Sonnet 4.6), xAI/Grok, Google/Gemini — each applied cold to the live tree. No material changes proposed.
- Cross-layer coherence: a fourth evaluation found no contradiction between the problem artifact, principles artifact, and skills.
- All four results are recorded in [trail/log.md](./trail/log.md).

Convergence claims in this repo are scope-bound by [CONVERGENCE_SCOPE_PROTOCOL.md](./CONVERGENCE_SCOPE_PROTOCOL.md). Evaluators should treat that file as mandatory pre-read during Grasp for convergence runs, and read the current chain from [trail/log.md](./trail/log.md).

## License

MIT (this suite). The principles documents (`PRINCIPLES.md`) are licensed under CC BY-SA 4.0 by the manifesto repo.

## Citation

See [CITATION.cff](./CITATION.cff). When v3 is released, this repository will be deposited to Zenodo for a DOI.
