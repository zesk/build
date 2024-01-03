# Zesk Build tools

Pipeline and build-related tools which are useful across a variety of projects.

- Abstracted scripts which work on any operating system
- Build and deployment tools
- Operational scripts for managing live production systems

This code toolkit depends largely on `bash` and a conscientious decision has been made to not depend on any other language libraries.

This toolkit makes the following assumptions:

- You are using this with another project to help with your pipeline and build steps.
- Binaries from this project installed at `./bin/build/`
- Files containing bash code end with `.sh`
- Your project: Release notes located at `./docs/release` which are named `v1.0.0.md` where prefix matches tag names (`v1.0.0`)
- The last version-sorted release notes is the current release of your software, or an optional hook exists in your project `./bin/hooks/version-current.sh`
- Optionally a binary exists in your project `./bin/hooks/version-live.sh` to fetch the live version from somewhere
- **Most** build operations occur at the project root directory
- A central `$HOME/.build` directory is created to store temporary files and log files; after running certain scripts it can be safely discarded or re-used.

To use in your pipeline:

- copy `bin/build/install-bin-build.sh` into your project (changing `relTop` if needed) manually (this line is the only thing that survives updates)
- run it before you need this code (installed at `bin/build`)

## Project structure

- `bin/build/tools.sh` - Main include file - source this in your scripts to get all benefits
- `bin/build/tools/*.sh` - Build tools implementations
- `bin/build/pipeline/*.sh` - Tools or steps for deployment
- `bin/build/install/*.sh` - Install dependencies in the pipeline (most of these exist as functions)

## Tools

- `tools.sh` - The only include required for all build tools functions
- `chmod-sh.sh` - Make `.sh` files executable (function `makeShellFilesExecutable`)
- `cannon.sh` - Replace text in all files specified (DANGER)
- `deprecated.sh` - Replace or warn about deprecated build code
- `map.sh` - Replace environment tokens in a text file with values from the environment
- `new-release.sh` - Make a new release version
- `version-last.sh` - The last version tagged (function `gitVersionLast`)
- `version-list.sh` - List all version tags ordered by `versionSort` (function `gitVersionList`)
- `identical-check.sh` - Quality tool to ensure code matches in different places
- `release-notes.sh` - Outputs file name of current release notes (Try `open $(bin/build/release-notes.sh)`)
- `install-bin-build.sh` - Copy this into your project, rename it if you want, modify `relTop` and then use it to install this anywhere.

## Local override scripts or hooks (not in this project - in your host project)

- `bin/hooks/version-current.sh` - Return your current application version
- `bin/hooks/version-live.sh` (optional)  - Return the LIVE application version
- `bin/hooks/version-created.sh` (optional) - Run code when `new-release.sh` creates a new release
- `bin/hooks/version-already.sh` (optional) - Run code when `new-release.sh` does not create a new release
- `bin/hooks/make-env.sh` (optional) Customize environment generation in `php-build.sh`
- `bin/hooks/maintenance.sh` (optional) turn on or off maintenance
- `bin/hooks/deploy-start.sh` (optional) Used at start of deployment on remote host (delete caches, etc.)
- `bin/hooks/deploy-finish.sh` (optional) After new code is deployed (update local files or register server etc.)
- `bin/hooks/deploy-confirm.sh` (optional) After new code is deployed make sure it is running correctly

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

## Artifacts: Build Directory and `.deploy`

A `./.build` directory is created at your `$HOME` directory, or the project root (if `$HOME` is not set) where log files are generated.

You can preserve the build directory post-build to see the details. Most failures will still output the log but they will not be output to your primary build log unless a failure occurs.

A `./.deploy` directory is created for the `php-build.sh` steps and contains metadata about the deployment.

## Copyright &copy; 2024 Market Acumen, Inc

License is [MIT License](LICENSE.md). Source can be found online at [GitHub](https://github.com/zesk/build).
