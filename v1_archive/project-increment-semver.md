# Semver Reference

Quick reference for determining version bump levels. Used by the project-increment skill.

## Version Format

```
MAJOR.MINOR.PATCH
```

- **MAJOR**: Incompatible API/behavior changes
- **MINOR**: New functionality, backward-compatible
- **PATCH**: Bug fixes, backward-compatible

## Decision Table

| What Changed | Bump | Why |
|---|---|---|
| Removed a public function/method/CLI flag | **Major** | Existing users' code breaks |
| Renamed a public function/method/CLI flag | **Major** | Existing users' code breaks |
| Changed return type or output format | **Major** | Downstream consumers break |
| Changed a default value that affects behavior | **Major** | Existing workflows behave differently |
| Added a new *required* config field / parameter | **Major** | Existing configs/calls fail |
| New command / endpoint / module | **Minor** | Additive, nothing breaks |
| New *optional* parameter with a sensible default | **Minor** | Additive, nothing breaks |
| New output section (additional data in reports) | **Minor** | Additive, nothing breaks |
| New optional feature behind a flag | **Minor** | Additive, nothing breaks |
| Fix a crash or incorrect behavior | **Patch** | Corrects existing functionality |
| Performance improvement (same API) | **Patch** | No behavior change |
| Internal refactor (no user-visible change) | **Patch** | No behavior change |
| Documentation-only change | **Patch** or none | No code change |
| Dependency update (compatible) | **Patch** | No behavior change |
| Security fix (same API) | **Patch** | Corrects vulnerability |

## Edge Cases

**Pre-1.0 (`0.x.y`)**: Semver spec allows breaking changes in minor bumps. In practice, treat `0.x` bumps like major bumps and `0.x.y` like minor/patch. Be explicit in the changelog.

**Adding a field to structured output** (JSON, API response): If consumers parse the output, adding a new field is technically minor (additive). But if consumers use strict parsing (e.g., `additionalProperties: false`), it is major. Use judgment.

**Changing error messages**: Patch, unless users programmatically parse error text (then arguably major).

**Changing the order of output**: Patch if unordered, potentially major if order was part of the contract.

**Internal dependency major bump**: Only major for your project if it changes YOUR public API surface. If your users do not interact with that dependency, it can be patch/minor.
