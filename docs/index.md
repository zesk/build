# Zesk Build tools

Pipeline and build-related tools which are useful across a variety of projects.

This toolkit makes the following assumptions:

- You are using this with another project to help with your pipeline, build or operations
- Binaries from this project installed at `./bin/build/`
- Optional `hook` binaries can be placed in your project at `./bin/hooks/`
- Files containing bash code end with `.sh`
- Your project has release notes located in a dedicated subdirectory, files named `v1.0.0.md` where prefix matches tag names (`v1.0.0`)
- **Most** build operations occur at the project root directory
- A central `$HOME/.build` directory is created to store temporary files and log files; after running certain scripts it can be safely discarded or re-used.

To use in your pipeline:

- copy `./bin/build/install-bin-build.sh` into your project (changing the `../..` path if needed) manually
- run it before you need your `./bin/build` directory

## Zesk Build Functionality

- `./bin/build/*.sh` - [Build scripts and tools](./bin/bin) - Handy scripts universally useful everywhere.
- `./bin/build/tools/*.sh` - [Build Bash Functions](./tools/index.md) - Lots of handy functions
- `./bin/build/pipeline/*.sh` - [Pipeline tools](./pipeline/index.md) - Do work related to building and deploying software.
- `./bin/build/ops/*.sh` - [Operations tools](./ops/index.md) - Do work related to building and deploying software.
- `./bin/build/install/*.sh` - Install dependencies in the pipeline - most of these exist as functions
- `./bin/hooks/*.sh` - [Build Hooks](./hooks/index.md) - Hooks are a way to customize default behaviors in build scripts.

## Usage and arguments

- [Function Reference](./tools/index.md)
- [Binaries](./tools/bin.md)

## Zesk Build Guides

- [Coding Practices](./coding.md)
- [Usage formatting](./guide/usage.md)
- [Documentation](./guide/documentation.md)
- [Functions to be documented](./tools/todo.md)
- [Test cheatsheet](./test-cheatsheet.md)

## Zesk Build Reference

- [Environment variables which affect build](env.md)
- [Deprecated functionality](./deprecated.md)

## Copyright and License

Copyright &copy; 2025 Market Acumen, Inc. All Rights Reserved. Licensed under [MIT License](../LICENSE.md).
