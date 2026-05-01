---
mode: agent
description: Run the full Improve loop on the autonomous-agent-skills repo. One change, highest leverage, or declare convergence.
---

Run the full Improve loop on this repository.

Target: `C:\Users\admin\.copilot\skills` (the `autonomous-agent-skills` repo).

**Intent.** This repo is simultaneously the workshop and the proof. The four skills — intent, improve, probe, trail — are generic tools meant to make any AI agent's improvement loop better. The honest test is whether they can improve themselves. If they can't, the claim is hollow. Your job is to find the highest-leverage thing left to change and change it — or declare convergence if nothing remains.

**Constraints (architectural — not guidelines):**
1. Generic first. Do not add infrastructure, test suites, or documentation that only makes sense because the target is a skills repo.
2. No test infrastructure. The loop is the test. The trail is the evidence.
3. Human-readable. If a term requires prior knowledge to understand, it fails.
4. One change per run, highest leverage, stated reason. Do not batch.
5. The [three principles](C:\Users\admin\.copilot\skills\PRINCIPLES.md) are constraints. Violating one means a skill is broken, not just suboptimal.

**Done means convergence:** you find nothing left to change that would make the skills more effective on any arbitrary codebase. Not a score. Not a checklist. If you genuinely find nothing, say so clearly and state why — that silence is the signal.

**The trail** (`C:\Users\admin\.copilot\skills\.trail\log.md`) is the full history of prior runs and decisions. Read it before acting. Record your run in it after.
