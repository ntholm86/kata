# Decision Index

*Last updated: 2026-04-19 - skills-v2-cross-validation session*

---

## Decisions

### DEC-001: Kiroku tooling is PowerShell scripts + agent protocol
- **Date:** 2026-04-19
- **Session:** [rebuild-planning](sessions/2026-04-19-rebuild-planning.md)
- **Fidelity:** reconstructed
- **Participants:** human, Claude Opus 4.6
- **Decision:** Kiroku tooling implemented as PowerShell scripts (kiroku-start, kiroku-index, kiroku-close, kiroku-validate) plus an agent protocol document. Not a VS Code extension or Python package.
- **Rationale:** Target environment is Windows with PowerShell 5.1. No dependency installation. The agent IS the primary tool - scripts support it with mechanical validation.
- **Alternatives considered:** VS Code extension (violates INTENT constraint), Python CLI (requires venv), manual-only convention (proven insufficient)
- **Status:** active

### DEC-002: Split measurement into Tier 1 (input) and Tier 2 (output)
- **Date:** 2026-04-19
- **Session:** [rebuild-planning](sessions/2026-04-19-rebuild-planning.md)
- **Fidelity:** reconstructed
- **Participants:** human, Claude Opus 4.6
- **Decision:** Measurement framework has two tiers. Tier 1 (Skill Quality) = existing Rubric v3 (8 dimensions, 1-10 scale). Tier 2 (Work Quality) = 5 new output dimensions (Transferability, External Target Efficacy, Reasoning vs. Compliance, Observer Satisfaction, Time to Value) with pass/fail scoring.
- **Rationale:** The current rubric measures whether skills are well-written (input), not whether they produce good work (output). You need both. 46 runs proved input metrics can plateau without validating output.
- **Alternatives considered:** Replace rubric v3 entirely (loses calibration data), keep v3 only (perpetuates blind spot), merge into one rubric (conflates different measurement targets)
- **Status:** active

### DEC-003: Pass/fail for Tier 2 scoring
- **Date:** 2026-04-19
- **Session:** [rebuild-planning](sessions/2026-04-19-rebuild-planning.md)
- **Fidelity:** reconstructed
- **Participants:** human, Claude Opus 4.6
- **Decision:** Tier 2 dimensions scored as Pass/Fail/Untested, not on a 1-10 scale.
- **Rationale:** The v1/v2 rubric proved that 1-10 scales invite ad-hoc scoring that converges to the ceiling without meaning. Pass/fail forces binary evidence.
- **Alternatives considered:** 1-10 scale (same failure mode), 3-point scale (marginal improvement, adds complexity)
- **Status:** active

