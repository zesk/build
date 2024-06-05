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

- copy `bin/build/install-bin-build.sh` into your project (changing `relTop` if needed) manually (this line is the only thing that survives updates)
- run it before you need this code (will be installed at `bin/build`)
- installation pulls from `github.com` using `curl`

To install it in the operating system:

- Installation can ba accomplished by copying `bin/build/install-bin-build.sh` to `/usr/local/bin/build/` and running it as `root`
- installation pulls from `github.com` using `curl`

## Main entry points

- `bin/build/tools.sh` - The only include required for all build tools functions (does **NOT** include operations), also can be used as `tools.sh identicalCheck ...`
- `bin/build/ops.sh` - The only include required for all operations tools functions (includes all of `tools.sh` as well), also can be used to run operations commands. (e.g. `ops.sh daemontoolsInstallService ...`)

## Project structure

- `bin/build/env/*.sh` - Any external environment variable is referenced here. Projects should override default *behavior* with `./bin/env/*.sh` files.
- `bin/build/tools/*.sh` - Build tools function implementations.
- `bin/build/pipeline/*.sh` - Tools or steps for deployment
- `bin/build/install/*.sh` - Install dependencies in the pipeline (most of these exist as functions)
- `bin/build/ops/*.sh` - Operations scripts or tools
- `bin/build/hooks/*.sh` - All default hooks are here.

## Other binaries

`bin/build/` contains other tools for simple templating (`map.sh`, global changes `cannon.sh`, release utilities `new-release.sh` and `version-last.sh`. Add `./bin/build/` your `PATH` to get access to these easily.

    export PATH="$PATH:$BUILD_HOME/bin/build"

Binaries are:

- `cannon.sh` - `cannon` - replace strings in many files. Destructive! Warning! Danger!
- `chmod-sh.sh` - `makeShellFilesExecutable` - Makes `.sh` files `+x`
- `deprecated.sh` - Run this on your code to update it to the latest. May break it, so use source control.
- `identical-check.sh` - `identicalCheck`
- `local-container.sh` - `dockerLocalContainer`
- `map.sh` - `mapEnvironment`
- `new-release.sh` - `newRelease`
- `release-notes.sh` - `releaseNotes`
- `version-last.sh` - `gitVersionLast`
- `version-list.sh` - `gitVersionList`

Two special binaries can be used to load and run commands:

- `tools.sh` - `Zesk Tools - loads or runs tools`
- `ops.sh` - `Zesk Operations Tools - loads or runs tools`

## Artifacts: Build Directory and `.deploy`

A `./.build` directory is created at a configured location set by the environment variable `BUILD_CACHE`. If not set, it uses a default location your `$HOME` directory, or the project root (if `$HOME` is not set).

You can preserve the build directory post-build to see the details. Most failures will still output the log but they will not be output to your primary build log unless a failure occurs.

A `./.deploy` directory is created for build steps and contains metadata about the deployment. This is always created in the project root and the expectation is that it will be included in any deployments as metadata. 

## Operations

Operations support is currently sparse by goal is to support **setup and configuration** of:

- OS base installation
- Web server
- Application server
- `crontab`
- `daemontools` 

System patches and updates are also planned to be a part of the operations functionality.

## Run tests in docker

Scripts are written so you can load a `.env` and then run commands directly in a test container:

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

Reviewed: 2024-05-22

(this file is a copy - please modify the original)