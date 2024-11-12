# Deprecated functionality

[⬅ Return to top](index.md)

This document lists functionality which was removed, why, and when.

- `build-setup.sh` - Previous version of `install-bin-build.sh`. Deprecated 2023.

## Release v0.3.12

- `failed` -> `buildFailed` - Too generic a name

## Release v0.6.0

- `markdownListify` - `markdown_FormatList` - spelling doesn`t like it when we are cute

## Release v0.6.1

- `usageWhich` - `usageRequireBinary usage` - Reworked usage functions

## Release v0.7.0

- `usageWrapper` and `usageWhich`, `usageEnvironment` going the way of the dinosaur

## Release v0.7.9

- `needAWSEnvironment` -> `awsHasEnvironment` - `aws` prefix consistency
- `isAWSKeyUpToDate` -> `awsIsKeyUpToDate`

## Release v0.7.10

- `bin/build/pipeline` files are all deprecated

## Release v0.7.13

- `envmap.sh` - Previous name for `map.sh`. Deprecated 2023. Prefer the shorter name.
- `mapCopyFileChanged` deprecated. Use `copyFileChanged --map` instead.
- `escalateMapCopyFileChanged` deprecated. Use `copyFileChanged --map --escalate`
- `escalateCopyFileChanged` deprecated. `copyFileChanged --escalate`
- `yesNo` -> `parseBoolean`. Better name.

## Release v0.8.4

- `copyFileChangedQuiet` -> `copyFile`

## Release v0.10.0

- `prefixLines` -> `wrapLines` (merged)
  = `trimSpacePipe` -> `trimSpace` (merged)

## Release v0.10.4

- `crontabApplicationSync` -> `crontabApplicationUpdate` (more accurate name)
- `usageMissingArgument` -> `usageArgumentMissing` (consistency)
- `usageUnknownArgument` -> `usageArgumentUnknown` (consistency)

## Release v0.11.1

- `usageArgumentRequired` -> `usageArgumentString` (consistent type name after `usageArgument` is a design feature)
- `usageArgumentString` -> `usageArgumentEmptyString` (support blank arguments)

- `showEnvironment` -> `environmentFileShow` (naming consistency)
- `makeEnvironment` -> `environmentFileApplicationMake` (naming consistency)
- `applicationEnvironmentVariables` -> `environmentApplicationVariables` (naming consistency)
- `applicationEnvironment` -> `environmentApplicationLoad` (naming consistency)

- `dotEnvConfigure` deprecated. Use `environmentFileLoad .env --optional .env.local`

## Release v0.11.2

- `_environmentOutput` -> `outputTrigger` (now part of library)

## Release v0.11.4

deprecatedTokens+=(`ops.sh` `__ops`)

## Release v0.11.6

- `gitPreCommitShellFiles` `bashSanitize` (naming consistency)
- `validateShellScripts` `bashLintFiles` (naming consistency)
- `validateShellScript` `bashLint` (naming consistency)

## Release v0.11.7

## Release v0.11.8

- `aws-cli.sh` `aws.sh`
  deprecatedToken+=(`__try`)

## Release v0.11.9

- `awsValidRegion` `awsRegionValid`

## Release v0.11.10

- `__return` `__execute`

## Release v0.11.14

- `createTarFile` `tarCreate`

## Release v0.12.2

- `awsSecurityGroupIPRegister` `awsSecurityGroupIPModify --register`

## Release v0.14.3

- `bin/build/pipeline` binaries are all deprecated.

## Release v0.14.6

`apt` calls are deprecated for new generic `package` functions:

- `aptListInstalled` -> `aptInstalledList` (naming consistency)
- `aptInstall` -> `packageInstall`
- `aptUninstall` `packageUninstall`
- `aptUpdateOnce` `packageUpdate`
- `whichApt` `packageWhich`
- `whichAptUninstall` `packageWhichUninstall`
- `aptNeedRestartFlag` `packageNeedRestartFlag`

## Release v0.15.1

Single decoration function:

- `consoleCode` -> `decorate code`
- `consoleError` -> `decorate error`
- `consoleOrange` -> `decorate orange`
- `consoleBoldOrange` -> `decorate bold-orange`
- `consoleBlue` -> `decorate blue`
- `consoleBoldBlue` -> `decorate bold-blue`
- `consoleRed` -> `decorate red`
- `consoleBoldRed` -> `decorate bold-red`
- `consoleGreen` -> `decorate green`
- `consoleBoldGreen` -> `decorate bold-green`
- `consoleCyan` -> `decorate cyan`
- `consoleBoldCyan` -> `decorate bold-cyan`
- `consoleYellow` -> `decorate yellow`
- `consoleMagenta` -> `decorate magenta`
- `consoleBlack` -> `decorate black`
- `consoleBoldBlack` -> `decorate bold-black`
- `consoleBoldWhite` -> `decorate bold-white`
- `consoleWhite` -> `decorate white`
- `consoleBoldMagenta` -> `decorate bold-magenta`
- `consoleUnderline` -> `decorate underline`
- `consoleBold` -> `decorate bold`
- `consoleNoBold` -> `decorate no-bold`
- `consoleNoUnderline` -> `decorate no-underline`
- `consoleInfo` -> `decorate info`
- `consoleWarning` -> `decorate warning`
- `consoleSuccess` -> `decorate success`
- `consoleDecoration` -> `decorate decoration`
- `consoleSubtle` -> `decorate subtle`
- `consoleLabel` -> `decorate label`
- `consoleValue` -> `decorate value`

## Release v0.17.0

- `--env` is changed for most functions which use it; changed to `--env-file` to match other applications.

- [⬅ Return to top](index.md)
