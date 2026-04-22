# [Zesk Build Tools](https://build.zesk.com)

Documentation can be found
at [https://build.zesk.com](https://build.zesk.com). ([Next version](https://stage-build.zesk.com))

Pipeline, build, and operations tools useful for any project written exclusively in `bash` and works across all major
platforms, devices, and operating systems.

- System setup, service management, permissions separations
- Tools to simplify development workflows; automatic documentation for Bash scripts and functions, completions, and
  interactivity
- Testing and assertion library for Bash which outputs **jUnit**, **TAP** with extensible hooks.
- Extensive, platform agnostic utilities

This code toolkit depends solely on [`bash`](https://www.gnu.org/software/bash/manual/bash.html) and a few other
binaries (`jq`, `sed`, `find`, `awk`) and a conscientious decision has been made to not depend on any other language
libraries, as of
2026 support for Bash 3 and 4 remains stable.

This toolkit assumes:

- Sources from this project are installed at `$BUILD_HOME/bin/build/`
- Bash code files end with `.sh`
- **Release notes** are located in a dedicated subdirectory (can be configured per-project), using markdown `.md` (
  required) and named `v1.0.0.md`  which match version names (`v1.0.0`) (required)

You can use **Zesk Build** solely as a toolkit within your project, or directly into your operating system and available to
all programs.

To use in your project:

- copy `bin/build/install-bin-build.sh` into your project (changing last line as needed) or use `installInstallBuild` to
  install the installation script (to be clear &mdash; installs `install-bin-build.sh` into your project with the
  correct path setup to your project root).
- Run the installer it before you need this code (will be installed at `./bin/build`)
- `source bin/build/tools.sh` to load the library and use any function defined

Various patterns exist in this code base which make sense to have scripts which fail in a reliable way which reveals the
source issue and are suggested to be used within your own tools.

To install globally:

- Mac OS X: Requires [`port`](https://www.macports.org/install.php) or [`brew`](https://brew.sh/), install `jq`
- Windows: Requires Windows Subsystem for Linux, ensure `jq` is installed
- Copy `bin/build/install-bin-build.sh` to `/usr/local/bin/build/` (or your preferred directory) and
  `sudo /usr/local/bin/build/install-bin-build.sh`
- Source `/usr/local/bin/build/tools.sh` in your scripts to get access to all functions

Directly from the web:

    mkdir -p bin/build && cd bin/build
    curl -s "https://raw.githubusercontent.com/zesk/build/refs/tags/{version}/bin/build/install-bin-build.sh" | bash

## Main entry points

- `bin/build/tools.sh` - The only include required for all build tools functions, also can be used as
  `bin/build/tools.sh identicalCheck ...`

## Project structure

When using **Zesk Build** in your project, the following directories in your project structure have significance:

- `./` - Application root (same as `buildHome`)
- `./bin/build/` - Zesk Build installation location (may *not* be changed)
- `./bin/hooks/` - Application hook implementation (`hook-name` with `.sh` – or other extensions – on the end)
- `./bin/env/` - Your project's environment variables defaults (`NAME` with `.sh` on the end if you use
  `buildEnvironmentLoad` or `buildEnvironmentGet`)
- `./docs/release/v1.0.0.md` - Release notes (override path by adding `BUILD_RELEASE_NOTES` environment)

Internally **Zesk Build** is organized:

- `bin/build/env/*.sh` - All external environment variables are referenced here. Projects should override default
  *behavior* with `./bin/env/*.sh` files.
- `bin/build/tools/*.sh` - Build tools function implementations
- `bin/build/hooks/*.sh` - All default hooks are here - if your application does not implement them - these are used.

## Requirements

Requires:

- `jq` - Parsing JSON files, formatting
- `bc` - Floating-point math
- `awk` `sed` `find` - POSIX utilities
- `curl` or `wget` - Remote installation

Optional:

- `shellcheck` - `bash` linting code
- `pcregrep` - documentation generation and support
- `unzip` - for `awsInstall`

## Simple Zesk Build Loaders

As a shortcut to running functions:

    #!/usr/bin/env bash
    "${BASH_SOURCE[0]%/*}/../bin/build/tools.sh" decorate orange "The code is working."

To load all functions:

    #!/usr/bin/env bash
    # shellcheck source=/dev/null
    if source "${BASH_SOURCE[0]%/*}/../bin/build/tools.sh"; then 
        decorate orange "The code is working."
        decorate big "Hooray."
    else
        printf -- "%s\n" "No tools.sh" 1>&2 && false
    fi

For more complex (and more robust error handling) see `__install` and `__tools` code in `bin/build/identical`.

## Run tests in docker

Scripts support loading one or more environment files and running commands directly in a test container:

    bin/build/tools.sh bitbucketContainer --env-file .STAGING.env bin/test.sh

## Copyright &copy; 2026

All copyrights held by **Market Acumen, Inc.**, a [provider
of infrastructure and cloud expertise.](https://marketacumen.com/executive-technical-assessment-and-reporting/?crcat=code&crsource=zesk-build&crcampaign=README.md&crkw=provider+of+infrastructure+expertise)

License is [MIT License](LICENSE.md). Source can be found online at [GitHub](https://github.com/zesk/build).

Reviewed: 2026-04-22
