# Zesk Build tools

Pipeline and build-related tools which are useful across a variety of projects.

This toolkit makes the following assumptions:

- You are using in another project to help with your development, pipeline, build, or operations.
- Binaries from this project installed at `./bin/build/`
- Your project: Release notes located at `./docs/release` which are named `v1.0.0.md` where prefix matches tag names (`v1.0.0`)
- Extensions to the build system are installed in a directory `./bin/hooks/`
- A `.build` directory may be created (at `$HOME`, or at the project root) to store cache files

To use in your pipeline:

- copy `./bin/build/install-bin-build.sh` into your project (changing `relTop` if needed) manually
- run it before you need your `./bin/build` directory

## Zesk Build Functionality

- `./bin/build/*.sh` - [Build scripts and tools](./bin/index.md) - Handy scripts universally useful everywhere.
- `./bin/build/tools/*.sh` - [Build Bash Functions](./tools/index.md) - Lots of handy functions
- `./bin/build/pipeline/*.sh` - [Pipeline tools](./pipeline/index.md) - Do work related to building and deploying software.
- `./bin/build/ops/*.sh` - [Operations tools](./ops/index.md) - Do work related to building and deploying software.
- `./bin/build/install/*.sh` - Install dependencies in the pipeline - most of these exist as functions
- `./bin/hooks/*.sh` - [Build Hooks](./hooks/index.md) - Hooks are a way to customize default behaviors in build scripts.

## [Build Bash Functions](./tools/index.md)

Handy tools

- `chmod-sh.sh` - Make `.sh` files executable (function `makeShellFilesExecutable`)
- `cannon.sh` - Replace text in all files specified (DANGER)
- `deprecated.sh` - Replace or warn about deprecated build code - run this in your source tree to fix or warn.
- `map.sh` - Replace environment tokens in a text file with values from the environment
- `new-release.sh` - Make a new release version (see `newRelease`)
- `version-last.sh` - The last version tagged (function `gitVersionLast`)
- `version-list.sh` - List all version tags ordered by `versionSort` (function `gitVersionList`)
- `identical-check.sh` - Quality tool to ensure code matches in different places (see `identicalCheck`)
- `release-notes.sh` - Outputs file name of current release notes (Try `open $(bin/build/release-notes.sh)`)
- `install-bin-build.sh` - Copy this into your project, rename it if you want, modify `relTop` and then use it to install this anywhere.

## General usage

Template header for most scripts:

    #!/usr/bin/env bash
    #
    # Does a long process
    #
    set -eou pipefail
    errorEnvironment=1

    cd "$(dirname "${BASH_SOURCE[0]}")/../.."

    me=$(basename "$0")
    # other constants here

    # shellcheck source=/dev/null
    . ./bin/build/tools.sh

    start=$(beginTiming)
    consoleInfo -n "Long process ... "
    quietLog="$(buildQuietLog "$me")"
    if ! do-a-long-process.sh >>"$quietLog"; then
        consoleError "long process failed"
        buildFailed "$quietLog"
    fi
    reportTiming "$start" Done


## Zesk Build Guides

- [Usage formatting](./guide/usage.md)

## Zesk Build Reference

- [Environment variables which affect build](env.md)
- [Deprecated functionality](./deprecated.md)

## Copyright

Copyright &copy; 2024 Market Acumen, Inc. All Rights Reserved. License is [MIT License](../LICENSE.md).
