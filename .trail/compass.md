# Compass — autonomous-agent-skills

_Last updated: 2026-05-02 (run: retrospect-vectorium-arc-evidence-2026-05-02)_  
_Derived from: full arc read through typed-scene-services (vectorium run 5, session 2), read against current vision.md. Incorporates vectorium external-proof arc across two sessions and five trail entries._

---

## Current claims

**1. Phase 1 (vision convergence) mechanism fires on primed arcs; cold-context independence still unobserved.**  
Improve v3.7.0's occasion-independence mechanism — form sourced hunches from vision+compass+recent trail before acting on underspecified "continue" prompts — fired correctly during the vectorium continuation in this session. The agent read the compass, identified queued work (typed Scene services), and acted on it without operator topic injection. That is a real data point. But the arc has not yet produced a cold case: a fresh session on a genuinely new arc with no compass and no priming. Every occasion-independence pass to date has been on an arc already in motion. The mechanism exists and fires on primed arcs; its behaviour cold is still unknown.

**2. The recognition claim and adoption success condition introduce a validation gap no internal loop pass can close.**  
The updated vision redefines one test of success: recognition by practitioners who have felt the friction, and adoption by developers using the skills in their own projects without the author's help. Internal convergence runs measure structural consistency — they do not test whether the framework produces instant recognition in the target audience, or whether a stranger can deploy it. Phase 3 of the position document plan (direct outreach) is the only mechanism for this. The loop's arc to date has been Phase 2 work. Phase 3 has not started.

**3. Trail v1.10.0 + compass are functioning as inter-session memory in practice, not just in spec.**  
The vectorium arc across two sessions demonstrates the mechanism working end-to-end: Retrospect (session 1) wrote a compass with queued work; the next session opened the compass, found the queue, and acted on it directly. This is Observable Autonomy in practice: a non-present observer reading the vectorium trail could reconstruct what happened and why. Remaining gap: verify.py does not enforce sessions/ file presence — soft enforcement only.

**4. Learning falsification: first clear cross-session case observed, mediated by compass.**  
Vision defines learning as: a future agent acts on a prior `[!REALIZATION]` rather than rediscovering it. The vectorium arc provides the first clean case. Session 1's Retrospect and Improve trail entries identified the `(any)` cast injection pattern as a root cause and queued "typed Scene services" as next work. Session 2 (this session) began by acting on that queued work — removing 5 `(any)` casts from Engine.ts and adding typed service setters to Scene.ts — without re-diagnosing the root cause. Qualifier: the learning was mediated by the compass (which distilled the trail finding), not by the agent independently reading a `[!REALIZATION]` buried in a long log. Compass is the mechanism; that is as intended.

**5. Capability claims are strengthened by the vectorium arc; cross-family and stranger-deployed replication still required.**  
Vectorium arc evidence (5 trail entries, 2 sessions, 3 skills, Anthropic): Hunch surfaced a real insight not in any file (lost-interest-after-benchmark); Improve found and fixed real correctness issues across runs; Retrospect produced a decision-useful compass that oriented the next session; learning carry-forward worked as designed; 30/30 tests passing on a real TypeScript/WebGL2 codebase. All three skills now have multi-session, multi-run evidence on a real foreign target. The arc is still single-operator (author = operator) and single-agent-family (Anthropic only). Cross-family replication (non-Anthropic agent on vectorium or similar) and stranger-deployed replication remain required.

**6. External harness proof: gap substantially narrowed, "operator ≠ author" still the minimum unmet bar.**  
The vectorium arc provides the most extensive external-proof evidence to date: 5 runs, 2 sessions, multi-skill arc, compass-mediated learning, real code correctness improvements. This is meaningfully further than the prior compass's two-run snapshot. The remaining gap is structural: in all runs, the operator is also the author of vectorium. The adoption success condition and the research success condition both require the protocol to work for someone who did not co-author either the skills or the target. That case has not been attempted.

---

## What the next runs should test

1. **External proof (operator ≠ author)** — run the protocol on a real target where the operator did not build either the target or the skills. The vectorium arc has closed the "real non-self-targeting codebase" angle; the remaining angle is genuine independence. Addresses both research and adoption success simultaneously.
2. **Phase 1 occasion-independence (cold case)** — open a genuinely fresh session on a new arc with no compass and no prior priming. Does the mechanism in Improve v3.7.0 fire and produce a useful direction question without operator topic injection? One primed data point is not enough to claim the mechanism is reliable.
3. **Retrospect reliability (different operator or much longer arc)** — all Retrospect runs to date share the same operator. Run on an arc with different operator authorship, or on a target with a substantially longer trail history, to test claim stability.
4. **Learning carry-forward without compass mediation** — identify a `[!REALIZATION]` buried in a long log that the compass has not explicitly surfaced, and verify whether a future agent finds and acts on it. This would test whether the trail itself (not just the distilled compass) carries learning.

---

## Loop-effectiveness notes

The vectorium arc across two sessions is the most informative arc the suite has produced for testing the claims in vision. It delivered: the first clear cross-session learning case, practical validation of Observable Autonomy as an inter-session mechanism, and the most extensive external-proof evidence to date. The arc also confirmed what the prior compass called the highest-urgency gap: external proof requires operator ≠ author, and the vectorium arc — because the operator is also vectorium's author — cannot close it regardless of how many runs accumulate. More vectorium runs will not change that structural fact. The next high-leverage run should be on a target the operator did not build.