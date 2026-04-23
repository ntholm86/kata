# Plain-Language Thesis

## In One Sentence

AI will only be adopted deeply in consequential domains when it can both reason about what to do and show humans enough of that reasoning for authority to be granted responsibly.

## The Simple Problem

The real barrier is not only whether AI can produce good answers.

The real barrier is whether a human, team, or institution can justify letting the AI act.

That is the adoption problem.

## The Two Problems

### 1. The reasoning problem

Is the AI actually interpreting the mission and adapting to the situation, or is it only following a clever script?

### 2. The trust problem

Can a human see enough of what the AI did, why it did it, and where it was uncertain to decide whether to trust it, challenge it, or stop it?

These two problems must be solved together.

- An AI that may be reasoning but cannot be inspected is hard to delegate.
- An AI that is fully visible but only follows a script is easy to inspect but brittle when reality changes.

## Our Core Claim

Autonomous AI becomes adoptable when it becomes **delegable**.

That means:

- the AI receives a mission, not a rigid script
- the AI's reasoning trail is visible
- the AI's authority is bounded
- humans can challenge, narrow, or revoke that authority
- trust grows only when the evidence supports it

The key chain is:

`Intent -> Reasoning -> Evidence -> Trust -> Authority`

Everything else in this project exists to make that chain real.

## What This Project Currently Does

This repository currently implements that idea in one specific way.

- **Commander's Intent** gives the AI a clear objective and constraint without prescribing every step.
- **Kata** gives the AI a disciplined routine for how to approach work.
- **Kiroku** records the reasoning trail so a human can inspect the history later.

Together, these are one operational form of a larger idea: **delegable autonomy**.

## Why Explainability Matters So Much

If a normal human cannot explain what the system is doing and why it should be trusted, then the trust architecture is not stable.

This is not just a documentation issue.
It is part of the system.

Good presentation is part of earned trust:

- a busy operator needs an at-a-glance view
- a reviewer needs a navigable decision trail
- an auditor needs the full evidence

If the evidence only works for experts with unlimited time, then the system is not truly observable.

## This Is One Form, Not The Only Form

Commander's Intent + Kata + Kiroku is a reference implementation, not the only possible architecture.

Other systems could satisfy the same principles if they still provide:

- mission over script
- visible multi-resolution evidence
- bounded authority
- human challenge and override
- clear revocation rules
- independent validation

The current implementation is important because it proves one workable form, not because it must be the final form.

## The Long-Term Social Effect

If this works, later generations may trust AI the way they trust other infrastructure.

Most people will not inspect the internals every time.
They will rely on the trust architecture around it.

That is exactly why the trust architecture has to be strong before society becomes comfortable. Blind trust is acceptable only after earned trust has been proven repeatedly and institutionally.

## One Line To Remember

We are not only trying to make AI more capable.

We are trying to make AI more delegable.