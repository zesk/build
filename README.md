# Zesk Build Tools

Pipeline, build, and operations tools useful for any project.

- `bash` functions which work on all Unix-style operating systems with a common argument set
- Build, deployment and management tools for pipelines and production systems (system setup, services, cron, permissions
  separations)
- Operating system differences in many tools supported automatically
- Powerful tools for development workflows - automatic documentation for Bash scripts and functions, completions, and
  interactivity

This code toolkit depends solely on [`bash`](https://www.gnu.org/software/bash/manual/bash.html) and a few other
binaries (`jq`) and a conscientious decision has been made to not depend on any other language libraries, as of 2025
support for Bash 3 and 4 remains stable.

Depends on:

- `jq` - Parsing JSON files, some formatting
- `bc` - Floating-point math
- `curl` or `wget` - Remote installation

This toolkit assumes:

- Binaries from this project installed at `./bin/build/` (required)
- Files containing bash code end with `.sh`
- **Release notes** are located in a dedicated subdirectory (may be configured per-project), files are named `v1.0.0.md`
  which match version names (`v1.0.0`) (required)
- Installation pulls from `github.com` using `curl` or `wget`

To use in your pipeline:

- copy `bin/build/install-bin-build.sh` into your project (changing last line as needed) or use `installInstallBuild` to
  install it.
- run it before you need this code (will be installed at `./bin/build`)

To install it in the operating system:

- Copy `bin/build/install-bin-build.sh` to `/usr/local/bin/build/` and `sudo /usr/local/bin/build/install-bin-build.sh`

## Main entry points

- `bin/build/tools.sh` - The only include required for all build tools functions, also can be used as
  `tools.sh identicalCheck ...`

## Your project structure

Zesk Build makes the following assumptions about your project structure:

- `./` - Application root (same as `buildHome`)
- `./bin/build/` - Zesk Build installation location (may *not* be changed)
- `./bin/hooks/` - Application hook implementation (`hook-name` with `.sh` on the end)
- `./bin/env/` - Your project's environment variables defaults (`NAME` with `.sh` on the end if you use
  `buildEnvironmentLoad` or `buildEnvironmentGet`)
- `./docs/release/v1.0.0.md` - Release notes (override by adding `BUILD_RELEASE_NOTES` environment)

## Zesk Build Project structure

Internally Zesk Build is organized:

- `bin/build/env/*.sh` - All external environment variables are referenced here. Projects should override default
  *behavior* with `./bin/env/*.sh` files.
- `bin/build/tools/*.sh` - Build tools function implementations and template files (`.md` files)
- `bin/build/hooks/*.sh` - All default hooks are here - if your application does not implement them - these are used.

## Other binaries

`bin/build/` contains other tools for simple templating (`map.sh`, global changes `cannon.sh`, release utilities
`new-release.sh` and `version-last.sh`. Add `./bin/build/` your `PATH` to get access to these easily.

    export PATH="$PATH:$BUILD_HOME/bin/build"

Binaries are:

- `cannon.sh` - `cannon` - replace strings in many files. Destructive! Warning! Danger!
- `chmod-sh.sh` - `makeShellFilesExecutable` - Makes `.sh` files `+x`
- `deprecated.sh` - Run this on your code to update it to the latest. May break it, so use source control.
- `identical-check.sh` - `identicalCheck` wrapper
- `identical-repair.sh` - `identicalRepair` with some automatic configuration for your project
- `local-container.sh` - `dockerLocalContainer` wrapper
- `bitbucket-container.sh` - `bitbucketContainer` wrapper
- `map.sh` - `mapEnvironment` wrapper
- `need-bash.sh` - For Docker image installs which lack bash (usually running `sh`). This script enables install of
  `bash` to run `tools.sh` properly.
- `new-release.sh` - `newRelease` wrapper
- `release-notes.sh` - `releaseNotes` wrapper
- `test-tools.sh` - Tools for `testSuite`
- `version-last.sh` - `gitVersionLast` wrapper
- `version-list.sh` - `gitVersionList` wrapper

## Simple Zesk Build Loaders

As a shortcut to running functions:

    #!/usr/bin/env bash
    "${BASH_SOURCE[0]%/*}/../bin/build/tools.sh" decorate orange "The code is working."

To load all functions:

    #!/usr/bin/env bash
    # shellcheck source=/dev/null
    source "${BASH_SOURCE[0]%/*}/../bin/build/tools.sh" 

    decorate orange "The code is working."
    bigText "Hooray."

For more complex (and more robust error handling) see `__install` and `__tools` code in `bin/build/identical`.

## Artifacts: Build Directory and `.deploy`

A `.build` directory is created at a configured location set by the environment variable `BUILD_CACHE`. If not set, it
uses `XDG_CACHE_HOME` directory, which defaults to a standard directory.

You can preserve the build directory post-build to see any details. Most failures will still output the log, but they
will not be output to your primary build log unless a failure occurs.

A top-level `.deploy` directory is created for build steps and contains metadata about the deployment. This is always
created in the project root and the expectation is that it will be included in any deployments as metadata (not
required, however).

## Run tests in docker

Scripts support loading an environment files and running commands directly in a test container:

    bin/build/bitbucket-container.sh --env-file .env.MYTESTENV bin/test.sh

## Environment files

Environment values files can adhere to the **Docker** format (no quotes) or be bash-compatible (`source` compatible) but
not both, unfortunately; as the Docker format is incompatible with `bash` and vice-versa regarding values with spaces in
them.

### Docker-compatible

    NAME=Zesk Build
    ITEMS=(1 2 3 4)

### Bash-compatible

    NAME="Zesk Build"
    export ITEMS=(1 2 3 4)

Given that your project may use one or both, it's best to support any implementation when possible.

> **Note:** `.env` files appear to have different implementations such that it's difficult at best to have a single
> format which works in your projects.
>
> We _detect_ whether an environment values file is formatted to support **Docker** or not and _convert it_
> appropriately on-the-fly as needed. See: `environmentFileToDocker` and `environmentFileToBashCompatible`

## Tested operating systems

Main issues between platforms are differences between BSD, GNU or POSIX standard tools in the shell.

- Darwin (Mac OS X)
- Ubuntu 22
- debian:latest
- alpine:latest
- BitBucket Pipelines

Tested bash versions:

- 3.2.57 (`Darwin`)
- 5.1.16 (`Ubuntu`)
- 5.2.26 (`Alpine`)

If you test on another OS or need support on a specific
platform, [report an issue](https://github.com/zesk/build/issues).

## Known issues and workarounds

- [On Mac OS X the Docker environment thinks non-executable files are executable](https://github.com/docker/for-mac/issues/5509),
  notably `bin/build/README.md` is considered `[ -x $file ]` when you are inside the container when the directory is
  mapped from the operating system. If it's a non-mapped directory, it works fine. Seems to be a bug in how
  permissions are translated, I assume. Workaround falls back to `ls` which is slow but works. See `isExecutable`. Added
  2024-01.

## Copyright &copy; 2025

All copyrights held by **Market Acumen, Inc.**, a [provider
of infrastructure expertise.](https://marketacumen.com/executive-technical-assessment-and-reporting/?crcat=code&crsource=zesk-build&crcampaign=README.md&crkw=provider+of+infrastructure+expertise)

License is [MIT License](LICENSE.md). Source can be found online at [GitHub](https://github.com/zesk/build).

Reviewed: 2025-09-24
