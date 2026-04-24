# Convergence Scope Protocol

Operational protocol for convergence claims in this repository.

This file defines what must be considered in Grasp before any run that claims to advance convergence.

## Purpose

Convergence is measured against mission intent, not text stability alone. The mission intent for v3 is publication-grade evidence that problem, principles, and skills are coherent and complete.

## Dependency order

Convergence scope follows this dependency chain:

1. Intent claim
2. Problem definition
3. Principles
4. Skills implementation

Downstream convergence is valid only while upstream layers are unchanged.

## Execution sequence (1-5)

1. Freeze upstream baselines.
   - Record locked references (repo + ref/commit/tag) for intent, problem, principles, and skills before starting a convergence cycle.
   - If a layer is external to this repo, record the external reference in the trail entry.

2. Start skills convergence from 0/3.
   - Any material change in the skills artifact resets skills convergence to zero.

3. Complete skills convergence at 3/3.
   - Require three consecutive silence outcomes.
   - Require fresh sessions.
   - Require distinct evaluator families.
   - Each entry must declare it is evaluating the skills layer.

4. Run one explicit cross-layer coherence evaluation.
   - Evaluate whether principles solve the problem, and whether skills uphold the principles while solving the problem.
   - If this run finds an actionable issue and changes artifacts, reset affected layers per reset matrix.

5. Apply publication gate.
   - Publication-ready requires: problem converged, principles converged, skills converged, coherence check silent, and evidence package complete.

## Reset matrix

| Change type | Required reset scope |
|---|---|
| Skills-only change | Skills convergence resets |
| Principles change | Principles and skills convergence reset |
| Problem change | Problem, principles, and skills convergence reset |
| Intent wording change (no semantic change) | No mandatory reset; log clarification |
| Intent claim / success criteria change | Full reset of all layers |

## Required Grasp inputs for convergence runs

For any run that claims to advance convergence, read at minimum:

- `CONVERGENCE_SCOPE_PROTOCOL.md`
- `README.md` (Research intent and done condition)
- `PRINCIPLES.md`
- `improve/SKILL.md`
- `trail/README.md`
- `trail/log.md`

For cross-layer coherence runs, also read the locked upstream problem artifact at its recorded reference.

## Trail recording requirements (convergence runs)

Each convergence entry should explicitly state:

- Which layer is being evaluated.
- Which locked references were used.
- Whether the run advanced a chain or reset it.
- Why the outcome contributes to (or blocks) publication readiness.
