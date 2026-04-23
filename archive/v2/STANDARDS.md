# External Standard Alignment

How the TPS Skill Suite maps to recognized process-quality and AI governance standards.
Created Run 36 to make the alignment explicit and the gaps visible.

## Suite tooling — when and how (for skill authors)

The principles in [PRINCIPLES.md](./PRINCIPLES.md) define architectural constraints. The tooling below is how this specific suite *implements* those constraints — it is prescribed, not principled, and belongs here rather than in PRINCIPLES.md.

- **`verify-suite.ps1`** — mechanical integrity checks (encoding, placeholders, cross-references, version alignment, ledger consistency, mojibake sentinels). Run after every Kata/Kaizen cycle. Zero failures required before commit.
- **`INTEGRITY.json`** — file-hash snapshot of skills, standard docs, and verification scripts. Diff-based validation inspired by evo's proof ledger. Stable on no-change runs (no timestamp churn).
- **`metrics.ps1` + `METRICS_HISTORY.md`** — quantitative metrics computed from ledger data and tracked over time. Manual trend comparison; automated alerts are a future enhancement.
- **`SCORECARD.md`** — cross-run trajectory and the scoring rubric. Every Kata run appends to it.
- **`GENBA.md`** — the active run ledger. The primary indexed-resolution evidence for Principle 2.
- **`kiroku/`** — session scripts that capture full-resolution evidence (Intent, Exchange Log, decisions, realizations, reversals) during work.

These artifacts are part of the suite. They are not optional tooling. But they are one implementation of Observable Autonomy, not the specification of it — see PRINCIPLES.md § Autonomous Reasoning Fidelity "Implementation note."

---

## PDCA (Deming Cycle) — Plan-Do-Check-Act

| Phase | Suite Implementation | Status |
|-------|---------------------|:------:|
| **Plan** | Kata Phase 1 (GRASP) + Phase 2 (CHALLENGE): diagnose with 3M lenses, select methodology, rank findings by ROI | Exceeds |
| **Do** | Kata Phase 3 (EXECUTE): run Kaizen or Kaikaku with scoped, prioritized changes | Meets |
| **Check** | Kata Phase 4 (CHRONICLE) + Phase 5 (REFLECT): verify-suite.ps1 mechanical checks, metrics.ps1 statistical analysis, GENBA/SCORECARD ledger recording, trend analysis | Exceeds |
| **Act** | Kata Phase 6 (PERSIST): git commit, version tag. Hansei for meta-reflection on the loop itself | Exceeds |

**Assessment:** The suite is a formalized, instrumented PDCA implementation with statistical process control, multi-evaluator validation, and a meta-improvement layer (Hansei) that PDCA itself does not specify. **Exceeds PDCA.**

---

## DMAIC (Six Sigma) — Define-Measure-Analyze-Improve-Control

| Phase | Suite Implementation | Status |
|-------|---------------------|:------:|
| **Define** | User intent statement (Kata GRASP "Trigger" field), target specification (SCORECARD target column), PRINCIPLES.md as quality policy | Meets |
| **Measure** | metrics.ps1 computes 6 objective metrics from ledger data. SCORECARD tracks scores per run. De-anchored start scores provide independent measurement. Rubric v2 defines 10 measurable dimensions | Meets |
| **Analyze** | 3M diagnostic (Mura/Muri/Muda) with causal chain analysis. Mura-first principle addresses root causes before symptoms. REFLECT phase performs statistical pattern recognition across runs | Exceeds |
| **Improve** | Kaizen (incremental) and Kaikaku (radical) methodologies with ROI-based prioritization. "Fix globally, not locally" rule prevents partial fixes | Meets |
| **Control** | METRICS_HISTORY.md tracks metrics over time. verify-suite.ps1 (13 mechanical checks) runs after every cycle. INTEGRITY.json file-hash snapshots detect drift. Git tags create immutable baselines. Note: automated degradation alerts are not yet implemented — trend detection is manual via snapshot comparison | Meets |

**Assessment:** Full DMAIC coverage. The Analyze phase exceeds Six Sigma's typical root cause analysis by using a structured 3-lens causal framework. The Control phase includes time-series metric tracking (METRICS_HISTORY.md) with manual trend comparison; automated degradation alerts are a future enhancement. **Meets or exceeds DMAIC.**

---

## CMMI (Capability Maturity Model Integration) — Levels 3-5

