# INTENT: Rebuild Skills from Principles

**Date:** 2026-04-19
**Author:** Human + Claude Opus 4.6
**Fidelity:** Reconstructed from conversation context

## Problem

The TPS Skill Suite v1.34.0 accumulated 44 runs of iterative patching on skills that were written in a single day by a single model. The skills work, but they carry prescriptive drift: specific thresholds, example lists, and step-by-step procedures that were added to fix individual findings rather than derived from the Principles. The patching was measured by a rubric that scored the skills as documents, not the work they produce. The result is a well-measured greenhouse that has never been tested in the field.

## Destination

A skill set that:

1. **Is derived from PRINCIPLES.md and PROBLEM.md alone.** The system reads the three Principles and the two Problems, then determines what skills are needed and what each skill should contain. The human does not prescribe which skills exist or what they say.

2. **Passes the Commander's Intent test.** If you removed all examples and thresholds from any skill, a competent agent would still know what to do. The skills define destinations, not routes.

3. **Is authored entirely by the system.** No human edits to skill files. If a skill needs changing, the human writes an Intent and the system executes. Every change has a traceable origin: Intent -> reasoning -> artifact.

4. **Produces demonstrable Tier 2 results.** Within this rebuild, at least one Tier 2 dimension (Transferability, External Target Efficacy, or Observer Satisfaction) moves from Untested to Pass.

5. **Has a complete Kiroku trail.** Every session that touches the skills is captured. The reasoning for every skill's existence and content is in the trail, not in the agent's memory.

## Constraints

- **PRINCIPLES.md and PROBLEM.md are inputs, not outputs.** The rebuild does not modify the Principles. If the system discovers a Principle is incomplete, it records that finding and proceeds - principle changes require explicit human Intent.
- **The existing suite is reference material, not a template.** The system may read v1.34.0 to understand what was tried, but it must not copy-paste. Each skill must be freshly reasoned from the Principles.
- **MEASUREMENT.md governs scoring.** Both Tier 1 (Skill Quality) and Tier 2 (Work Quality) apply.
- **Kiroku trail is mandatory.** Every session uses kiroku-start/close. No work happens without capture.
- **Cross-model validation required.** The authoring model's work must be evaluated by at least one different model family before any Tier 2 claim is made.

## Done Looks Like

- A human reads the skill set and says: "I understand what each skill is for. I could hand this to any competent AI and it would know what to do."
- A different model, given only PRINCIPLES.md and the new skills, produces work on an external target that the human accepts.
- The full reasoning trail exists: why these skills, why this content, what was considered and rejected.
- Tier 1 score is assessed. Tier 2 has at least one Pass.

## What This Is NOT

- Not a port of v1.34.0 with cleaned-up wording. This is a rebuild.
- Not a single-session task. The system works in sessions, each captured by Kiroku.
- Not a human-directed line-by-line review. The human provides the Intent. The system determines the implementation.

## Execution Approach

The system should:
1. Read PRINCIPLES.md and PROBLEM.md
2. Determine what skills are needed (may be fewer than 8, may be more, may be different)
3. Write each skill from scratch, reasoning from the Principles
4. Self-evaluate against Tier 1
5. Test against at least one Tier 2 dimension
6. Record everything in the Kiroku trail
