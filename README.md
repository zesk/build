# Zesk Build tools

Pipeline and build-related tools which are useful across a variety of projects.

This toolkit makes the following assumptions:

- Binaries from this project installed at `./bin/build/`
- Release notes located at `./docs/release` which are named `v1.0.0.md` where prefix matches tag names (`v1.0.0`)
- A binary exists in your project `./bin/version-current.sh`
- Optionally a binary exists in your project `./bin/version-live.sh` (for `bin/build/new-release.sh` - will create a new version each time without it)
- For certain functions, your shell script should define a function `usage` for argument errors and short documentation.
- Most build operations occur at the project root directory but most can be run anywhere by supplying a parameter if needed (`composer.sh` specifically)
- A `.build` directory will be created at your project root which contains marker files as well as log files for the build. It can be deleted safely at any time, but may contain evidence of failures.

To use in your pipeline:

- copy `bin/build-setup.sh` into your project (changing `relTop` if needed)
- run it before you need your `bin/build` directory

Then invoke build scripts at `./bin/build/tool-name.sh`

## General usage

Template header for most scripts:

    #!/usr/bin/env bash
    #
    # Does a long process
    #
    set -eo pipefail
    errEnv=1

    me=$(basename "$0")
    relTop="../.."
    if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
        echo "$me: Can not cd to $relTop" 1>&2
        exit $errEnv
    fi

    quietLog="./.build/$me.log"
    # other constants here

    # shellcheck source=/dev/null
    . "./bin/build/tools.sh"

    requireFileDirectory "$quietLog"
    start=$(beginTiming)
    consoleInfo -n "Long process ... "
    if ! do-a-long-process.sh >> "$quietLog"; then
        consoleError "long process failed"
        failed "$quietLog"
    fi
    reportTiming "$start" Done


## Artifacts

A `./.build` directory is created at your project root where log files are generated. You can preserve this post-build to see the details. Most failures will still output the log but they will not be output to your primary build log unless a failure occurs.

## Usage function example

In your bash scripts, certain functions require the definition of a `usage` function and will trigger it when an
error occurs:

    usage() {
        local exitCode=$1

        exec 1>&2
        shift
        if [ -n "$*" ]; then
            consoleError "$@"
        fi
        consoleInfo "$me - do something"
        echo
        consoleInfo "--help     This help"
        echo
        exit "$exitCode"
    }

