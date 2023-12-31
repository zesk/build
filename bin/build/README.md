# Zesk Build tools

Pipeline and build-related tools which are useful across a variety of projects.

This code toolkit depends largely on `bash` and a conscientious decision has been made to not depend on any other language libraries.

This toolkit makes the following assumptions:

- You are using this with another project to help with your pipeline and build steps.
- Binaries from this project installed at `./bin/build/`
- Files containing bash code end with `.sh`
- Your project: Release notes located at `./docs/release` which are named `v1.0.0.md` where prefix matches tag names (`v1.0.0`)
- A hook exists in your project `./bin/hooks/version-current.sh`
- Optionally a binary exists in your project `./bin/hooks/version-live.sh` (for `bin/build/new-release.sh` - will create a new version each time without it)
- For certain functions, your shell script should define a function `usage` for argument errors and short documentation.
- Most build operations occur at the project root directory but most can be run anywhere by supplying a parameter if needed (`composer.sh` specifically)
- A `.build` directory will be created at your project root which contains marker files as well as log files for the build. It can be deleted safely at any time, but may contain evidence of failures.

To use in your pipeline:

- copy `bin/build/install-bin-build.sh` into your project (changing `relTop` if needed) manually
- run it before you need your `bin/build` directory

## Project structure

- `bin/build/tools.sh` - Main include file
- `bin/build/tools/*.sh` - Build tools
- `bin/build/pipeline/*.sh` - Tools or steps for deployment
- `bin/build/install/*.sh` - Install dependencies in the pipeline

## Tools

- `tools.sh` - The only include required for all build tools functions
- `chmod-sh.sh` - Make `.sh` files executable
- `cannon.sh` - Replace text in all files specified
- `deprecated.sh` - Replace or warn about deprecated build code
- `map.sh` - Replace environment tokens in a text file with values from the environment
- `envmap.sh` - Previous name for `map.sh`. Deprecated 2023.
- `new-release.sh` - Make a new release version
- `version-last.sh` - The last version tagged
- `version-list.sh` - List all version tags ordered by `versionSort`
- `identical-check.sh` - Handy tool to ensure code matches in different places
- `release-notes.sh` - Outputs file name of current release notes (Try `open $(bin/build/release-notes.sh)`)
- `install-bin-build.sh` - Copy this into your project, rename it if you want, modify `relTop` and then use it to install this anywhere.
- `build-setup.sh` - Previous version of `install-bin-build.sh`. Deprecated 2023.

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
    set -eo pipefail
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

## Artifacts

A `./.build` directory is created at your project root where log files are generated. You can preserve this post-build to see the details. Most failures will still output the log but they will not be output to your primary build log unless a failure occurs.

A `./.deploy` directory is created for the `php-build.sh` steps and contains metadata about the deployment.

## Usage function example

In your bash scripts, certain functions require the definition of a `usage` function and will trigger it when an
error occurs:

    usageOptions() {
        echo "--option      Description goes here"
        echo "--debug       Debugging mode"
    }
    usage() {
        local exitCode=$1

        exec 1>&2
        shift
        if [ -n "$*" ]; then
            consoleError "$@"
        fi
        echo "$me - do something" | usageGenerator 20
        echo
        usageOptions | usageGenerator 20
        echo
        exit "$exitCode"
    }

## Copyright &copy; 2023 Market Acumen, Inc

License is [MIT License](LICENSE.md). Source can be found online at [GitHub](https://github.com/zesk/build).

(this file is a copy - please modify the original)