| CMMI Practice Area | Suite Implementation | Level | Status |
|--------------------|---------------------|:-----:|:------:|
| **Requirements Management (REQM)** | PRINCIPLES.md defines 3 architectural constraints. Skills implement principles. verify-suite.ps1 validates mechanically | L3 | Meets |
| **Process Quality Assurance (PPQA)** | verify-suite.ps1 (13 checks), metrics.ps1 (6 metrics), INTEGRITY.json (hash snapshots covering ledgers, standard docs, and verification scripts without timestamp-only churn on no-change runs) | L3 | Meets |
| **Configuration Management (CM)** | Git versioning, annotated tags, CHANGELOG.md (Keep a Changelog format), PERSIST phase after every run, script self-verification, stable no-change integrity baselines | L3 | Meets |
| **Causal Analysis & Resolution (CAR)** | 3M causal chains (Mura causes Muri causes Muda). GENBA records root causes and whether fixes stuck. Recurrence detection across runs | L5 | Meets |
| **Organizational Performance Management (OPM)** | METRICS_HISTORY.md tracks quantitative process baselines over time. metrics.ps1 computes statistical indicators. Trend detection is manual (snapshot comparison); automated alerts are not yet implemented | L5 | Partial |
| **Decision Analysis & Resolution (DAR)** | ROI-based finding prioritization. Mura-first principle. Kaizen vs Kaikaku selection criteria. Phase 2 CHALLENGE provides structured methodology selection | L3 | Meets |
| **Quantitative Project Management (QPM)** | SCORECARD trajectory data. metrics.ps1 statistical analysis. Inter-rater agreement measurement. METRICS_HISTORY.md for SPC | L4 | Meets |

**Assessment:** The suite implements practices from CMMI Levels 3-5. Key L5 capabilities (Causal Analysis, Organizational Performance Management) are present and instrumented. The primary gap is formal traceability (PRINCIPLES to skills to verification checks) which is implicit rather than documented. Since Kata Run 37, the integrity of the measurement tools themselves (`verify-suite.ps1`, `metrics.ps1`, `STANDARDS.md`, `METRICS_HISTORY.md`) is mechanically verified by the hash-snapshot, and since Kata Run 38 the snapshot remains stable on no-change runs rather than generating timestamp-only churn. **Meets CMMI L4, partial L5.**

### CMMI L5 Gap: Traceability Matrix

The relationship between PRINCIPLES (requirements), skills (implementation), and verify-suite checks (verification) is implicit. A future run could add a traceability section mapping each principle to the skills that implement it and the checks that validate it.

---

## NIST AI Risk Management Framework (AI RMF 1.0)

| Function | Suite Implementation | Status |
|----------|---------------------|:------:|
| **GOVERN** | PRINCIPLES.md defines 3 governance constraints. Kata orchestrates with explicit rules. Observable Autonomy (Principle 2) requires continuous transparency | Partial |
| **MAP** | 3M diagnostic maps risks through Mura (inconsistency), Muri (overburden), Muda (waste) lenses. Causal chain analysis identifies risk propagation paths | Partial |
| **MEASURE** | metrics.ps1 provides quantitative measurement. SCORECARD tracks outcomes. METRICS_HISTORY.md tracks measurement over time. Rubric v2 defines measurable quality dimensions | Meets |
| **MANAGE** | Findings are tracked in GENBA with recurrence detection. verify-suite.ps1 prevents known failure modes. Git versioning provides rollback capability. Hansei provides meta-risk assessment | Partial |

**Assessment:** The suite addresses AI risk management practices but was not designed as a risk management framework. The MEASURE function is strong. GOVERN, MAP, and MANAGE are addressed incidentally through the quality improvement focus rather than through explicit risk categorization. The suite would need a structured risk register and explicit risk categories to fully comply. **Partial alignment — strong on measurement, weak on explicit risk governance.**

---

## Summary

| Standard | Alignment | Key Strength | Key Gap |
|----------|:---------:|-------------|---------|
| PDCA | **Exceeds** | Meta-improvement layer (Hansei) goes beyond Act | None material |
| DMAIC | **Meets/Exceeds** | 3-lens causal analysis exceeds typical RCA | None material (Control phase now instrumented) |
| CMMI L3 | **Meets** | Full coverage of L3 practice areas | Traceability matrix is implicit |
| CMMI L4 | **Meets** | Quantitative management via metrics.ps1 + SCORECARD | — |
| CMMI L5 | **Partial** | CAR and OPM practices present | Traceability, formal process optimization |
| NIST AI RMF | **Partial** | Strong MEASURE function | No explicit risk register or risk categories |

---

*This mapping was created during Kata Run 36, validated/hardened in Kata Run 37 to ensure the verification tooling itself is formally configuration-managed, and refined in Run 38 to keep the integrity snapshot stable on no-change runs.*
