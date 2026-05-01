---
name: trail
version: 1.6.0
description: 'Evidence trail management. Append a structured entry to .trail/log.md IN THE TARGET REPO ROOT at the end of every substantive session — recording the interpretation of the ask, examination, decisions, actions, and reflection. The implementation of Observable Autonomy — autonomy without evidence is not delegation, it is abdication. USE WHEN: any substantive autonomous work that produces decisions, changes, or findings.'
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

If you are improving `c:\git\clikit`, the trail is `c:\git\clikit\.trail\log.md`.
If you are improving `~/projects/myapp`, the trail is `~/projects/myapp/.trail/log.md`.

Every repo gets its own trail. The trail is local evidence for that project — it belongs with the project.

One file: `.trail/log.md` in the target repo root. Append-only. One `##` entry per session, newest at the bottom.

If `.trail/log.md` does not exist yet, initialise it:

Create `.trail/log.md` with this header:

```markdown
# Trail log

Append-only ledger of autonomous operations on this repo. Newest entries at the bottom.

---
```

That's it. Nothing else gets installed into the target repo. `record.py` lives in the skills install (`tools/record.py` next to this SKILL.md) and is invoked from there — it writes into the current working directory by default, or whatever `$TRAIL_ROOT` points to.

After appending to `log.md`, two more steps are **mandatory before the next iteration begins**:

**Step 1 — regenerate history** (from the target repo root):
```
python <skills>/tools/record.py history --write
```
Replace `<skills>` with the absolute path to the skills install (e.g. `~/.copilot/skills` or `%USERPROFILE%\.copilot\skills`). This writes `.trail/history.md` — a readable summary of all runs. Do not skip this step.

**Step 2 — commit both files**:
```
git add .trail/log.md .trail/history.md
git commit -m "trail: <slug>"
```

Both `.trail/log.md` and `.trail/history.md` must be committed together. `history.md` is generated from `log.md` — if only one is committed they will diverge. If Retrospect ran this session and updated `.trail/model.md`, commit it in the same commit.

For ad-hoc viewing in the terminal:

```
python <skills>/tools/record.py history    # timeline to stdout
python <skills>/tools/record.py summary    # digest of the most recent run
```

```
.trail/
  log.md          — append-only ledger, one entry per session (the source of truth)
  history.md      — auto-generated readable summary (regenerated each run)
  model.md        — current working model of the target (written by Retrospect, read by Improve)
  sessions/       — optional: full verbatim transcripts, linked from log entries
```

Both files are committed. `record.py` is **not** committed to the target repo — it stays in the skills install.

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

<Reflection is about the target, not about the loop. At minimum: an updated model
of the target as a falsifiable claim a future run could disagree with, a named
blind spot in this iteration, and what someone who knows the target better would
push back on. If across-trail reflection was triggered (recurring class of
finding, about to declare silence, prior [!REALIZATION] contradicted, or
operator asked), also include an arc-claim about the target read from the trail
as a whole. Mark material insights with [!REALIZATION].>
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
grep -rn '\[!DECISION\]\|\[!REALIZATION\]\|\[!REVERSAL\]' .trail/
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

### Multi-iteration runs

**Each iteration is a separate trail entry. Append it immediately after that iteration completes — before beginning the next iteration.**

Do not buffer entries to write at the end of all iterations. The trail is the checkpoint: if the agent crashes, times out, or the user stops the run after iteration 3 of 10, the first 3 entries must already be committed to `log.md`.

The mandatory sequence per iteration:

```
iteration 1:
  1. append entry to .trail/log.md
  2. python <skills>/tools/record.py history --write   ← updates .trail/history.md
  3. git add .trail/log.md .trail/history.md && git commit -m "trail: <slug>-1"
  ↓ only now begin iteration 2

iteration 2:
  1. append entry to .trail/log.md
  2. python <skills>/tools/record.py history --write
  3. git add .trail/log.md .trail/history.md && git commit -m "trail: <slug>-2"
  ↓ only now begin iteration 3
...
```

Do not begin the next iteration until steps 1–3 are complete. Each commit is a checkpoint — if the agent crashes or the user stops after iteration 3 of 10, the first 3 entries are already committed in both files. Batching at the end defeats this.

---

## What this skill is not

**Not a log of events.** A log records what happened. A trail records why — the reasoning that made the action the right choice. Without the why, an observer can see the diff but cannot judge whether it was correct.

**Not a post-hoc summary.** Better than nothing. Not the same as a trail written in real time.

**Not overhead.** The three markers take seconds. The cost of skipping them is discovering months later that no one can reconstruct why a critical decision was made.

---

## The test

Can someone who was not present reconstruct what was done, why each significant decision was made, and whether the work achieved what was asked for — using only `.trail/log.md` and the linked sessions?

If yes, the trail is sufficient. If no, something is missing.

---

## Composing with other skills

Trail works standalone. When Intent is also active, paste its narration verbatim into the "Interpretation of the ask" section of the log entry — this is how context carries across sessions. When Improve or Probe is also active, the log entry records what that skill examined and decided.

The `<skills>/tools/record.py` script can stub a new entry for you:

```sh
python <skills>/tools/record.py new --slug=<slug> --target=<target> --skill=trail
```
