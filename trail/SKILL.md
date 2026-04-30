---
name: trail
version: 1.3.0
description: 'Evidence trail management. Append a structured entry to trail/log.md IN THE TARGET REPO ROOT at the end of every substantive session — recording the interpretation of the ask, examination, decisions, actions, and reflection. The implementation of Observable Autonomy — autonomy without evidence is not delegation, it is abdication. USE WHEN: any substantive autonomous work that produces decisions, changes, or findings.'
argument-hint: 'The target being worked on (repo, file, system) — used to populate the log entry header'
---

# Trail

*The record of what actually happened.*

> **Governing principle:** [Observable Autonomy](../PRINCIPLES.md#principle-2-observable-autonomy) — *The degree of autonomy a system deserves is bounded by the degree of transparency it provides.* This skill is how that transparency is produced.

Autonomy without evidence is abdication. When an agent does work autonomously, the question is never "did it do something?" but "can someone who wasn't there reconstruct what happened, why, and whether to trust it?"

A trail that answers this earns the right to more autonomy. A trail that doesn't — or doesn't exist — means autonomy must be constrained regardless of how competent the work was.

```
Evidence → Trust → Autonomy
```

---

## The Structure

The trail lives in the **root of the target repo being worked on** — not in the skills install directory.

If you are improving `c:\git\clikit`, the trail is `c:\git\clikit\trail\log.md`.
If you are improving `~/projects/myapp`, the trail is `~/projects/myapp/trail/log.md`.

Every repo gets its own trail. The trail is local evidence for that project — it belongs with the project.

One file: `trail/log.md` in the target repo root. Append-only. One `##` entry per session, newest at the bottom.

If `trail/log.md` does not exist yet, initialise the trail now:

1. Create `trail/log.md` with this header:

```markdown
# Trail log

Append-only ledger of autonomous operations on this repo. Newest entries at the bottom.

---
```

2. Copy `record.py` from the skills install directory (`tools/record.py` next to this SKILL.md) into `trail/record.py` in the target repo. This gives the project a self-contained history viewer — no dependency on the global skills install.

After initialisation, the user can run `python trail/record.py history` from the repo root to see the improvement timeline.

After every session that appends a new entry to `log.md`, also regenerate the committed history view:

```
python trail/record.py history --write
```

This writes `trail/history.md` — a markdown summary of all runs that renders cleanly on GitHub. Commit it alongside `log.md` so anyone viewing the repo can see the improvement record without running anything.

```
trail/
  log.md          — append-only ledger, one entry per session (the source of truth)
  history.md      — auto-generated readable summary (regenerated each run)
  record.py       — history/summary viewer (copied from skills tools/)
  sessions/       — optional: full verbatim transcripts, linked from log entries
```

Each entry in `log.md` follows this shape:

```markdown
## YYYY-MM-DD — <slug>

- target: <what was worked on>
- operator: <who initiated>
- agent: <model / provider>
- skill: <which skill was applied>
- outcome: <what resulted>
- delta: <version before → after, or a one-line summary of change>

### Interpretation of the ask

<What was asked for, verbatim or as close as possible. What the agent understood it to mean.
If Intent was applied, paste its narration here.>

### Examination

<What was looked at. What each lens revealed — including "nothing actionable.">

### Decision

[!DECISION] <choice made, rationale, alternatives rejected>

### Action

<What was done. Reasoning shown, not just the diff.>

### Reflection

<Is the loop converging or churning? What would the next run look at?>
```

---

## Three markers

Insert these inline wherever they occur — inside any section, not only Decision:

**`[!DECISION]`** — A choice that could have gone differently. Always include rationale and at least one rejected alternative.

**`[!REALIZATION]`** — Something discovered during the work that changed understanding.

**`[!REVERSAL]`** — A decision made and then undone. Reversals are more valuable than decisions — they show the reasoning evolved.

```markdown
[!DECISION] Collapsed six skills to two.
Rationale: the framework's mechanism contradicted its own first principle.
Alternative: keep all six, add cross-references — rejected, complexity without payoff.

[!REALIZATION] The debug log captures zero conversation content — only session_start metadata.

[!REVERSAL] Initially planned to keep the PowerShell scripts. Reversed after confirming
they bind the suite to one OS for no reason a few hundred lines of Python won't satisfy.
```

To find every load-bearing decision across all sessions:

```sh
grep -rn '\[!DECISION\]\|\[!REALIZATION\]\|\[!REVERSAL\]' trail/sessions/
```

---

## Three resolutions

The trail must be readable at three levels simultaneously — because different observers have different time budgets:

| Resolution | Where | Time budget | Answers |
|---|---|---|---|
| **Digest** | The `outcome` and `delta` fields in `log.md` | 30 seconds | What just happened? Should I be concerned? |
| **Indexed** | The `[!DECISION]` / `[!REALIZATION]` / `[!REVERSAL]` markers | minutes | What was decided, when, and why? |
| **Full** | `sessions/*.md` — verbatim transcripts | hours | The complete reasoning, including dead ends |

A trail at only one resolution is observable to one class of observer and invisible to the rest.

---

## Fidelity

Mark every session transcript with its fidelity level:

- **verbatim** — exported directly from the platform. Exact dialogue preserved. Highest trust.
- **reconstructed** — recreated from memory. Decisions and outcomes reliable; exact wording approximate.
- **mixed** — verbatim tool outputs with reconstructed narrative.

A summary written by the audited party is evidence, but it is not independent evidence. Mark it as such.

---

## When to write an entry

Every session where substantive work happens. If the work produces decisions, changes, or findings, it produces a log entry. No autonomous session is invisible.

Write during the session, not after. A trail written from memory compresses and rationalises. The markers belong in context, at the moment the decision or reversal occurs.

---

## What this skill is not

**Not a log of events.** A log records what happened. A trail records why — the reasoning that made the action the right choice. Without the why, an observer can see the diff but cannot judge whether it was correct.

**Not a post-hoc summary.** Better than nothing. Not the same as a trail written in real time.

**Not overhead.** The three markers take seconds. The cost of skipping them is discovering months later that no one can reconstruct why a critical decision was made.

---

## The test

Can someone who was not present reconstruct what was done, why each significant decision was made, and whether the work achieved what was asked for — using only `trail/log.md` and the linked sessions?

If yes, the trail is sufficient. If no, something is missing.

---

## Composing with other skills

Trail works standalone. When Intent is also active, paste its narration verbatim into the "Interpretation of the ask" section of the log entry — this is how context carries across sessions. When Improve or Probe is also active, the log entry records what that skill examined and decided.

The `tools/record.py` script can stub a new entry for you:

```sh
python tools/record.py new --slug=<slug> --target=<target> --skill=trail
```
