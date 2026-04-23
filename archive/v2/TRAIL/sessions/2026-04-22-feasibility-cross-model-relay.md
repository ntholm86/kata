---
fidelity: reconstructed
source: agent-memory
date: 2026-04-22
started: 2026-04-22T06:20:50+02:00
participants: [human, Claude Sonnet 4.6]
session-id: fde02074-5a77-4777-a64a-6c29cabf0582
project: C:\Users\admin\.copilot\skills
status: closed
closed: 2026-04-22T06:22:33+02:00
---

# Session: feasibility-cross-model-relay

**Started:** 2026-04-22T06:20:50+02:00
**Participants:** human, Claude Sonnet 4.6
**Fidelity:** reconstructed - exchanges are captured from agent context, not verbatim platform export.

## Trigger

User caught the agent prescribing a "sequential additive consolidation" solution for cross-family rubric derivation instead of letting Kata methodology surface the answer. User asked: investigate whether the *ideal* — full parallel relay (Intent / Grasp / Measurement rotated across three model families) — is actually feasible in Copilot Chat today. Only fall back to a lesser solution if blocked by real constraints.

## Intent

**Human intent (verbatim):** "Lets see if Kata itsself is able to solve this. Ideally, we want to full paralel rigor with 3 runs: Model a interprets intent -> model b grasps -> model c defines measurements [rotated]. But if that is not actually feasible and possible because of the limitations right now then find another solution like what i just suggested."

**Agent interpretation:** Honestly check engine-level feasibility before recommending anything. Do not jump to a fallback unless investigation forces one. Engine includes: Copilot Chat surface, Kiroku scripts, Kata SKILL.md routing assumptions. The output should describe what's permitted, what's not, and what bridging the gap requires — not a prescription.

**Scope & constraints:**
- Investigation only this turn — no spec writing, no skill changes
- Must be honest about my own ceiling: I cannot empirically run the relay from inside this Claude session
- Must distinguish "human-as-courier feasible" from "engine-orchestratable"
- Do not create markdown files (operational constraint)

## Exchange Log

### Step 0 — Intent (applied)

User confirmed interpretation: investigate feasibility honestly, surface the gap, let them decide. Also noted "this proves the value of the intent skill" — the prior turn's interpretation prevented me from skipping straight to a fallback I had already mentally chosen.

### Step 1 — Grasp the engine

**Copilot Chat surface:**
- Model selection is per-conversation via the model picker. Switching changes the model for the *next* turn.
- All prior turns in a conversation remain in context regardless of model switch — this is documented in Kata SKILL.md: *"changing the selected model inside the same conversation does not satisfy independent assessment. Prior scores and reasoning remain in context."*
- No API for transcript export (documented in kiroku SKILL.md, "Fidelity honesty" section).
- No programmatic mechanism for one model to invoke another, or for an external orchestrator to route a turn to a specific model.
- Model identity is not cryptographically attested in the response; it is what the surface tells the human and what the human records.

**Kiroku scripts:**
- `kiroku-start.ps1` accepts `-Participants` as a single string per session. The session template has one `participants:` line in YAML frontmatter. There is no per-step / per-stage model attribution.
- `kiroku-validate.ps1` (8 checks) does not verify model identity claims at all — it can't, because the engine has no source of truth for which model produced which content.
- The trail's only knowledge of "which model" is what the human types into `-Participants` at session start.

**Kata SKILL.md routing assumptions:**
- Step 0 (Interpret), Step 1 (Grasp), Step 2 (Diagnose), Step 3 (Decide), Step 4 (Execute) are described as a single agent's flow. No multi-model routing primitives.
- The "re-derivation on evaluator-family change" rule (Step 1) is the closest existing mechanism — it requires a fresh evaluator family to re-derive the measurement scheme, but assumes one family per *run*, not per *step within a run*.
- Convergence (Step 6) requires diverse evaluators across runs — explicitly forbids same-conversation model switching.

[!REALIZATION] Kata's existing language already rules out the cleanest implementation of the relay: switching models mid-conversation. The only Principle-3-compliant way to route different models to different steps is *fresh conversations per step*, with handoff artifacts pasted in.

### Step 2 — What the parallel relay actually requires

For one full rotation (Cycle 1: A→B→C, Cycle 2: B→C→A, Cycle 3: C→A→B):
- 9 distinct fresh sessions (3 cycles × 3 stages)
- 6 handoff artifacts (each non-first stage receives the prior stage's output)
- Per-step model identity recorded and verified somehow
- Consolidation step at the end (the 10th touch — who runs it?)

**What the engine can do:**
- Open 9 fresh chat sessions: yes
- Switch Copilot model per session: yes (manual, model picker)
- Capture each stage's output as a handoff artifact: yes (human pastes between sessions)
- Record per-stage model identity in the trail: **no, not natively**
- Verify model identity matches what the human attested: **no**

**What the engine cannot do (and would need to be added):**
1. Per-step model attribution in session metadata (kiroku-start would need `-StageModels` or equivalent, OR a new "relay session" template)
2. A relay-mode protocol document in Kata SKILL.md (when to invoke, handoff hygiene, consolidation rule, fidelity marking for human-attested model identity)
3. A validation check confirming that the relay session has all 3 stages recorded with distinct model identities
4. A consolidation step specification (whose job, what discipline, recorded where)

[!REALIZATION] The relay is **feasible today as a manual protocol** with the human as courier. It is **not orchestratable by the engine** in any current form. The engine extensions to support it are small — three additions to Kiroku, one Kata section.

### Step 3 — Honest comparison: relay vs. sequential additive

Both are achievable. The differences:

| Dimension | Parallel Relay (ideal) | Sequential Additive (fallback) |
|---|---|---|
| Sessions per cycle | 9 (3 stages × 3 rotations) | 1 |
| Handoffs per cycle | 6 inter-session pastes | 0 within cycle, 1 across runs |
| Model identity attestation | Human-attested per stage, system can't verify | Human-attested per session, simpler |
| Catches upstream blind spots | Yes — no family ever owns the full chain | Partial — each family always sees its own framing first |
| Cost (human time) | ~9× per evaluation | ~1× per evaluation |
| Engine changes required | 4 small additions (Kiroku + Kata) | 2 small additions (consolidation rule + provenance ledger) |
| Trail integrity at handoff seams | Risk — paste discipline matters | No handoff seams within a cycle |

[!REALIZATION] The relay's epistemic advantage is real (forces upstream framing across families) but it requires the human to function as orchestration middleware. The sequential additive option is cheaper but inherits the risk that each family anchors to the prior consensus.

### Step 4 — What I will NOT decide for the user

- Whether 9× cost per evaluation is justified by the upstream-blind-spot protection
- Whether human-as-courier counts as an acceptable orchestration model for Principle 2 (Observable Autonomy with marked fidelity) or violates it (system can't verify the model identity claims)
- Whether to build the relay infrastructure first or run a Gemini sequential probe first to see if the cheaper mechanism is sufficient

These are deployer-class decisions about cost/value/integrity tradeoffs, not engine-feasibility questions.

### Step 5 — Conclusion to report

**The parallel relay IS feasible today** as a manual protocol with the human as courier. It is not engine-orchestratable. Bridging to "engine-orchestratable" requires either (a) Copilot exposing cross-model routing — out of our control, or (b) external orchestration via direct LLM APIs — outside the current toolchain.

The choice between "build relay infrastructure" and "build sequential additive infrastructure" is not a feasibility question; both are feasible. It is a cost/value question for the user.
