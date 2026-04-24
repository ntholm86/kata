# Trail format

A single append-only markdown file (`log.md`) is the trail for this suite. Every autonomous operation adds an entry. Entries are never edited or deleted; corrections are appended as new entries that reference the entry being corrected.

## Why one file

v2 maintained three files (TRAIL/sessions/, GENBA.md, SCORECARD.md) because Principle 2 requires multi-resolution evidence. The mistake was conflating *resolution* with *file count*. Resolution is a property of content (full vs indexed vs digested) — it does not require separate files. Three files meant three parsers, three drift surfaces, and several runs spent reconciling them.

In v3, multi-resolution lives within `log.md`:

- **Full evidence** — the entry body. Reasoning, decisions, verification.
- **Indexed evidence** — `[!DECISION]`, `[!REVERSAL]`, `[!REALIZATION]` markers a reader can grep for.
- **Digested evidence** — `tools/record.py summary` prints a 60-second view of the latest entry.

## Entry format

Every entry begins with a level-2 heading containing the date and a short slug, followed by metadata, then the body. Example:

```markdown
## 2026-04-23 — v3 redesign

- target: skills repo
- operator: maintainer
- agent: Claude (Anthropic, tool-call ID prefix `toolu_*`)
- skill: improve
- outcome: redesign argued and executed
- delta: v2.4.1 → v3.0.0 (branch v3-redesign, not yet merged)

### Interpretation of the ask

[narrate what you understood the operator to be asking]

### Examination

[lenses applied; what each revealed]

### Decision

[!DECISION] [the chosen course and why]

### Action

[what was changed; verification evidence]

### Reflection

[is the loop converging or churning; any surprises]
```

## Rules

1. **Append only.** Never edit or delete an entry. Corrections are new entries that reference the entry being corrected by date and slug.
2. **One entry per autonomous operation.** Not per file change. An operation is a complete cycle of examine-decide-act-verify-record.
3. **Mark moments inline.** `[!DECISION]`, `[!REVERSAL]`, `[!REALIZATION]` go in the prose where they happen. Readers grep for them.
4. **Mark fidelity.** If reconstructing rather than capturing verbatim, write `(reconstructed from agent memory)` at that point. Do not silently degrade.
5. **Identify the agent.** Provider name and (where observable) tool-call ID prefix. This is how cross-model convergence claims become checkable.
6. **Date entries in ISO format** (`YYYY-MM-DD`). For multiple entries on one day, suffix the slug, not the date.

## Tools

- `tools/record.py new --slug=<slug>` — append a stub entry to `log.md`.
- `tools/record.py summary` — print a 60-second digest of the latest entry.
- `tools/verify.py` — check trail integrity (chronological order, mandatory metadata fields present).

Both scripts are pure Python 3 with no third-party dependencies. They run on Windows, macOS, and Linux.

## Reading convergence state from the log

v2 tracked convergence in a separate `SCORECARD.md` with a counter row. v3 reads the same information from `log.md` directly. The chain length is:

> the number of consecutive most-recent entries whose `outcome` is silence (no material change to the artifact) **and** whose `agent` field names a distinct provider/family from the entry before it.

A chain reaches **3/3 (converged)** when three such entries exist in a row, from three distinct evaluator families, each performed in a fresh conversation (i.e. independent assessment per Principle 3, condition 3). Any entry whose `outcome` records a change to the artifact resets the chain to zero — regardless of whether the change improved a score.

The chain has no separate counter file. It is a property of the log.

Convergence is always relative to declared mission intent, not text stability alone. Each entry should therefore state which layer is being evaluated (problem, principles, skills, or cross-layer coherence) and why that run contributes to the publication claim. A silence run that does not specify this can show local cleanliness, but it does not by itself demonstrate research-level completion.

Convergence runs must apply [CONVERGENCE_SCOPE_PROTOCOL.md](../CONVERGENCE_SCOPE_PROTOCOL.md) during Grasp. If the protocol is not read, the run can still be useful diagnostics but should not be counted as a convergence-advancing evaluation.
