---
name: project-increment
version: 1.34.0
description: 'Perform a project version increment — review git changes, verify build, determine semver bump level (major/minor/patch), update version strings across all files, write changelog entry, update README. Optionally commit, tag, and push when explicitly requested. USE WHEN: releasing a version, bumping version, writing changelog, doing a project increment, preparing a release, version bump.'
argument-hint: 'Optional: specify bump level (major, minor, patch) or let the skill determine it from changes'
---

# Project Increment

Perform a complete project version increment: review changes, verify build, bump version, update changelog and docs. By default the git commit is left to the developer, but commit+tag+push can be performed when explicitly requested.

## When to Use

- After completing a feature or fix, before committing
- When the user says "project increment", "version bump", "prepare release", "update version"
- When changes are staged/unstaged and need to be packaged as a version

## Procedure

### Phase 1: Discovery — Understand the Project

Before anything else, discover how this project manages versions. Every project is different.

1. **Find all version sources.** Search the workspace for version strings:
   - Python: `__version__` in `__init__.py`, `version` in `pyproject.toml`, `setup.py`, `setup.cfg`
   - JavaScript: `version` in `package.json`, `package-lock.json`
   - Rust: `version` in `Cargo.toml`
   - Go: version constants, git tags only
   - .NET: `<Version>` in `.csproj`
   - Other: grep for the current version number across all files
   - README badges, Dockerfile labels, constants in source code
   
   **CRITICAL**: Multiple files often contain the version string. Missing one is the #1 mistake in manual version bumps. Grep the codebase for the current version number to catch all occurrences.

2. **Find the changelog.** Look for `CHANGELOG.md`, `CHANGES.md`, `HISTORY.md`, `NEWS.md`, or a changelog section in `README.md`.

