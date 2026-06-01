
## Zesk Build release v0.43.1

> Copyright &copy; 2026 Market Acumen, Inc.

- Previous version: v0.43.0
- Fixed `SEE` and documentation generation paths
- Fixed documentation
- Fixed variable undefined in `documentationEnvironmentMake`
- Added fingerprinting to `documentationIdenticalRepair`
- Added hooks `documentation-files` `documentation-fingerprint`
- Added {SEE:bashFunctionNameValid}
- Added {SEE:buildFunctionsExclude} 
- `documentationFilesAdd` now honors `.gitignore` files
- Added `fileModificationTimesBefore` and `fileModificationTimesAfter` 
- `fingerprint` supports `--hook` to allow for alternate files for fingerprinting
- Removed duplicate declaration of `listJoin`
- Added `processCountWatcher`
- Added {SEE:releaseNotesMarkdown}
- `validate "$handler" Fingerprint` now supports `hookName:keyName` syntax to support alternate hooks.
- Switched to the **Apache License**, moved `LICENSE.md` to `LICENSE.txt`
- Semantics of `buildEnvironmentGet` changed to only load variables when the global is unset.
- `pythonVirtual` now deletes non-compatible `.venv` environments when created on another platform (issue with Docker)

## Zesk Build release v0.43.0

> Copyright &copy; 2026 Market Acumen, Inc.

### Documentation Updates

`documentationBuild` was too slow; we are caching documentation effectively using `bin/build/documentation` files so
changing documentation generation was updated to improve speed. Added `mapFunction` to avoid issues with
`mapEnvironment` and to simplify template generation.

Added:

- {SEE:mapFunction}
- {SEE:documentationMaker}
- {SEE:documentationMake}
- Renamed: `documentationBuildEnvironment` -> {SEE:documentationEnvironmentMake}
- Renamed: `documentationBuildCache` -> {SEE:documentationCache}
- Renamed: `documentationTemplateUpdate` -> {SEE:documentationIdenticalRepair}

Deprecated:

- `documentationTemplateFileCompile`
- `documentationTemplateDirectoryCompile`
- `documentationBuild`

### Other updates

- Previous version: v0.42.5
- Added {SEE:mapFunction}
- Added `muzzle` identical template `# IDENTICAL muzzle n`
- Added `--slow slowMilliseconds` to `timing` and `timingReport` to output timing information only if it is slower than
  the specified `slowMilliseconds`.
    - {SEE:timing} and {SEE:timingReport}
- Documentation `/release/` index file generation was broken, now fixed.
- `decorate box --width auto` did not support `stdin` but now does
    - {SEE:__decorateExtensionBox}
- `markdownRemoveUnfinishedSections` now keeps `SEE:token` variables
- `identicalCheck --repair` now added a new macro `__NAME__` which is `__BASE__` without an extension.
- Made `bashDocumentationDeriveSee` and `bashDocumentationDeriveFunction` part of documentation system
- Fixing doc caching issue
- Adding timing debugging to see why test overhead is so high, removed double cleanup after tests
- Ignore `.index` files which were showing up in deprecated runs
- `returnMessage` cleaned up and made smaller
- `bashCoverage` added `bashCoverageEnabled` and fixed issue when unsetting `BUILD_HOME`

## Zesk Build release v0.42.5

> Copyright &copy; 2026 Market Acumen, Inc.

- Previous version: v0.42.4
- Fixed an issue with `identicalCheck` which would double-check some files; also output now more detailed and
  consistent.
- Added `--key` to `bin/build/deprecated.sh` and `bin/build/repair.sh` for `--fingerprint` usage in alternate projects.
- Fixed `buildFunctionsRemoveDeprecated`

## Zesk Build release v0.42.4

> Copyright &copy; 2026 Market Acumen, Inc.

- Previous version: v0.42.3
- Added better error handling for `__fileListColumn` and also `fileOwner`
- Added `__validateTypeFingerprint` aka `validate "$handler" Fingerprint ...`
- `--fingerprint` is now required for `deprecated.sh` and `repair.sh` and `buildFunctionsCompile`
- Added `returnExit` function
  - {SEE:returnExit}
