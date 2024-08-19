# Zesk Build Tools

Pipeline, build, and operations tools which are useful across a variety of projects.

- Abstracted bash scripts which work on all Unix-style operating system
- Build and deployment tools for pipelines and software platforms and languages
- Operational scripts for managing live production systems (system setup, services, cron, permissions separations)

This code toolkit depends largely on `bash` and a conscientious decision has been made to not depend on any other language libraries, as of 2024 there are no dependencies on Bash 4.

This toolkit makes the following assumptions:

- Binaries from this project installed at `./bin/build/` (required)
- Files containing bash code end with `.sh` (assumed)
- Release notes are located in a dedicated subdirectory (can be configured per-project), files are named `v1.0.0.md` which match version names (`v1.0.0`) (required)
- A central `$HOME/.build` directory is created to store temporary files and log files; after running certain scripts it can be safely discarded or re-used. (configurable)

To use in your pipeline:

- copy `bin/build/install-bin-build.sh` into your project (changing last line as needed).
- run it before you need this code (will be installed at `bin/build`)
- installation pulls from `github.com` using `curl`

To install it in the operating system:

- Installation can ba accomplished by copying `bin/build/install-bin-build.sh` to `/usr/local/bin/build/` and running it as `root`
- installation pulls from `github.com` using `curl`

## Main entry points

- `bin/build/tools.sh` - The only include required for all build tools functions, also can be used as `tools.sh identicalCheck ...`

## Zesk Build Project structure

- `bin/build/env/*.sh` - Any external environment variable is referenced here. Projects should override default *behavior* with `./bin/env/*.sh` files.
- `bin/build/tools/*.sh` - Build tools function implementations.
- `bin/build/pipeline/*.sh` - Tools or steps for deployment
- `bin/build/install/*.sh` - Install dependencies in the pipeline (most of these exist as functions)
- `bin/build/hooks/*.sh` - All default hooks are here.

## Your project structure

Defaults:

- `./` - Application root
- `./bin/build` - Zesk Build installation location (may *not* be changed)
- `./bin/hooks/` - Application hook implementation (`hook-name` with `.sh` on the end)
- `./bin/env/` - Your project's environment variables defaults (`NAME` with `.sh` on the end)
- `./docs/release/v1.0.0.md` - Release notes (override by adding `BUILD_RELEASE_NOTES` environment)

## Other binaries

`bin/build/` contains other tools for simple templating (`map.sh`, global changes `cannon.sh`, release utilities `new-release.sh` and `version-last.sh`. Add `./bin/build/` your `PATH` to get access to these easily.

    export PATH="$PATH:$BUILD_HOME/bin/build"

Binaries are:

- `cannon.sh` - `cannon` - replace strings in many files. Destructive! Warning! Danger!
- `chmod-sh.sh` - `makeShellFilesExecutable` - Makes `.sh` files `+x`
- `deprecated.sh` - Run this on your code to update it to the latest. May break it, so use source control.
- `identical-check.sh` - `identicalCheck` with some automatic configuration for your project
- `local-container.sh` - `dockerLocalContainer`
- `bitbucket-container.sh` - `bitbucketContainer`
- `map.sh` - `mapEnvironment`
- `new-release.sh` - `newRelease`
- `release-notes.sh` - `releaseNotes`
- `version-last.sh` - `gitVersionLast`
- `version-list.sh` - `gitVersionList`

A single binary can be used to load and run commands:

- `tools.sh` - loads or runs tools

## Sample usages

As a shortcut to running functions:

    #!/usr/bin/env bash
    "${BASH_SOURCE[0]%/*}/../bin/build/tools.sh" consoleOrange "The code is working."

To load all functions:

    #!/usr/bin/env bash
    # shellcheck source=/dev/null
    source "${BASH_SOURCE[0]%/*}/../bin/build/tools.sh" 

    consoleOrange "The code is working."
    bigText "Hooray."

For more complex (and more robust error handling) see `__install` and `__tools` identical code in `bin/build/identical`.

## Artifacts: Build Directory and `.deploy`

A `.build` directory is created at a configured location set by the environment variable `BUILD_CACHE`. If not set, it uses a default location your `$HOME` directory, or the project root (if `$HOME` is not set).

You can preserve the build directory post-build to see the details. Most failures will still output the log, but they will not be output to your primary build log unless a failure occurs.

A top-level `.deploy` directory is created for build steps and contains metadata about the deployment. This is always created in the project root and the expectation is that it will be included in any deployments as metadata.

## Run tests in docker

Scripts are written by loading an `.env` file and then run commands directly in a test container:

    bin/build/bitbucket-container.sh --env .env.MYTESTENV bin/test.sh

`.env` appears to have various machinations such that it's difficult at best to have a single format which works in your projects. The solution is simple: detect whether a `.env` is formatted to support **Docker** or not and convert it appropriately on-the-fly as needed; Zesk Build supports this detection and conversion.

## Tested operating systems

Main issues between platforms are differences between BSD, GNU or POSIX standard tools in the shell.

- Darwin (Mac OS X)
- Ubuntu 22
- debian:latest
- BitBucket Pipelines

Tested bash versions:

- 3.2.57 (`Darwin`)
- 5.1.16 (`Ubuntu`)

If you test on another OS or need support on a specific platform, report an issue.

## Known issues and workarounds

- On Mac OS X the Docker environment thinks non-executable files are executable, notably `bin/build/README.md` is considered `[ -x $file ]` when you are inside the container when the directory is mapped from the operating system. If it's a non-mapped directory, it works fine. Seems to be a bug in how permissions are translated, I assume. Workaround falls
  back to `ls` which is slow but works. See `isExecutable`. Added 2024-01.

## Copyright &copy; 2024 Market Acumen, Inc

License is [MIT License](LICENSE.md). Source can be found online at [GitHub](https://github.com/zesk/build).

Reviewed: 2024-08-19
