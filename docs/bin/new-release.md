
# `newRelease` - Generate a new release notes and bump the version

[⬅ Return to top](index.md)

**New release** - generates files in system for a new release.

*Requires* hook `version-current`, optionally `version-live`

Uses semantic versioning `MAJOR.MINOR.PATCH`

Checks the live version versus the version in code and prompts to
generate a new release file if needed.

A release notes template file is added at `./docs/release/`. This file is
also added to `git` the first time.

## Arguments



## Exit codes

- `0` - Release generated or has already been generated
- `1` - If new version needs to be created and `--non-interactive`
