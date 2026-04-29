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
      PRINCIPLES.md                  ← required (copy from repo root)
      intent/
        SKILL.md                     ← copy the intent/ folder
```

Why `PRINCIPLES.md`? The SKILL.md files reference `../PRINCIPLES.md` — i.e., they expect it as a sibling of the skill folder. Without it, the cross-reference is a dead link (the skill still works, but the link is broken).

---

## Full install (all four skills + trail)

```
your-repo/
  .copilot/
    skills/
      PRINCIPLES.md                  ← copy from repo root
      CONVERGENCE_SCOPE_PROTOCOL.md  ← copy from repo root (needed by Improve)
      intent/
        SKILL.md
      improve/
        SKILL.md
      probe/
        SKILL.md
      trail/
        SKILL.md
        README.md
        log.md                       ← start with an empty log (see below)
```

**Starting an empty trail log** — create `trail/log.md` with just the header:

```markdown
# Trail log

Append-only ledger of autonomous operations on this repo. See [README.md](./README.md) for the format spec. Newest entries at the bottom.

---
```

---

## What each skill needs at runtime

| Skill | Required sibling files |
|---|---|
| **intent** | `PRINCIPLES.md` (for the cross-reference link) |
| **improve** | `PRINCIPLES.md`, `CONVERGENCE_SCOPE_PROTOCOL.md` |
| **probe** | `PRINCIPLES.md` |
| **trail** | `trail/log.md` (the append-only ledger) |

The skills work without these files — Copilot will load the SKILL.md regardless. The references just become dead links, and Improve will remind the agent to read the convergence protocol if it's missing.

---

## Using a skill

Once installed, type `/intent`, `/improve`, `/probe` in the Copilot chat to invoke a skill directly. Or just describe your task — skills whose `description` field matches will be suggested automatically.

Example:
```
/improve review the checkout module for waste and overburden
```

---

## Keeping the trail in your repo

The trail (`trail/log.md`) is append-only evidence of every autonomous operation. Commit it to your repo alongside your code — it is the audit record, not a scratch file.

---

## Updating

Skills are just markdown files. To update, replace the SKILL.md files with newer versions. The trail log is separate from the skills and does not need to change.
