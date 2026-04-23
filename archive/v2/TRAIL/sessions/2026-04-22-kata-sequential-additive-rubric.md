---
fidelity: reconstructed
source: agent-memory
date: 2026-04-22
started: 2026-04-22T06:31:17+02:00
participants: [human, Claude Sonnet 4.6]
session-id: 8a234b91-aa9c-457e-9923-e21cde583e80
project: C:\Users\admin\.copilot\skills
status: closed
closed: 2026-04-22T06:34:35+02:00
---

# Session: kata-sequential-additive-rubric

**Started:** 2026-04-22T06:31:17+02:00
**Participants:** human, Claude Sonnet 4.6
**Fidelity:** reconstructed - exchanges are captured from agent context, not verbatim platform export.

## Trigger

User adopted the sequential additive consolidation mechanism (over the parallel relay) on the basis of the prior turn's feasibility investigation: parallel relay is currently feasible only as a manual human-as-courier protocol, not engine-orchestratable. User asked: run Kata targeting the skills suite to design and ship sequential additive into the skills themselves.

## Intent

**Human intent (verbatim):** "I think we need to go with Sequential additive first - until github copilot chat becomes better and can handle this scenario. Understand my intent and start kata targetting itsself"

**Agent interpretation:** Run a real Kata cycle on the TPS skill suite. Deliverable: the additive consolidation rule and rubric provenance tracking become part of `kata/SKILL.md` Step 1 (replacing the looser "Re-derivation on evaluator-family change" text), with supporting changes to `SCORECARD.md` (provenance table) and version bumps. The mechanism must be load-bearing for future runs — not a doc note.

**Scope & constraints:**
- Target: skills suite at `C:\Users\admin\.copilot\skills\`
- Methodology: Kata → Kaizen (existing structure sound; add the missing rubric-evolution mechanism)
- Surface my four prior refinements visibly at Design step; user can stop me before each
- No new markdown files (operational constraint)
- Keep scope tight: do NOT touch the manifesto repo this run; provenance can be retro-applied to it later

## Exchange Log

### Step 0 — Intent (applied)

User decision is unambiguous: pick sequential additive, ship it. No further interpretation needed.

### Step 1 — Grasp

Read SCORECARD.md (Rubric v4, six dimensions, Target Condition), CHANGELOG.md (current 2.10.0), Kata SKILL.md Step 1 (current "Re-derivation on evaluator-family change" subsection). All six skill SKILL.md files at version 2.10.0.

The rubric-evolution mechanism currently in place (Kata Step 1):
- Convergent → record and proceed
- Divergent → `[!REALIZATION]`; "decide whether to extend the scheme, replace it, or record the divergence for a future run to reconcile"
- Same family → inherit (no re-derivation)
- Externally anchored rubric → exempt from re-derivation, not from divergence-as-finding

Gaps for sequential additive:
1. Divergence allows deferral ("record for a future run to reconcile") — findings can rot. Additive requires merge **this run**.
2. No provenance ledger — the trail can't answer "which families have contributed to this rubric?"
3. No consolidation discipline — "extend, replace, or record" is not an operational protocol.
4. Family vs version not distinguished — a Sonnet 4.7 run might or might not count as a different family from Sonnet 4.6.
5. Cold-derivation hygiene not specified — a model that reads the existing rubric first will mostly reproduce it.

Inheriting Rubric v4 (no rubric re-derivation this run — the target IS the mechanism, not the artifact's score). Measurement scheme: D1 (Intent Fidelity) and D3 (Convergence Integrity) are the dimensions this change directly affects. D5 (Artifact Integrity) affected via verifier alignment.

### Step 2 — Diagnose

**Lens: Unevenness.** The current re-derivation text is principle-shaped but not protocol-shaped. It tells the agent *what convergent/divergent means* but not *what to do about divergence operationally* — leaving "extend, replace, or record" as agent judgment per run. Each evaluator therefore consolidates differently (or not at all), and the rubric drifts inconsistently across runs. Root cause: the existing text was written when re-derivation was viewed as a validation event (does the new family agree?), not a contribution event (what does the new family add?). The frame needs to widen.

**Lens: Waste.** Findings recorded as `[!REALIZATION]` then deferred to "a future run to reconcile" age in place. The TRAIL/INDEX captures them but the rubric does not. Across many runs, divergent insights accumulate as orphan findings while the rubric stays narrow. Root cause: no mechanism forces the merge.

### Step 3 — Decide

[!DECISION] Methodology: **Kaizen**. Hardening of an existing mechanism, not redesign.
Alternatives: Kaikaku (rejected — Step 1's structure is sound); Silence (rejected — actionable mechanism gap).

### Step 4 — Design (refinements surfaced)

Four refinements I proposed in prior turns. Each marked accept / defer / drop.

| # | Refinement | Decision | Rationale |
|---|------------|----------|-----------|
| a | Convergent-with-no-addition is an explicit allowed outcome (so the rubric *can* converge — otherwise additive growth is unbounded by construction) | **Accept** | Otherwise convergence becomes impossible; contradicts P3 directly |
| b | Consolidation discipline with marker conventions: addition = auto-accept, refinement = `[!DECISION]`, contradiction = `[!REVERSAL]` | **Accept** | Operational protocol the current text lacks |
| c | Family-vs-version distinction: family gates the consolidation requirement; version goes in provenance ledger | **Accept** | Without this, vendor minor bumps trigger pointless rubric churn |
| d | Cold-derivation-before-comparison: model derives its own list before being shown the existing rubric, then consolidates | **Accept (as recommendation, not enforcement)** | Engine cannot enforce blindfolding; making it the documented protocol is what we can do |

Plus one item that emerged during diagnose:

| # | Refinement | Decision |
|---|------------|----------|
| e | Rubric Provenance table in `SCORECARD.md` listing each dimension, contributing family-version, run number, rationale | **Accept** |

### Step 5 — Execute

Edits made:
1. `kata/SKILL.md` Step 1: replaced the "Re-derivation on evaluator-family change" subsection with a stricter additive-consolidation protocol. Added the four outcomes (convergent-no-addition / convergent-refinement / divergent-additive / divergent-contradictory), each with marker convention. Added cold-derivation-before-comparison as the recommended protocol. Added family-vs-version definition. Pointer to SCORECARD provenance table.
2. `SCORECARD.md`: added "Rubric Provenance" section after "Scheme rationale", populated with v4's six dimensions all attributed to Run 87 (their original derivation).
3. All six skill files version-bumped 2.10.0 → 2.11.0 (mechanism change in Kata Step 1 propagates as a coordinated bump; the suite versions move together by convention).
4. `CHANGELOG.md`: 2.11.0 entry summarizing the mechanism.
