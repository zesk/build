# Zesk Build {version}

Zesk Build is a suite of Bash functions which make software development, deployment, and management easier.

Documentation up to date as of {timestamp}.

## Contents

- [Functions](./tools/index.md) - Tons of handy functions. (`./bin/build/tools/*.sh`)
- [Scripts and tools](./tools/bin.md) - Scripts universally useful everywhere. (`./bin/build/*.sh`)
- [Hooks](./tools/hooks.md) - Hooks are a way to customize default behaviors in build scripts. (`./bin/hooks/*.sh`)
- [Environment Variables](./env/index.md) - All environment variables known by Zesk Build. (`./bin/env/*.sh`)

## Introduction

Pipeline, build and operations toolkit.

- Binaries from this project installed at `./bin/build/`
- Optional `hook` binaries can be placed in your project at `./bin/hooks/`
- Files containing bash code end with `.sh`

To use in your pipeline:

- copy `./bin/build/install-bin-build.sh` into your project (changing the last line `../..` if needed) manually
- run it before you need your `./bin/build` directory

## Features

- Application [deployment](./tools/deployment.md) support to multiple hosts with rollback
- Support for [application hooks](./tools/hook.md) and environment
- [Bash prompt support](./tools/prompt.md) with [colors](./tools/decoration.md)
- Bash [documentation](./guide/documentation.md) framework with [automatic usage](./guide/usage.md) in shell and
  markdown documentation
- Comprehensive [argument](./tools/usage.md) validation
- Generic [package](./tools/package.md) interface for system configuration
- Advanced [Bash debugger](./tools/debug.md) features
- Complete [testing](./tools/test.md) and [assertion](./tools/assert.md) framework
- Safe [environment files](./tools/environment.md) support
- Tools
  for [AWS](./tools/aws.md), [crontab](./tools/crontab.md), [daemontools](./tools/daemontools.md), [docker](./tools/docker.md), [interactivity](./tools/interactive.md), [URLs](./tools/url.md),
  versions, and terminal integration

## Usage and arguments

- [Function Reference](./tools/index.md)
- [Binaries](./tools/bin.md)

## Zesk Build Guides

- [Coding Practices](./guide/coding.md)
- [Usage formatting](./guide/usage.md)
- [Documentation](./guide/documentation.md)
- [Functions to be documented](./tools/todo.md)
- [`test` Cheatsheet](./guide/test-cheatsheet.md)
- [Bash Cheatsheet](./guide/bash-cheatsheet.md)
- [Code README](./README.md)

## Deprecated

- [Deprecated functionality](./guide/deprecated.md)

## Copyright and License

- [About Zesk Build](./about.md)

Copyright &copy; 2025 Market Acumen, Inc. All Rights Reserved. Licensed under [MIT License](./LICENSE.md).