### DEC-004: System determines what skills exist
- **Date:** 2026-04-19
- **Session:** [rebuild-planning](sessions/2026-04-19-rebuild-planning.md)
- **Fidelity:** reconstructed
- **Participants:** human, Claude Opus 4.6
- **Decision:** The rebuild starts from PRINCIPLES.md and PROBLEM.md. The system determines the number and nature of skills. The human does not prescribe which skills exist.
- **Rationale:** The current 8-skill structure was invented by one model in one session. The structure should be derived from what the Principles require.
- **Alternatives considered:** Prescribe same 8 skills with cleaner content (perpetuates structure problem), let human specify which skills (violates Commander's Intent)
- **Status:** active

### DEC-005: No human edits to skill files
- **Date:** 2026-04-19
- **Session:** [rebuild-planning](sessions/2026-04-19-rebuild-planning.md)
- **Fidelity:** reconstructed
- **Participants:** human, Claude Opus 4.6
- **Decision:** All skill file changes go through Intents. No direct human editing. Makes audit trail complete and enforces Commander's Intent.
- **Rationale:** Traceable origin for every change (Intent -> reasoning -> artifact). Also enforces P1: human defines what, system determines how.
- **Alternatives considered:** Human edits with trail documentation (partial audit trail), collaborative editing (muddies P1 test)
- **Status:** active

### DEC-006: Existing v1.34.0 is reference, not template
- **Date:** 2026-04-19
- **Session:** [rebuild-planning](sessions/2026-04-19-rebuild-planning.md)
- **Fidelity:** reconstructed
- **Participants:** human, Claude Opus 4.6
- **Decision:** The system may read v1.34.0 skills to understand what was tried, but must not copy-paste. Each skill freshly reasoned from Principles.
- **Rationale:** The goal is to test whether fresh reasoning from Principles produces the same, different, or better skills than 44 runs of iterative patching.
- **Alternatives considered:** Start from v1.34.0 and simplify (incremental, not rebuild), ignore v1.34.0 entirely (loses lessons learned)
- **Status:** active

### DEC-007: Diagnostic lenses are vocabulary in Kaizen, not standalone skills
- **Date:** 2026-04-19
- **Session:** [skills-rebuild](sessions/2026-04-19-skills-rebuild.md)
- **Fidelity:** reconstructed
- **Participants:** human, Claude Opus 4.6
- **Decision:** Mura (unevenness), Muri (overburden), Muda (waste) become diagnostic vocabulary within Kaizen, not separate skills.
- **Rationale:** P1 says "provide vocabulary, not answers." Making them separate skills fragments a single activity (diagnosis) into three prescribed steps. A competent agent should determine which lens applies, not be told to invoke each in order.
- **Alternatives considered:** Keep as 3 separate skills (v1.34.0 approach), merge into 1 diagnostic skill separate from Kaizen
- **Status:** active

### DEC-008: Five skills, not eight
- **Date:** 2026-04-19
- **Session:** [skills-rebuild](sessions/2026-04-19-skills-rebuild.md)
- **Fidelity:** reconstructed
- **Participants:** human, Claude Opus 4.6
- **Decision:** Suite reduced to 5 skills (Kata, Kaizen, Kaikaku, Hansei, Shiken). Mura/Muri/Muda absorbed into Kaizen. Project-increment removed (utility, not reasoning).
- **Rationale:** The 3 diagnostic skills were always invoked through Kata, never independently. Project-increment does not embody any Principle.
- **Alternatives considered:** Keep 8 skills, keep 6, keep 3
- **Status:** active

### DEC-009: Diagnostic vocabulary embedded in Kaizen, not referenced externally
- **Date:** 2026-04-19
- **Session:** [skills-rebuild](sessions/2026-04-19-skills-rebuild.md)
- **Fidelity:** reconstructed
- **Participants:** human, Claude Opus 4.6
- **Decision:** Unevenness/overburden/waste described as sections within Kaizen's Diagnose phase, labeled "thinking tools, not a procedure."
- **Rationale:** When writing Kaizen, the lenses emerged as natural sections. This is the Commander's Intent test: an agent would know to look for these without being told to invoke separate skills.
- **Alternatives considered:** Reference external directories as supplementary reading, include extended examples
- **Status:** active

### DEC-010: Cross-model validation defects become patch release v2.0.1
- **Date:** 2026-04-19
- **Session:** [skills-v2-cross-validation](sessions/2026-04-19-skills-v2-cross-validation.md)
- **Fidelity:** reconstructed
- **Participants:** human, GPT-5.4
- **Decision:** Treat the shipped-v2 integrity defects as a patch release (`v2.0.1`), not as a rewrite of the rebuild history.
- **Rationale:** The rebuild reasoning remains valid, but the shipped artifact was wrong. A patch release preserves the real trail while correcting the live state.
- **Alternatives considered:** Rewrite the trail as if the defect never shipped, invalidate the rebuild entirely
- **Status:** active

### DEC-011: Retired standalone skills removed from live suite
- **Date:** 2026-04-19
- **Session:** [skills-v2-cross-validation](sessions/2026-04-19-skills-v2-cross-validation.md)
- **Fidelity:** reconstructed
- **Participants:** human, GPT-5.4
- **Decision:** Remove live `mura`, `muri`, `muda`, and `project-increment` skill files from the suite root. Preserve reference material only in `v1_archive/`.
- **Rationale:** The rebuild's 5-skill claim must be true on disk, not only in the narrative.
- **Alternatives considered:** Leave warning stubs in place, keep contradictory live directories
- **Status:** active

### DEC-012: Mechanical verifier aligns to the 5-skill suite
- **Date:** 2026-04-19
- **Session:** [skills-v2-cross-validation](sessions/2026-04-19-skills-v2-cross-validation.md)
- **Fidelity:** reconstructed
- **Participants:** human, GPT-5.4
- **Decision:** `verify-suite.ps1` now validates the live 5-skill suite and excludes external-target SCORECARD rows when checking skill-suite GENBA coverage.
- **Rationale:** Mechanical truth must match suite reality. Otherwise the verifier itself becomes a source of false evidence.
- **Alternatives considered:** Leave verifier on the 8-skill layout until a later run, keep permanent warnings for external-target rows
- **Status:** active
