# Zesk Build tools

Pipeline and build-related tools which are useful across a variety of projects.

This toolkit makes the following assumptions:

- You are using this with another project to help with your pipeline and build steps.
- Binaries from this project installed at `./bin/build/`
- Your project: Release notes located at `./docs/release` which are named `v1.0.0.md` where prefix matches tag names (`v1.0.0`)
- A hook exists in your project `./bin/hooks/version-current.sh`
- Optionally a binary exists in your project `./bin/hooks/version-live.sh` (for `bin/build/new-release.sh` - will create a new version each time without it)
- For certain functions, your shell script should define a function `usage` for argument errors and short documentation.
- Most build operations occur at the project root directory but most can be run anywhere by supplying a parameter if needed (`composer.sh` specifically)
- A `.build` directory will be created at your project root which contains marker files as well as log files for the build. It can be deleted safely at any time, but may contain evidence of failures.

To use in your pipeline:

- copy `bin/build/build-setup.sh` into your project (changing `relTop` if needed) manually
- run it before you need your `bin/build` directory

## Project structure

- `bin/build/*.sh` - [Build scripts and tools](./bin/index.md)
- `bin/build/tools/*.sh` - [Build Bash Functions](./tools/index.md)
- `bin/build/pipeline/*.sh` - [Pipeline tools](./pipeline/index.md)
- `bin/build/install/*.sh` - Install dependencies in the pipeline

## Reference

- [Environment variables which affect build](env.md)

