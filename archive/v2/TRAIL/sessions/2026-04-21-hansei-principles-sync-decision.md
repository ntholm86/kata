---
fidelity: reconstructed
source: agent-memory
date: 2026-04-21
started: 2026-04-21T15:30:22+02:00
participants: [human, GPT-5.4]
session-id: fa680a7d-9175-45b0-99f5-b989893ed77e
project: C:\Users\admin\.copilot\skills
status: closed
closed: 2026-04-21T15:32:18+02:00
---

# Session: hansei-principles-sync-decision

**Started:** 2026-04-21T15:30:22+02:00
**Participants:** human, GPT-5.4
**Fidelity:** reconstructed - exchanges are captured from agent context, not verbatim platform export.

## Trigger

User asked whether the manifesto's now-improved articulation of the principles should be copied back into the skillset's `PRINCIPLES.md`, and whether the suite should then rerun Kata on itself under the updated principles.

## Intent

**Human intent:** Decide whether the manifesto's rewritten principle wording should become the new canonical principles for the skill suite, and whether that would require a self-targeting rerun.

**Agent interpretation:** Compare the manifesto to the current skillset `PRINCIPLES.md`, separate rhetorical improvements from normative/specification changes, and decide what process is warranted. Do not make speculative skill changes without first determining whether the doctrine itself actually changed.

**Scope & constraints:** Focus on doctrine sync between `c:\git\tps-manifesto\MANIFESTO.md` and `c:\Users\admin\.copilot\skills\PRINCIPLES.md`. Do not treat article framing, publication metadata, or public-facing persuasion text as automatically canonical for the skill suite.

## Exchange Log

**[Grasp]** Read `skills/PRINCIPLES.md`, `skills/kata/SKILL.md`, `skills/TRAIL/SUMMARY.md`, `skills/TRAIL/GENBA.md`, `skills/SCORECARD.md`, and `tps-manifesto/MANIFESTO.md`.

**[Compare]** The manifesto is a public-facing article. It is narrower and more rhetorical. The skillset `PRINCIPLES.md` is the canonical spec and is materially richer: it includes the evidence-resolution requirement, explicit scope clarification, ARF, preconditions, implementation note, and skill-author obligations that the manifesto either compresses or omits.

**[Compare]** The manifesto contains clearer public phrasing in places (for example, concise Principle 2 framing and the "three principles, one closed loop" articulation), but these are mostly communication improvements, not doctrinal expansions.

**[Compare]** No clear case was found for wholesale copying manifesto text into `skills/PRINCIPLES.md`. Doing so would likely delete important specification detail and downgrade the principles file from constitution to article.

**[!DECISION]** Do **not** copy the manifesto wholesale into the skillset principles. Treat the manifesto as a public exposition and `skills/PRINCIPLES.md` as the canonical constitutional/specification document.

**[!DECISION]** Only propagate manifesto changes into the skills repo if they represent a genuine doctrinal improvement: a semantic correction, ambiguity reduction, or sharper normative statement that the current `PRINCIPLES.md` lacks. Wording that is merely more elegant or persuasive stays in the manifesto.

**[!DECISION]** A self-targeting Kata rerun is warranted **only if** `skills/PRINCIPLES.md` is actually changed semantically. Reason: changing the principles changes the suite's constitution, so the skills must then be re-validated against that new constitution. If no semantic principle change is adopted, rerunning Kata on the suite would be churn rather than evidence.

**[!REALIZATION]** The right process is not "manifesto got better, therefore copy it back." The right process is: manifesto wording becomes a candidate delta source; accepted doctrinal deltas are ported selectively; then the suite is rerun because its governing spec changed.

**[Recommended next step]** Run a deliberate delta pass with three buckets: (1) manifesto wording worth adopting into `PRINCIPLES.md`; (2) wording that belongs in README/public docs only; (3) article-only rhetoric that should not enter the spec. Only after bucket (1) produces actual principle edits should Kata self-target the suite again.
