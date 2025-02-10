# Zesk Build tools

Pipeline and build-related tools which are useful across a variety of projects.

This toolkit makes the following assumptions:

- Binaries from this project installed at `./bin/build/`
- Optional `hook` binaries can be placed in your project at `./bin/hooks/`
- Files containing bash code end with `.sh`
- Your project has release notes located in a dedicated subdirectory, files named `v1.0.0.md` (for version `1.0.0`)

To use in your pipeline:

- copy `./bin/build/install-bin-build.sh` into your project (changing the last line `../..` if needed) manually
- run it before you need your `./bin/build` directory

## Features overview

- Application deployment support
- Support for application hooks and environment
- Bash prompt support with colors and extensions
- Bash documentation framework with automatic documentation
- Comprehensive argument validation
- Generic package interface for system configuration
- Advanced Bash debugger features
- Complete testing and assertion framework
- Safe environment files support

## Zesk Build Functionality

- `./bin/build/*.sh` - [Build scripts and tools](./tools/bin.md) - Scripts universally useful everywhere.
- `./bin/build/tools/*.sh` - [Build Bash Functions](./tools/index.md) - Tons of handy functions.
- `./bin/hooks/*.sh` - [Build Hooks](./tools/hooks.md) - Hooks are a way to customize default behaviors in build scripts.

## Usage and arguments

- [Function Reference](./tools/index.md)
- [Binaries](./tools/bin.md)

## Zesk Build Guides

- [Coding Practices](./coding.md)
- [Usage formatting](./guide/usage.md)
- [Documentation](./guide/documentation.md)
- [Functions to be documented](./tools/todo.md)
- [`test` Cheatsheet](./test-cheatsheet.md)
- [Bash Cheatsheet](./bash-cheatsheet.md)

## Zesk Build Reference

- [Environment variables which affect build](env.md)
- [Deprecated functionality](./deprecated.md)

## Copyright and License

Copyright &copy; 2025 Market Acumen, Inc. All Rights Reserved. Licensed under [MIT License](../LICENSE.md).
