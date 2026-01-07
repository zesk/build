# [Zesk Build Tools](https://build.zesk.com/)

Pipeline, build, and operations tools useful for any project written exclusively in `bash` and works across all major
platforms, devices, and operating systems.

- System setup, service management, cron, permissions separations
- Powerful tools for development workflows - automatic documentation for Bash scripts and functions, completions, and
  interactivity

This code toolkit depends solely on [`bash`](https://www.gnu.org/software/bash/manual/bash.html) and a few other
binaries (`jq`, `sed`) and a conscientious decision has been made to not depend on any other language libraries, as of 2026
support for Bash 3 and 4 remains stable.

This toolkit assumes:

- Sources from this project are installed at `./bin/build/` in your project (required)
- Bash code files end with `.sh`
- **Release notes** are located in a dedicated subdirectory (can be configured per-project), using markdown `.md` (
  required) and named `v1.0.0.md`  which match version names (`v1.0.0`) (required)

To use in your project:

- copy `bin/build/install-bin-build.sh` into your project (changing last line as needed) or use `installInstallBuild` to
  install the installation script (to be clear &mdash; installs `install-bin-build.sh` into your project with the
  correct path setup to your project root).
- Run the installer it before you need this code (will be installed at `./bin/build`)
- `source bin/build/tools.sh` to load the library and use any function defined

To install it in the operating system:

- Copy `bin/build/install-bin-build.sh` to `/usr/local/bin/build/` and `sudo /usr/local/bin/build/install-bin-build.sh`
- Source `/usr/local/bin/build/tools.sh` in your scripts to get access to all functions

## Main entry points

- `bin/build/tools.sh` - The only include required for all build tools functions, also can be used as
  `tools.sh identicalCheck ...`

## Project structure

Zesk Build directories in your project structure:

- `./` - Application root (same as `buildHome`)
- `./bin/build/` - Zesk Build installation location (may *not* be changed)
- `./bin/hooks/` - Application hook implementation (`hook-name` with `.sh` on the end)
- `./bin/env/` - Your project's environment variables defaults (`NAME` with `.sh` on the end if you use
  `buildEnvironmentLoad` or `buildEnvironmentGet`)
- `./docs/release/v1.0.0.md` - Release notes (override path by adding `BUILD_RELEASE_NOTES` environment)

Internally Zesk Build is organized:

- `bin/build/env/*.sh` - All external environment variables are referenced here. Projects should override default
  *behavior* with `./bin/env/*.sh` files.
- `bin/build/tools/*.sh` - Build tools function implementations and template files (`.md` files)
- `bin/build/hooks/*.sh` - All default hooks are here - if your application does not implement them - these are used.

## Requirements

Requires:

- `jq` - Parsing JSON files, some formatting
- `bc` - Floating-point math
- `curl` or `wget` - Remote installation

Optional:

- `shellcheck` - `bash` linting code
- `pcregrep` - documentation generation and support
- `unzip` - `awsInstall`

## Simple Zesk Build Loaders

As a shortcut to running functions:

    #!/usr/bin/env bash
    "${BASH_SOURCE[0]%/*}/../bin/build/tools.sh" decorate orange "The code is working."

To load all functions:

    #!/usr/bin/env bash
    # shellcheck source=/dev/null
    if source "${BASH_SOURCE[0]%/*}/../bin/build/tools.sh"; then 
        decorate orange "The code is working."
        bigText "Hooray."
    else
        printf -- "%s\n" "No tools.sh" 1>&2 && false
    fi

For more complex (and more robust error handling) see `__install` and `__tools` code in `bin/build/identical`.

## Run tests in docker

Scripts support loading one or more environment files and running commands directly in a test container:

    bin/build/bitbucket-container.sh --env-file .env.MYTESTENV bin/test.sh

## Known issues and workarounds

- [On Mac OS X the Docker environment thinks non-executable files are executable](https://github.com/docker/for-mac/issues/5509),
  notably `bin/build/README.md` is considered `[ -x $file ]` when you are inside the container when the directory is
  mapped from the operating system. If it's a non-mapped directory, it works fine. Seems to be a bug in how
  permissions are translated, I assume. Workaround falls back to `ls` which is slow but works. See `isExecutable`. Added
  2024-01.

## Copyright &copy; 2026

All copyrights held by **Market Acumen, Inc.**, a [provider
of infrastructure and cloud expertise.](https://marketacumen.com/executive-technical-assessment-and-reporting/?crcat=code&crsource=zesk-build&crcampaign=README.md&crkw=provider+of+infrastructure+expertise)

License is [MIT License](LICENSE.md). Source can be found online at [GitHub](https://github.com/zesk/build).

Reviewed: 2026-01-05

(this file is a copy - please modify the original)
