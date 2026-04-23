# Audit Trail: skills

This directory contains the complete audit trail for autonomous agent operations on this project.

## How to read this

| Time budget | Start here |
|---|---|
| 30 seconds | **SUMMARY.md** - direction, recent decisions, current state |
| 15 minutes | **INDEX.md** - every decision with rationale, linked to the session that produced it |
| Full review | **sessions/** - complete reasoning transcripts |

## What each file is

- **SUMMARY.md** - Executive digest. Updated after each session. Answers: *where is this headed?*
- **INDEX.md** - Decision index (auto-generated). Every `[!DECISION]` from sessions, extracted with rationale. Answers: *what was decided and why?*
- **sessions/** - Full session transcripts. The ground truth. Answers: *what was the complete reasoning?*

## Glossary

- **Kata** - The orchestration skill that runs an improvement cycle: diagnose the target, select a methodology, execute, record, persist.
- **Kaizen** - Incremental improvement. The target's structure is sound; specific things need fixing.
- **Kaikaku** - Radical redesign. The target's structure cannot reach its goals through incremental changes.
- **Hansei** - Reflection on the improvement loop itself, not the target.
## Fidelity levels

Session transcripts are marked with a fidelity level:

- **verbatim** - Exported directly from the chat platform. Exact dialogue preserved. Highest trust.
- **reconstructed** - Recreated from agent context/memory. Captures decisions, reasoning, and outcomes accurately, but exact wording may differ from the original exchange. Typical accuracy: key facts and decisions are reliable; phrasing and sequence may be approximate.
- **mixed** - Contains both verbatim tool outputs and reconstructed narrative.

## Integrity

All summaries and digests in this trail are self-authored by the agent that produced the work. Cross-verify claims against the session transcripts and the actual code changes (git log) for independent confirmation.