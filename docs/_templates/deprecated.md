# Deprecated functionality

[⬅ Return to top](index.md)

This document lists functionality which was removed, why, and when.

- `build-setup.sh` - Previous version of `install-bin-build.sh`. Deprecated 2023.

## Release v0.3.12

- `failed` -> `buildFailed` - Too generic a name

## Release v0.6.0

- `markdown_FormatList` - `markdown_FormatList` - spelling doesn`t like it when we are cute

## Release v0.6.1

- `usageWhich` - `usageRequireBinary usage` - Reworked usage functions

## Release v0.7.0

- `usageWrapper` and `usageWhich`, `usageEnvironment` going the way of the dinosaur

## Release v0.7.9

- `awsHasEnvironment` -> `awsHasEnvironment` - `aws` prefix consistency
- `isAWSKeyUpToDate` -> `awsIsKeyUpToDate`

## Release v0.7.10

- `bin/build/pipeline` files are all deprecated

## Release v0.7.13

- `map.sh` - Previous name for `map.sh`. Deprecated 2023. Prefer the shorter name.
- `copyFileChanged --map` deprecated. Use `copyFileChanged --map` instead.
- `copyFileChanged --map --escalate` deprecated. Use `copyFileChanged --map --escalate`
- `copyFileChanged --escalate` deprecated. `copyFileChanged --escalate`
- `yesNo` -> `parseBoolean`. Better name.

## Release v0.8.4

- `copyFile` -> `copyFile`

## Release v0.10.0

- `wrapLines` -> `wrapLines` (merged)
  = `trimSpace` -> `trimSpace` (merged)

## Release v0.10.4

- `crontabApplicationUpdate` -> `crontabApplicationUpdate` (more accurate name)
- `usageArgumentMissing` -> `usageArgumentMissing` (consistency)
- `usageArgumentUnknown` -> `usageArgumentUnknown` (consistency)

## Release v0.11.1

- `usageArgumentString` -> `usageArgumentString` (consistent type name after `usageArgument` is a design feature)
- `usageArgumentString` -> `usageArgumentEmptyString` (support blank arguments)

- `environmentFileShow` -> `environmentFileShow` (naming consistency)
- `environmentFileApplicationMake` -> `environmentFileApplicationMake` (naming consistency)
- `environmentApplicationVariables` -> `environmentApplicationVariables` (naming consistency)
- `environmentApplicationLoad` -> `environmentApplicationLoad` (naming consistency)

- `dotEnvConfigure` deprecated. Use `environmentFileLoad .env --optional .env.local`

## Release v0.11.2

- `outputTrigger` -> `outputTrigger` (now part of library)

## Release v0.11.4

deprecatedTokens+=(`ops.sh` `__ops`)

## Release v0.11.6

- `bashSanitize` `bashSanitize` (naming consistency)
- `bashLintFiles` `bashLintFiles` (naming consistency)
- `bashLint` `bashLint` (naming consistency)

## Release v0.11.7

## Release v0.11.8

- `aws.sh` `aws.sh`
  deprecatedToken+=(`__try`)

## Release v0.11.9

- `awsRegionValid` `awsRegionValid`

## Release v0.11.10

- `__execute` `__execute`

## Release v0.11.14

- `tarCreate` `tarCreate`

## Release v0.12.2

- `awsSecurityGroupIPModify --register` `awsSecurityGroupIPModify --register`

## Release v0.14.3

- `bin/build/pipeline` binaries are all deprecated.

## Release v0.14.6

`apt` calls are deprecated for new generic `package` functions:

- `packageInstalledList` -> `packageInstalledList` (naming consistency)
- `packageInstall` -> `packageInstall`
- `packageUninstall` `packageUninstall`
- `packageUpdate` `packageUpdate`
- `packageWhich` `packageWhich`
- `packageWhichUninstall` `packageWhichUninstall`
- `packageNeedRestartFlag` `packageNeedRestartFlag`

## Release v0.15.1

Single decoration function:

- `decorate code` -> `decorate code`
- `decorate error` -> `decorate error`
- `decorate orange` -> `decorate orange`
- `decorate bold-orange` -> `decorate bold-orange`
- `decorate blue` -> `decorate blue`
- `decorate bold-blue` -> `decorate bold-blue`
- `decorate red` -> `decorate red`
- `decorate bold-red` -> `decorate bold-red`
- `decorate green` -> `decorate green`
- `decorate bold-green` -> `decorate bold-green`
- `decorate cyan` -> `decorate cyan`
- `decorate bold-cyan` -> `decorate bold-cyan`
- `decorate yellow` -> `decorate yellow`
- `decorate magenta` -> `decorate magenta`
- `decorate black` -> `decorate black`
- `decorate bold-black` -> `decorate bold-black`
- `decorate bold-white` -> `decorate bold-white`
- `decorate white` -> `decorate white`
- `decorate bold-magenta` -> `decorate bold-magenta`
- `decorate underline` -> `decorate underline`
- `decorate bold` -> `decorate bold`
- `decorate no-bold` -> `decorate no-bold`
- `decorate no-underline` -> `decorate no-underline`
- `decorate info` -> `decorate info`
- `decorate warning` -> `decorate warning`
- `decorate success` -> `decorate success`
- `decorate decoration` -> `decorate decoration`
- `decorate subtle` -> `decorate subtle`
- `decorate label` -> `decorate label`
- `decorate value` -> `decorate value`

## Release v0.17.0

- `--env` is changed for most functions which use it; changed to `--env-file` to match other applications.

- [⬅ Return to top](index.md)
