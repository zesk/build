# Zesk Build tools

Pipeline and build-related tools which are useful across a variety of projects.

This toolkit makes the following assumptions:

- You are using this with another project to help with your pipeline and build steps.
- Binaries from this project installed at `./bin/build/`
- Your project: Release notes located at `./docs/release` which are named `v1.0.0.md` where prefix matches tag names (`v1.0.0`)
- A hook exists in your project `./bin/hooks/version-current.sh`
- Optionally a binary exists in your project `./bin/hooks/version-live.sh` (for `bin/build/new-release.sh` - will create a new version each time without it)
- Most build operations occur at the project root directory but most can be run anywhere by supplying a parameter if needed (`composer.sh` specifically)
- A `.build` directory may be created to store cache files

To use in your pipeline:

- copy `./bin/build/install-bin-build.sh` into your project (changing `relTop` if needed) manually
- run it before you need your `./bin/build` directory

## Zesk Build Functionality

- `./bin/build/*.sh` - [Build scripts and tools](./bin/index.md) - Handy scripts universally useful everywhere.
- `./bin/build/tools/*.sh` - [Build Bash Functions](./tools/index.md) - Lots of handy functions
- `./bin/build/pipeline/*.sh` - [Pipeline tools](./pipeline/index.md) - Do work related to building and deploying software.
- `./bin/build/install/*.sh` - Install dependencies in the pipeline - most of these exist as functions
- `./bin/hooks/*.sh` - [Build Hooks](./hooks/index.md) - Hooks are a way to customize default behaviors in build scripts.

## Reference

- [Environment variables which affect build](env.md)

