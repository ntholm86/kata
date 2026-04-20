# Worked Example: Delegability Contract On `datakit`

This is a concrete example of the delegability contract applied to a real external target.

The target was `c:\git\datakit`, a small Python library for data validation and transformation utilities.

## 1. Mission

Apply the clarified Kata suite to a real external target and see whether it can identify a concrete, explainable improvement while producing evidence a human can review later.

## 2. Scope Of Authority

The agent was allowed to:

- inspect the target code and tests
- run the target's test suite
- make a narrow code change if a real defect or ambiguity was found
- add regression tests
- write target-local trail artifacts (`TRAIL/`, `GENBA.md`, changelog note)

The agent was **not** asked to:

- redesign the project wholesale
- commit the target repo
- expand scope beyond a first worked example

## 3. Context And Inputs

- Target README describing `datakit` as lightweight data utilities
- Source files in `src/datakit/`
- Existing tests in `tests/`
- Clarified skills suite in `c:\Users\admin\.copilot\skills`
- Kiroku tooling in `c:\git\kiroku`

## 4. Digest

`datakit` was structurally simple and did not need redesign.

The first meaningful defect found was a validation ambiguity caused by Python semantics:

- `is_positive_number(True)` returned `True`
- `validate_schema({"age": True}, {"age": int})` returned no errors

That behavior is technically consistent with Python's `bool` subclassing `int`, but it is a poor fit for a data-validation library. The fix was to reject booleans in those validation paths and add explicit tests. The result verified cleanly at 89 passing tests.

## 5. Decision Index

See the target-local decision index:

- `c:\git\datakit\TRAIL\INDEX.md`

Key decisions were:

1. Use `datakit` as the first external target.
2. Treat bool/int ambiguity in validation as the first Kaizen fix.
3. Keep the fix narrow and regression-tested.

## 6. Full Evidence Location

The full target-local evidence lives in:

- Session transcript: `c:\git\datakit\TRAIL\sessions\2026-04-20-delegability-contract-worked-example.md`
- Executive summary: `c:\git\datakit\TRAIL\SUMMARY.md`
- Run ledger: `c:\git\datakit\GENBA.md`

## 7. Assumptions And Uncertainty

- Assumption: for a validation library, users expect `bool` to be distinct from numeric input in positive-number and integer-schema checks.
- Assumption: a narrow fix is better than broad redesign for the first worked example.
- Uncertainty: this first run does not prove broad external efficacy across harder domains; it proves the clarified suite can transfer to at least one small real target.

## 8. Verification Status

- Baseline before changes: 87 tests passed
- Final verification after changes: 89 tests passed
- Trail validation: `kiroku-validate.ps1` reported 0 failures and 0 warnings for the `datakit` trail after a small PowerShell-5.1 compatibility fix in the validator itself

## 9. Challenge Path

A human can challenge the run by:

- inspecting the changed code in `src/datakit/validate.py`
- reviewing the new tests in `tests/test_validate.py`
- replaying the reasoning from the target-local session transcript
- disagreeing with the assumption that `bool` should be rejected for integer validation in this library

If that assumption is rejected, the fix should be revisited rather than silently accepted.

## 10. Revocation Rules

In this run, revocation would have meant narrowing or stopping the agent if:

- the code change required broader redesign than a first Kaizen pass justified
- tests failed or introduced regressions
- the trail could not be reconstructed after the fact
- the finding turned out to be speculative rather than demonstrable

None of those happened, so autonomy remained within its narrow scope.

## 11. Outcome Record

- Files changed: `src/datakit/validate.py`, `tests/test_validate.py`, `CHANGELOG.md`
- Files added for evidence: `GENBA.md`, `TRAIL/INDEX.md`, `TRAIL/SUMMARY.md`, `TRAIL/sessions/2026-04-20-delegability-contract-worked-example.md`
- Result: bool/int ambiguity in validation removed, regression tests added, project verified at 89 passing tests
- Git note: the target repo was not committed during this run

## Why This Example Matters

This example is small on purpose.

It shows the contract on a real target without hiding behind abstraction:

- a concrete mission
- bounded authority
- visible reasoning
- explicit uncertainty
- executable verification
- a human-reviewable trail

That is the point of delegability in practice.