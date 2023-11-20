
# `new-release.sh` - Generate a new release notes and bump the version

[⬅ Return to top](index.md)

Checks the live version versus the version in code and prompts to
generate a new release file if needed.

A release notes template file is added at `./docs/release/`. This file is
also added to `git`.

## Exit codes

- `0` - Always succeeds
