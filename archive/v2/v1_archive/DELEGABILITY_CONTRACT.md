# Delegability Contract

*Draft v0.1*

## Purpose

This is not a transport protocol.
It is the minimum contract an autonomous system should expose before a human can responsibly grant it meaningful authority.

The central question is not only "can the AI do the task?"

It is also:

**What evidence allows a human to let it act, for this scope, right now?**

## The Minimum Contract

### 1. Mission

What is the agent trying to achieve, and why does it matter?

This is the Commander's Intent layer.
Without it, observers cannot judge whether the behavior matches the purpose.

### 2. Scope Of Authority

What may the agent do on its own?
What requires approval?
What is forbidden?

Without explicit scope, trust becomes vague and dangerous.

### 3. Context And Inputs

What facts, documents, tools, and constraints shaped the work?

Without this, observers cannot tell whether the reasoning started from the right materials.

### 4. Reasoning Trail

Evidence must exist at three levels:

- **Digest:** a fast summary for a busy human
- **Index:** the key decisions, realizations, and reversals
- **Full evidence:** the detailed trail needed for replay and audit

Without multi-resolution evidence, observability works for one observer class and silently fails for the others.

### 5. Assumptions And Uncertainty

What is inferred?
What is missing?
What remains weakly supported?

Without explicit uncertainty, the trail becomes theater.

### 6. Verification Status

What checks, tests, reviews, or independent validations support the result?
Who performed them?
How fresh are they?

Without this, trust becomes a claim rather than an earned judgment.

### 7. Challenge Path

How can a human inspect, question, pause, override, or narrow the agent's authority?

If there is no clear challenge path, the system is asking for abdication rather than delegation.

### 8. Revocation Rules

What events reduce or remove authority?

Examples:

- the task moves out of scope
- the evidence trail is missing or degraded
- verification fails
- uncertainty exceeds the accepted boundary
- a human contests the reasoning

If revocation is undefined, autonomy can only expand and never contract.

### 9. Outcome Record

What changed?
What did not change?
What risks remain?

Without a clear outcome record, observers cannot connect authority to consequences.

## Minimal Template

```text
Mission:
Scope of Authority:
Context and Inputs:
Digest:
Decision Index:
Full Evidence Location:
Assumptions and Uncertainty:
Verification Status:
Challenge Path:
Revocation Rules:
Outcome Record:
```

## Reference Implementation In This Repo

This repository currently implements the contract like this:

- **Mission:** [PRINCIPLES.md](PRINCIPLES.md) and task intent framed through Commander's Intent
- **Work routine:** Kata
- **Reasoning trail:** Kiroku sessions, TRAIL index, TRAIL summary, GENBA
- **Verification:** `verify-suite.ps1`, `INTEGRITY.json`, cross-model validation, SCORECARD
- **Stopping condition:** Convergence Is Silence

This is a reference implementation, not the only valid one.

## Other Valid Implementations

The same contract could be expressed through other architectures, for example:

- a medical case system with patient-level trails and human sign-off
- a workflow engine with immutable event logs and reviewer checkpoints
- a signed API envelope that returns mission, scope, evidence, and revocation metadata with every autonomous action
- an operations dashboard that gives at-a-glance state with drill-down to indexed and full evidence
- a secure recorder for agent sessions that preserves challenge and override events automatically

The form can change.
The contract cannot.

## Why This Matters

The goal is not only to make autonomous AI powerful.

The goal is to make its authority explainable, challengeable, and revocable.

That is what makes autonomy delegable.