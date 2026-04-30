# Installing the skills

## How VS Code Copilot discovers skills

Copilot looks for skills at exactly **one level deep** under `.copilot/skills/`:

```
.copilot/
  skills/
    intent/
      SKILL.md     ← found
    improve/
      SKILL.md     ← found
    some-folder/
      subfolder/
        SKILL.md   ← NOT found (too deep)
```

**This means: do not drop the entire repo folder into your skills directory.** That adds an extra nesting level and Copilot finds nothing. Copy the individual skill folders directly.

---

## Minimum install (one skill)

To get started with just the Intent skill:

```
your-repo/
  .copilot/
    skills/
      intent/
        SKILL.md
```

No sibling files required. Each skill is self-contained as of v3.3.1.

---

## Full install (all four skills)

```
your-repo/
  .copilot/
    skills/
      intent/
        SKILL.md
      improve/
        SKILL.md
      probe/
        SKILL.md
      trail/
        SKILL.md
      tools/
        record.py
        verify.py
```

Optionally copy `PRINCIPLES.md` and `CONVERGENCE_SCOPE_PROTOCOL.md` next to the skill folders — the skills reference them but work fully without them (the principles are inlined in each SKILL.md).

---

## What each skill needs at runtime

All four skills work with only their own `SKILL.md`. No required sibling files.

| Skill | Optional sibling files |
|---|---|
| **intent** | `PRINCIPLES.md` (cross-reference link; content is inlined) |
| **improve** | `PRINCIPLES.md`, `CONVERGENCE_SCOPE_PROTOCOL.md` |
| **probe** | `PRINCIPLES.md` |
| **trail** | nothing — creates `trail/log.md` on first use |

---

## The trail — where it lives and how to use it

The trail is **per project**. It lives in the root of the repo being worked on — not inside `.copilot/skills/`.

When the trail skill runs for the first time on a project it creates a single file:
`<repo-root>/trail/log.md` (the append-only evidence log).

Nothing else gets installed into the target repo. `record.py` stays in the skills install and is invoked from there — it writes into the current working directory by default, or whatever `$TRAIL_ROOT` points to.

After every run that adds an entry to `log.md`, regenerate the readable summary **from the target repo root**:
```
python <skills>/tools/record.py history --write    # writes trail/history.md
```
Replace `<skills>` with your skills install path (e.g. `~/.copilot/skills`).

For ad-hoc viewing:
```
python <skills>/tools/record.py history    # timeline to stdout
python <skills>/tools/record.py summary    # digest of the most recent run
```

Commit `trail/log.md` and `trail/history.md`. **Do not** commit `record.py` to the target repo — it lives in the skills install only.

### Multi-iteration runs

Each iteration is a separate trail entry. The commit sequence is:

```
iteration 1 → append trail entry → record.py history --write → commit
iteration 2 → append trail entry → record.py history --write → commit
...
```

Append and commit **before** starting the next iteration. A partial run (agent crashes, user stops at iteration 4 of 10) must produce partial trail — batch writing at the end of all iterations defeats the purpose.

---

## Using a skill

Once installed, type `/intent`, `/improve`, `/probe` in the Copilot chat to invoke a skill directly. Or just describe your task — skills whose `description` field matches will be suggested automatically.

Example:
```
/improve review the checkout module for waste and overburden
```

---

## Updating

Skills are just markdown files. Replace the SKILL.md files with newer versions to update. The trail log is separate from the skills and does not change when you update.
