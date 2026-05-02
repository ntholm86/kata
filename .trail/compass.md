# Compass -- autonomous-agent-skills

_Last updated: 2026-05-02 (run: retrospect-first-real-run)_
_Derived from: full arc read, runs 55-71. Vision read first (step 0)._

---

## Current claims

**1. Phase boundary crossed: documentation-convergence to validated-capability.**
Runs 55-63 were documentation propagation after structural changes. Runs 64-71 added four structural capabilities (Retrospect, compass/vision split, Hunch, .trail/ directory discipline) and validated three of them against real targets. The suite is no longer converging on a stable design -- it is proving a live design against external evidence. The convergence baseline at v3.1.0 does not apply to the current suite; a new convergence cycle has not yet started.

**2. The validation gap has shifted from Hunch to Retrospect.**
Every prior compass entry named "Hunch unproven in execution" as the validation gap. As of 2026-05-02, Hunch has confirmed hunches on five runs across four targets (own vision, evo, vectorium, leifoglenedk, manifesto). The falsification condition was met. The current unvalidated claim is: "a Retrospect run produces arc-level findings that an improve loop run in the same session would not." This run is the first real Retrospect execution; it is its own validation event.

**3. The loop still has no occasion-independence -- every structural change in runs 64-71 was operator-prompted.**
The trail names this repeatedly (runs 68, 71) but no run has resolved it. Hunch was designed to reduce operator-prompting dependency; it has reduced content dependency (agent surfaces direction rather than waiting for operator to articulate it) but not occasion dependency (operator still creates the moment). Whether Hunch will eventually surface direction questions without being invoked is an open empirical question.

**4. The two-repo relationship (manifesto = principles layer, skills = one domain conformance) is now tracked at the trail level but not yet reflected in either repo's README.**
The manifesto's .trail/vision.md names this relationship explicitly. Neither repo's README explains it to an incoming reader. This is a documentation gap that is now strategically important as the operator moves toward SOLID-like recognition for the principles.

**5. The skills suite is specifiable and composable but has never been run by a harness that did not co-evolve with it.**
Vision names this as a hard requirement before integration with evo or any other harness. No evidence exists yet that the skills work cleanly when invoked by a system that did not participate in their design. This remains the most important unvalidated claim in the entire research bet.

---

## What the next runs should test

1. **Retrospect self-validation:** Does this Retrospect run produce claims an Improve run this session would not have produced? This run itself is the first data point.
2. **Commit pending mechanical debt:** POSITION.md fix, CHANGELOG v3.15.1 entry, manifesto .trail/ commit, trail entry for this session.
3. **Manifesto PROOF.md rewrite:** restructure from "Nils tested this once" to "here is what conformance looks like and how you would test it in your own context." Highest-leverage move for the recognition goal.
4. **README relationship statement:** Both repos need a sentence explaining the two-repo structure to an incoming reader.
5. **One external proof:** run the protocol on a target where the AI exceeds the operator on the underlying task and the operator is not the author.

---

## Loop-effectiveness notes

The loop is executing correctly as a structural-tightening and validation mechanism: every gap surfaced this session was found, fixed, and committed. The loop is not yet functioning as an independent finding mechanism -- direction has consistently been operator-supplied. This is honest for the current phase (design and validation, not convergence), but should be named. The operator-prompting dependency is structural, not accidental -- the trail names it in [!REALIZATION] markers in runs 68 and 71, and it has persisted across two sessions without resolution.