- `validate` semantics changed so that any `__validateType` function which returns 120 (`exit`) the function will exit immediately.

## Zesk Build release v0.42.3

> Copyright &copy; 2026 Market Acumen, Inc.

- Previous version: v0.42.2
- This issue has now been fixed; however, Docker did not update any of these
  issues [On Mac OS X the Docker environment thinks non-executable files are executable](https://github.com/docker/for-mac/issues/5509):
    - notably `bin/build/README.md` is considered `[ -x $file ]` when you are inside the container when the directory is
      mapped from the operating system. If it's a non-mapped directory, it works fine. Seems to be a bug in how
      permissions are translated, I assume. Workaround falls back to `ls` which is slow but works. See `isExecutable`.
      Added 2024-01.
- `__help` -> `helpArgument` and now in main documentation
- Moved `SEE` documentation cache to `bin/build/documentation/SEE`
- Documentation `--md-cache` obsolete, uses `__documentationPath` function

# Past Releases

- [v0.42.2](./v0.42.2.md)
- [v0.42.1](./v0.42.1.md)
- [v0.42.0](./v0.42.0.md)
- [v0.41.3](./v0.41.3.md)
- [v0.41.2](./v0.41.2.md)
- [v0.41.1](./v0.41.1.md)
- [v0.41.0](./v0.41.0.md)
- [v0.40.3](./v0.40.3.md)
- [v0.40.2](./v0.40.2.md)
- [v0.40.1](./v0.40.1.md)
- [v0.40.0](./v0.40.0.md)
- [v0.39.9](./v0.39.9.md)
- [v0.39.8](./v0.39.8.md)
- [v0.39.7](./v0.39.7.md)
- [v0.39.6](./v0.39.6.md)
- [v0.39.5](./v0.39.5.md)
- [v0.39.4](./v0.39.4.md)
- [v0.39.3](./v0.39.3.md)
- [v0.39.2](./v0.39.2.md)
- [v0.39.1](./v0.39.1.md)
- [v0.39.0](./v0.39.0.md)
- [v0.38.3](./v0.38.3.md)
- [v0.38.2](./v0.38.2.md)
- [v0.38.1](./v0.38.1.md)
- [v0.38.0](./v0.38.0.md)
- [v0.37.1](./v0.37.1.md)
- [v0.37.0](./v0.37.0.md)
- [v0.36.1](./v0.36.1.md)
- [v0.36.0](./v0.36.0.md)
- [v0.35.7](./v0.35.7.md)
- [v0.35.6](./v0.35.6.md)
- [v0.35.5](./v0.35.5.md)
- [v0.35.4](./v0.35.4.md)
- [v0.35.3](./v0.35.3.md)
- [v0.35.2](./v0.35.2.md)
- [v0.35.1](./v0.35.1.md)
- [v0.35.0](./v0.35.0.md)
- [v0.34.0](./v0.34.0.md)
- [v0.33.11](./v0.33.11.md)
- [v0.33.10](./v0.33.10.md)
- [v0.33.9](./v0.33.9.md)
- [v0.33.8](./v0.33.8.md)
- [v0.33.7](./v0.33.7.md)
- [v0.33.6](./v0.33.6.md)
- [v0.33.5](./v0.33.5.md)
- [v0.33.4](./v0.33.4.md)
- [v0.33.2](./v0.33.2.md)
- [v0.33.1](./v0.33.1.md)
- [v0.33.0](./v0.33.0.md)
- [v0.32.2](./v0.32.2.md)
- [v0.32.1](./v0.32.1.md)
- [v0.32.0](./v0.32.0.md)
- [v0.31.2](./v0.31.2.md)
- [v0.31.1](./v0.31.1.md)
- [v0.31.0](./v0.31.0.md)
- [v0.30.4](./v0.30.4.md)
- [v0.30.3](./v0.30.3.md)
- [v0.30.2](./v0.30.2.md)
- [v0.30.1](./v0.30.1.md)
- [v0.30.0](./v0.30.0.md)
- [v0.29.3](./v0.29.3.md)
- [v0.29.2](./v0.29.2.md)
- [v0.29.1](./v0.29.1.md)
- [v0.29.0](./v0.29.0.md)
- [v0.28.0](./v0.28.0.md)
- [v0.27.0](./v0.27.0.md)
- [v0.26.1](./v0.26.1.md)
- [v0.26.0](./v0.26.0.md)
- [v0.25.12](./v0.25.12.md)
- [v0.25.11](./v0.25.11.md)
- [v0.25.10](./v0.25.10.md)
- [v0.25.9](./v0.25.9.md)
- [v0.25.8](./v0.25.8.md)
- [v0.25.7](./v0.25.7.md)
- [v0.25.6](./v0.25.6.md)
- [v0.25.5](./v0.25.5.md)
- [v0.25.4](./v0.25.4.md)
- [v0.25.3](./v0.25.3.md)
- [v0.25.2](./v0.25.2.md)
- [v0.25.1](./v0.25.1.md)
- [v0.25.0](./v0.25.0.md)
- [v0.24.1](./v0.24.1.md)
- [v0.24.0](./v0.24.0.md)
- [v0.23.1](./v0.23.1.md)
- [v0.23.0](./v0.23.0.md)
- [v0.22.0](./v0.22.0.md)
- [v0.21.1](./v0.21.1.md)
- [v0.21.0](./v0.21.0.md)
- [v0.20.3](./v0.20.3.md)
- [v0.20.2](./v0.20.2.md)
- [v0.20.1](./v0.20.1.md)
- [v0.20.0](./v0.20.0.md)
- [v0.19.9](./v0.19.9.md)
- [v0.19.8](./v0.19.8.md)
- [v0.19.7](./v0.19.7.md)
- [v0.19.6](./v0.19.6.md)
- [v0.19.5](./v0.19.5.md)
- [v0.19.3](./v0.19.3.md)
- [v0.19.2](./v0.19.2.md)
- [v0.19.1](./v0.19.1.md)
- [v0.19.0](./v0.19.0.md)
- [v0.18.5](./v0.18.5.md)
- [v0.18.4](./v0.18.4.md)
- [v0.18.3](./v0.18.3.md)
- [v0.18.2](./v0.18.2.md)
- [v0.18.1](./v0.18.1.md)
- [v0.18.0](./v0.18.0.md)
- [v0.17.5](./v0.17.5.md)
- [v0.17.4](./v0.17.4.md)
- [v0.17.3](./v0.17.3.md)
- [v0.17.2](./v0.17.2.md)
- [v0.17.1](./v0.17.1.md)
- [v0.17.0](./v0.17.0.md)
- [v0.16.3](./v0.16.3.md)
- [v0.16.2](./v0.16.2.md)
- [v0.16.1](./v0.16.1.md)
- [v0.16.0](./v0.16.0.md)
- [v0.15.0](./v0.15.0.md)
- [v0.14.5](./v0.14.5.md)
- [v0.14.4](./v0.14.4.md)
- [v0.14.3](./v0.14.3.md)
- [v0.14.2](./v0.14.2.md)
- [v0.14.1](./v0.14.1.md)
- [v0.14.0](./v0.14.0.md)
- [v0.13.0](./v0.13.0.md)
- [v0.12.6](./v0.12.6.md)
- [v0.12.5](./v0.12.5.md)
- [v0.12.4](./v0.12.4.md)
- [v0.12.3](./v0.12.3.md)
- [v0.12.2](./v0.12.2.md)
- [v0.12.1](./v0.12.1.md)
- [v0.12.0](./v0.12.0.md)
- [v0.11.16](./v0.11.16.md)
- [v0.11.15](./v0.11.15.md)
- [v0.11.14](./v0.11.14.md)
- [v0.11.13](./v0.11.13.md)
- [v0.11.12](./v0.11.12.md)
- [v0.11.11](./v0.11.11.md)
- [v0.11.10](./v0.11.10.md)
- [v0.11.9](./v0.11.9.md)
- [v0.11.8](./v0.11.8.md)
- [v0.11.7](./v0.11.7.md)
- [v0.11.6](./v0.11.6.md)
- [v0.11.5](./v0.11.5.md)
- [v0.11.4](./v0.11.4.md)
- [v0.11.3](./v0.11.3.md)
- [v0.11.2](./v0.11.2.md)
- [v0.11.1](./v0.11.1.md)
- [v0.11.0](./v0.11.0.md)
- [v0.10.3](./v0.10.3.md)
- [v0.10.2](./v0.10.2.md)
- [v0.10.1](./v0.10.1.md)
- [v0.10.0](./v0.10.0.md)
- [v0.9.6](./v0.9.6.md)
- [v0.9.5](./v0.9.5.md)
- [v0.9.4](./v0.9.4.md)
- [v0.9.3](./v0.9.3.md)
- [v0.9.2](./v0.9.2.md)
- [v0.9.1](./v0.9.1.md)
- [v0.9.0](./v0.9.0.md)
- [v0.8.8](./v0.8.8.md)
- [v0.8.7](./v0.8.7.md)
- [v0.8.6](./v0.8.6.md)
- [v0.8.5](./v0.8.5.md)
- [v0.8.4](./v0.8.4.md)
- [v0.8.3](./v0.8.3.md)
- [v0.8.2](./v0.8.2.md)
- [v0.8.1](./v0.8.1.md)
- [v0.8.0](./v0.8.0.md)
- [v0.7.12](./v0.7.12.md)
- [v0.7.10](./v0.7.10.md)
- [v0.7.9](./v0.7.9.md)
- [v0.7.8](./v0.7.8.md)
- [v0.7.7](./v0.7.7.md)
- [v0.7.6](./v0.7.6.md)
- [v0.7.5](./v0.7.5.md)
- [v0.7.4](./v0.7.4.md)
- [v0.7.3](./v0.7.3.md)
- [v0.7.2](./v0.7.2.md)
- [v0.7.1](./v0.7.1.md)
- [v0.7.0](./v0.7.0.md)
- [v0.6.0](./v0.6.0.md)
- [v0.5.7](./v0.5.7.md)
- [v0.5.6](./v0.5.6.md)
- [v0.5.5](./v0.5.5.md)
- [v0.5.4](./v0.5.4.md)
- [v0.5.3](./v0.5.3.md)
- [v0.5.2](./v0.5.2.md)
- [v0.5.1](./v0.5.1.md)
- [v0.5.0](./v0.5.0.md)
- [v0.4.13](./v0.4.13.md)
- [v0.4.12](./v0.4.12.md)
- [v0.4.11](./v0.4.11.md)
- [v0.4.10](./v0.4.10.md)
- [v0.4.9](./v0.4.9.md)
- [v0.4.8](./v0.4.8.md)
- [v0.4.7](./v0.4.7.md)
- [v0.4.6](./v0.4.6.md)
- [v0.4.5](./v0.4.5.md)
- [v0.4.4](./v0.4.4.md)
- [v0.4.3](./v0.4.3.md)
- [v0.4.2](./v0.4.2.md)
- [v0.4.1](./v0.4.1.md)
- [v0.4.0](./v0.4.0.md)
- [v0.3.23](./v0.3.23.md)
- [v0.3.22](./v0.3.22.md)
- [v0.3.21](./v0.3.21.md)
- [v0.3.20](./v0.3.20.md)
- [v0.3.19](./v0.3.19.md)
- [v0.3.18](./v0.3.18.md)
- [v0.3.17](./v0.3.17.md)
- [v0.3.16](./v0.3.16.md)
- [v0.3.15](./v0.3.15.md)
- [v0.3.14](./v0.3.14.md)
- [v0.3.13](./v0.3.13.md)
- [v0.3.12](./v0.3.12.md)
- [v0.3.11](./v0.3.11.md)
- [v0.3.10](./v0.3.10.md)
- [v0.3.9](./v0.3.9.md)
- [v0.3.8](./v0.3.8.md)
- [v0.3.7](./v0.3.7.md)
- [v0.3.6](./v0.3.6.md)
- [v0.3.5](./v0.3.5.md)
- [v0.3.4](./v0.3.4.md)
- [v0.3.3](./v0.3.3.md)
- [v0.3.2](./v0.3.2.md)
- [v0.3.1](./v0.3.1.md)
- [v0.3.0](./v0.3.0.md)
- [v0.2.1](./v0.2.1.md)
- [v0.2.0](./v0.2.0.md)
- [v0.1.0](./v0.1.0.md)
- [index](./index.md)
