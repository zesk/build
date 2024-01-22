# Zesk Build Tools

Pipeline, build, and operations tools which are useful across a variety of projects.

- Abstracted bash scripts which work on Unix-style operating system
- Build and deployment tools
- Operational scripts for managing live production systems (system setup, services, cron, permissions separations)

This code toolkit depends largely on `bash` and a conscientious decision has been made to not depend on any other language libraries.

This toolkit makes the following assumptions:

- You are using this with another project to help with your pipeline, build or operations
- Binaries from this project installed at `./bin/build/`
- Files containing bash code end with `.sh`
- Release notes are located in a dedicated subdirectory, named `v1.0.0.md` which match version names (`v1.0.0`)
- A central `$HOME/.build` directory is created to store temporary files and log files; after running certain scripts it can be safely discarded or re-used.

To use in your pipeline:

- copy `bin/build/install-bin-build.sh` into your project (changing `relTop` if needed) manually (this line is the only thing that survives updates)
- run it before you need this code (installed at `bin/build`)

To install it in the operating system:

- Installation can ba accomplished by copying `bin/build/install-bin-build.sh` to `/usr/local/bin/build/` and running it as `root`.

## Main entry points

- `bin/build/tools.sh` - The only include required for all build tools functions (does **NOT** include operations), also can be used as `tools.sh identicalCheck ...`
- `bin/build/ops.sh` - The only include required for all operations tools functions (includes all of `tools.sh` as well), also can be used to run operations commands. (e.g. `ops.sh daemontoollsInstalService ...`)

## Project structure

- `bin/build/env/*.sh` - Any external environment variable is referenced 
- `bin/build/tools/*.sh` - Build tools function implementations.
- `bin/build/pipeline/*.sh` - Tools or steps for deployment
- `bin/build/install/*.sh` - Install dependencies in the pipeline (most of these exist as functions)
- `bin/build/ops/*.sh` - Operations scripts or tools
- `bin/build/hooks/*.sh` - All default hooks are here.

## Other binaries

`bin/build/` contains other tools for simple templating (`map.sh`, global changes `cannon.sh`, release utilities `new-release.sh` and `version-last.sh`.

## Artifacts: Build Directory and `.deploy`

A `./.build` directory is created at your `$HOME` directory, or the project root (if `$HOME` is not set) where log files are generated.

You can preserve the build directory post-build to see the details. Most failures will still output the log but they will not be output to your primary build log unless a failure occurs.

A `./.deploy` directory is created for the `php-build.sh` steps and contains metadata about the deployment.

## Operations

Operations support is currently sparse by goal is to support **setup and configuration** of:

- OS base installation
- Web server
- Application server
- `crontab`
- `daemontools` 

## Run tests in docker

Scripts are written so you can load a `.env` and then run commands directly in a test container:

    bin/build/local-container.sh .env.MYTESTENV -- bin/test.sh --clean


## Tested operating systems

Main issues between platforms are differences between BSD, GNU or POSIX standard tools in the shell.

- Darwin (Mac OS X)
- Ubuntu 22
- debian:latest

If you test on another OS or need support, report an issue.

## Known issues and workarounds

- On Mac OS X the Docker environment thinks non-executable files are executable, notably `bin/build/README.md` is considered `[ -x $file ]` when you are inside the container when the directory is mapped from the operating system. If it's a non-mapped directory, it works fine. Seems to be a bug in how permissions are translated, I assume. Workaround falls
  back to `ls` which is slow but works. See `isExecutable`. Added 2024-01.

## Copyright &copy; 2024 Market Acumen, Inc

License is [MIT License](LICENSE.md). Source can be found online at [GitHub](https://github.com/zesk/build).

(this file is a copy - please modify the original)