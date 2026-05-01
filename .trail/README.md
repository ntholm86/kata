# Audit Trail

This directory is the audit trail for autonomous agent operations on this repository. It is the reference implementation of the [Observable Autonomy](../PRINCIPLES.md) principle's resolution requirement.

## The three resolutions

The manifesto's `PRINCIPLES.md` requires that evidence exist at three resolutions simultaneously: **Digest** (60-second view), **Indexed** (decisions navigable in bounded time), and **Full** (complete reasoning, ground truth). Three resolutions, not three files — the indexed layer lives *within* the full layer.

| Resolution | Where it lives | Time budget | Answers |
|---|---|---|---|
| **Digest** | `.trail/log.md` | 30–60 seconds | Where is this going? What just happened? |
| **Indexed** | `[!DECISION]`, `[!REALIZATION]`, `[!REVERSAL]` markers inside `.trail/log.md` (and `.trail/sessions/*.md` if used) | minutes | What was decided, when, and why? |
| **Full** | `.trail/sessions/*.md` | hours | The complete reasoning exchange — prompts, responses, dead ends, reversals |

### Reading the indexed layer

The indexed layer is recovered by grep, not by a separate file. From the repo root:

```sh
grep -rn '\[!DECISION\]\|\[!REALIZATION\]\|\[!REVERSAL\]' .trail/
```

This returns every load-bearing turning point across all sessions, with file and line, in seconds. The markers are inserted by the operating agent during the session, in context, so the rationale lives one paragraph away rather than in a separately-curated index that can drift.

## The four skills

The suite has four skills:

- **intent** — state the agent's interpretation of the ask before work begins. Catches misreading early.
- **improve** — examine a target, find what most needs changing, change it (or argue for radical redesign), verify, and record. The core autonomous loop.
- **probe** — construct a novelty probe that distinguishes genuine situated reasoning from pattern-matching against a checklist.
- **trail** — append a structured evidence entry to `trail/log.md` after every session. Implements Observable Autonomy.

Earlier versions of this suite (v1, v2) had more skills with Japanese vocabulary (Kata, Kaizen, Kaikaku, Hansei, Mura, Muri, Muda, Intent). v3.0.0 collapsed them into two (improve and probe). v3.2.0 re-extracted intent and trail as standalone first-class skills. The full history is preserved in `archive/v2/` and the v2 tags.

## Fidelity levels

Session transcripts are marked with a fidelity level:

- **verbatim** — exported directly from the chat platform. Exact dialogue preserved. Highest trust.
- **reconstructed** — recreated from agent context/memory. Captures decisions, reasoning, and outcomes accurately, but exact wording may differ. Key facts and decisions are reliable; phrasing and sequence may be approximate.
- **mixed** — contains both verbatim tool outputs and reconstructed narrative.

## Integrity

All summaries and digests are self-authored by the agent that produced the work. For independent confirmation, cross-verify claims against the session transcripts (full resolution) and the actual code changes (`git log`).
