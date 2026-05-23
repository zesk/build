
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
- 
- fixing doc caching issue
- adding debugging to see why test overhead is so high
- Removed double cleanup after tests

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
- `--fingerprint` is now required for `deprecated.sh` and `repair.sh` and `buildFunctionsDerivedCompile`
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

## Zesk Build release v0.42.2

> Copyright &copy; 2026 Market Acumen, Inc.

- Previous version: v0.42.1
- Added `documentationIndexUnlinkedFunctions`
- Added tracing to `returnMessage`
- fixing doc build

## Zesk Build release v0.42.1

> Copyright &copy; 2026 Market Acumen, Inc.

- Previous version: v0.42.0
- `bashPromptModule_BuildProject` had a error output which was incorrect and annoying, fixed.
- `bashPromptModule_TermColors` had an issue with cache busting, fixed.
- Documentation updates and fixes
- `timingDuration` added `--unit` option for specifying the time unit to halt dividing by when outputting. 

## Zesk Build release v0.42.0

> Copyright &copy; 2026 Market Acumen, Inc.

- Previous version: v0.41.3
- Some identicals didn't get copied (`validate`) but functionally didn't affect anything
- `buildTestPlatforms` now operating better; `testSuite` required the current directory to be `buildHome` but now does
  not
- Fixing uninitialized environment variables in `aws-tests.sh`
- Fixing undefined `DOCUMENTATION_SHM`
- `bin/build/deprecated.sh` now ignores its own internal stuff when in other projects, and you can ignore the
  fingerprinting using `--no-fingerprint`
- Added `--quiet` to `buildEnvironmentGet` and `buildEnvironmentLoad` when you don't care if the file is missing
- Added `validate` type for `AWSRegion` and added identical templates `regionArgumentValidation`,
  `__validateTypeAWSRegion`, and `regionArgumentHandler`
- `bashPromptModule_binBuild` is now deprecated, use `bashPromptModule_BuildProject` instead
- `fileRealPath` depends on `readlink -f` which is not available on older version of Mac OS X, so updated for
  compatibility
- `fileRealPath` and `fileRemoveFields` compatibility with older OS versions
- Adding test failure report to end of `testSuite`
- `iTerm2Init` no longer loads `iTerm2Aliases`
- Deprecated renaming:
    - `bashPromptModule_binBuild` -> `bashPromptModule_BuildProject`
    - `newlineHide` -> `stringHideNewlines`
    - `plural` -> `localePlural `
    - `pluralWord` -> `localePluralWord `
    - `cannon` -> `textCannon `
    - `usageDocument` -> `bashDocumentation`
    - `usageDocumentSimple` -> `bashSimpleDocumentation`
    - `logsRotate` (or `logRotates`?) -> `logDirectoryRotate`
- Caching of documentation markdown in source (`bin/build/documentation/*.md`) and `SEE` documentation caching for
  faster builds.
- `logRotate` and `logDirectoryRotate` cleanup

## Zesk Build release v0.41.3

> Copyright &copy; 2026 Market Acumen, Inc.

- Previous version: v0.41.2

### Deprecated functions

Continuing naming fixes to be consistent across the library. `noun-verb`

- `clampDigits` -> `integerClamp`
- `parseBoolean` -> `booleanParse`
- `replaceFirstPattern` -> `textReplaceFirst`
- `stringReplace` -> `textReplace`
- `trimBoth` -> `textTrimBoth`
- `trimHead` -> `textTrimHead`
- `trimTail` -> `textTrimTail`
- `singleBlankLines` -> `textSingleBlankLines`
- `trimRightSpace` -> `textTrimRight`
- `trimLeftSpace` -> `textTrimLeft`
- `trimSpace` -> `textTrim`
- `removeFields` -> `textRemoveFields`
- `loadAverage` -> `cpuLoadAverage`
- `realPath` -> `fileRealPath`
- `trimWords` -> `stringTrimWords`
- `unquote ` -> `stringUnquote `
- `uppercase ` -> `stringUppercase `
- `lowercase ` -> `stringLowercase `
- `usageRequireEnvironment` -> `environmentRequire`
- `veeGitTag` -> `gitTagVee`
- `watchDirectory` -> `directoryWatch`
- `shaPipe` -> `textSHA`
- `rotateLog` -> `logRotate`
- `rotateLogs` -> `logsRotate`
- `randomString` -> `stringRandom`
- `bigText` -> `decorate big`
- `bigTextAt` -> `decorate at`

### Not sure about these - not `noun-verb` but makes sense

- `runCount` -> `executeCount`
- `loopExecute` -> `executeLoop`
- `usageRequireBinary` -> `executableRequire`

### Bug fixes

- `bin/documentation.sh --clean` no longer deletes `bin/build/documentation/` - use `buildUsageCompile --clean` for that
  if needed
- Fixed `markdownRemoveUnfinishedSections` and documentation generator to ensure `## functionName` headers appear in
  generated documentation
- `documentationBuild` no longer resets color scheme
- `bold` no longer redefined in `etc/term-colors.conf` (not recommended either)
- Removed extra bold settings in semantic styles to allow bold to be applied

## Zesk Build release v0.41.2

> Copyright &copy; 2026 Market Acumen, Inc.

- Previous version: v0.41.1
- `__usageDocumentCached` identical updates
- `executableExists` was flagging functions as executable when it should not
- Fixed issues with installer and `bashGetRequires` not correctly flagging missing functions.
- Moved `decorateThemed` to a identical template
- Adding assets and (gasp) tracking to documentation
- Fixed leak in `__bashDocumentation` which was hidden by cached function help

## Zesk Build release v0.41.1

> Copyright &copy; 2026 Market Acumen, Inc.

- Previous version: v0.41.0
- Added [`cpuCount`](../tools/cpu.md#cpucount)
- Foreign [`__usageDocumentCached`](../tools/usage.md#__usagedocumentcached) would cause an error, now does not
- Fixed `deleteFiles` error in [`approvedSources`](../tools/approve.md)
- Some documentation updates and cleanup, added [strftime Cheatsheet](../guide/strftime-cheatsheet.md)
- Fixed issue with [`reloadChanges`](../tools/prompt.md#reloadchanges) getting false positive each run
- [`bashDebugInterruptFile --already-error`](../tools/debug.md#bashdebuginterruptfile) added
- Added [`dumpEnvironment --prefix`](../tools/dump.md#dumpenvironment) match
- Added [`__functionSettings`](../tools/usage.md#__functionsettings) to grant access to compiled function settings

# Past releases

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