3. **Detect changelog format.** Check if the project follows:
   - [Keep a Changelog](https://keepachangelog.com) (Added/Changed/Deprecated/Removed/Fixed/Security)
   - Custom format (match the existing pattern exactly — don't impose a format)
   - No changelog yet (offer to create one matching the project's style)

4. **Check for release config files.** Look for `.bumpversion.cfg`, `tbump.toml`, `.versionrc`, `.releaserc`, `.changeset/`, `cliff.toml`. If present, suggest using the project's existing tooling instead.

### Phase 2: Review — What Changed

5. **Get the diff.** Run:
   ```
   git status
   git diff --stat
   git diff -- <source files only, skip binary/cache>
   ```
   
6. **Identify the last release.** Find the latest git tag or the last version entry in the changelog:
   ```
   git tag --sort=-version:refname | head -5
   git log <last-tag>..HEAD --oneline
   ```

7. **Summarize changes.** Read the diffs and categorize:
   - **Added**: New features, new files, new capabilities
   - **Changed**: Modified behavior, refactored code, updated dependencies
   - **Fixed**: Bug fixes, error corrections
   - **Removed**: Deleted features, removed files
   - **Deprecated**: Features marked for future removal
   - **Security**: Vulnerability fixes
   - **Breaking**: Changes that break backward compatibility (API changes, removed flags, changed defaults, new required config fields)

### Phase 3: Determine Bump Level

8. **Apply semver rules:**

   | Change Type | Bump | Examples |
   |-------------|------|----------|
   | Breaks backward compatibility | **Major** | Removed CLI flag, renamed public function, changed return type, new required config field |
   | New capability, backward-compatible | **Minor** | New command, new optional parameter, new output section, new module |
   | Bug fix, no behavior change | **Patch** | Fix crash, fix wrong output, performance improvement, internal refactor |

   If the user specified a bump level, use it. Otherwise, determine from changes and confirm with the user if unclear.

   **Common mistakes to avoid:**
   - Internal refactors with no user-visible change are **patch**, not minor
   - Adding a new *optional* field with a default is **minor**, not major
   - Adding a new *required* field (breaks existing configs) is **major**
   - Pre-1.0 (`0.x.y`): minor bumps can contain breaking changes per semver, but be explicit about it in the changelog

### Phase 4: Apply Changes

9. **Bump version in ALL discovered locations.** Update every file found in step 1. After updating, grep the codebase for the OLD version number to verify nothing was missed.

10. **Update the changelog.** Match the existing format exactly. Include:
    - Version number and date (`## v1.5.0 — YYYY-MM-DD`)
    - Categorized changes from step 7
    - Brief descriptions that tell the user WHAT changed and WHY, not HOW (implementation details belong in commit messages, not changelogs)
    - If the project uses an `[Unreleased]` section, move entries to the new version

11. **Update README if applicable.** The README is the project's public face — it must accurately describe current behavior. Use the git diff from step 5 to identify what the README needs to reflect:

    a. **Read the full README.** Understand its current structure and claims.
    
    b. **Cross-reference git changes against README content.** For each significant change from step 7, check whether the README makes claims that are now stale:
       - Feature lists that don't mention new capabilities
       - Architecture/pipeline descriptions that miss new phases or steps
       - Configuration/CLI documentation that omits new flags or env vars
       - Examples that show old behavior
       - Counts, numbers, or specifics that changed (e.g., "9 attack angles" → "20 attack angles")
    
    c. **Update existing sections in-place.** Modify sentences, bullet points, and descriptions to reflect the new reality. Add new items to existing lists where they logically belong.
    
    d. **IMPORTANT:** Only update sections that already exist — don't add new README structure. Don't rewrite sections that aren't affected by the changes. Do the minimum edit that makes the README accurate.

    e. **Multi-repo projects.** If the public-facing README lives in a separate repository (e.g. a dedicated `-releases` repo), check whether changes warrant an update there too. Note it in the summary but only update if the user confirms.

### Phase 5: Verify

12. **Verify the build.** Run the project's build/check command:
    - Python: `python -c "import <package>; print(<package>.__version__)"` or `python -m py_compile <files>`
    - JavaScript: `npm run build` or `npx tsc --noEmit`
    - Rust: `cargo check`
    - Go: `go build ./...`
    - Whatever the project uses — check for a `Makefile`, `justfile`, or `scripts/` directory

13. **Check for errors.** Use the editor's error checking to verify no compile/lint errors were introduced.

14. **Final version grep.** Search for the OLD version string one more time. If found anywhere (except changelogs referencing history), it was missed.

### Phase 6: Report

15. **Show a summary.** Present to the user:
    - Old version → New version
    - Bump level and reasoning
    - Files modified
    - If Phase 7 was NOT requested: "Ready to commit. The git commit is yours to make."

### Phase 7: Commit & Release (opt-in)

Only execute this phase when the user explicitly asks to commit, release, tag, or push.

16. **Commit.** Stage all changed files and commit with message: `vX.Y.Z — <one-line summary>`
17. **Tag.** Create an annotated tag: `git tag -a vX.Y.Z -m "vX.Y.Z"`
18. **Push.** Push the commit and tag: `git push origin <branch> --follow-tags`
19. **Confirm.** Show the pushed commit hash and tag.

## Rules

- **Preserve UTF-8 on bulk edits.** When shell commands rewrite markdown or source code, use explicit UTF-8 encoding. PowerShell default encoding can corrupt arrows, em dashes, and non-ASCII glyphs into mojibake.
- **Commit only when asked.** By default the skill prepares the increment and the developer commits. When the user explicitly requests commit/release/push, execute Phase 7.
- **Never guess the version format.** Read existing files to match the exact format (with or without `v` prefix, quote style, etc.).
- **Match existing changelog style.** Don't impose Keep-a-Changelog format on a project that uses a different convention.
- **Grep for the old version.** Always verify all version references were updated.
- **Don't add structure that doesn't exist.** If the README has no "What's New" section, don't add one unless asked.
- **Date format.** Use ISO 8601 (`YYYY-MM-DD`) unless the project already uses a different format — then match it.
- **Atomic changes.** Version bump, changelog, and README updates should be the only changes. Don't mix in code fixes.

## Resources

- [Semantic Versioning](https://semver.org) — Version numbering rules and edge cases

