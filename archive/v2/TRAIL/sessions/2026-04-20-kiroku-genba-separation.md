---
fidelity: reconstructed
source: agent-memory
date: 2026-04-20
started: 2026-04-20T10:29:08+02:00
participants: [human, Claude Opus 4.6]
session-id: 1a9b107d-4542-4fc6-85af-100a58e59d36
project: C:\Users\admin\.copilot\skills
status: completed
closed: 2026-04-20T10:30:30+02:00
---

# Session: kiroku-genba-separation

**Started:** 2026-04-20T10:29:08+02:00
**Participants:** human, Claude Opus 4.6
**Fidelity:** reconstructed - exchanges are captured from agent context, not verbatim platform export.

## Trigger

Kiroku assumes too much about what's being worked on. GENBA.md with run entries, methodology fields, and 3M tables is Kata-specific. Kiroku should be a standalone evidence skill usable for any domain — legal, hiring, design, not just software improvement.

## Intent

**Human intent (verbatim):**
"Kiroku is a global and standalone skill and should be able to work like that — but also work into Kata. Running Kiroku without any other skills should result in the audit trace — and the trace that kiroku produces when running alone should be general for whatever is being worked on. If genba is specific for a software application fx. then maybe kiroku already assumes too much in what is being worked on."

**Agent interpretation:**
Separate GENBA.md ownership from kiroku to Kata. Kiroku's trail is: sessions/ + INDEX.md + SUMMARY.md + README.md. GENBA.md is a methodology-specific run ledger that Kata creates and maintains. kiroku-validate should treat GENBA as optional.

**Scope & constraints:**
- kiroku/SKILL.md, kata/SKILL.md, kiroku-validate.ps1 only
- No script logic changes beyond the GENBA validation check
- Must not break existing trails that already have GENBA

## Exchange Log

[!DECISION] Move GENBA.md ownership from kiroku to Kata
Rationale: GENBA contains methodology-specific fields (run number, 3M diagnosis, methodology selection) that only make sense in Kata's improvement context. A standalone kiroku trail for non-software work (legal review, hiring, design sprint) would never produce a GENBA. Kiroku's job is evidence capture (sessions + decisions + summary). Kata's job is improvement methodology — GENBA is its run ledger.
Alternatives: Keep GENBA in kiroku but make it generic (rejected — a generic "run ledger" is just a worse SUMMARY.md). Remove GENBA entirely (rejected — it serves Kata well, just doesn't belong to kiroku).
