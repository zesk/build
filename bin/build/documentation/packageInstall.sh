#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="package - One or more packages to install"$'\n'"--verbose - Flag. Optional. Display progress to the terminal."$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"--force - Flag. Optional. Force even if it was updated recently."$'\n'"--show-log - Flag. Optional. Show package manager logs."$'\n'""
artifact="\`packageInstall.log\` is left in the \`buildCacheDirectory\`"$'\n'""
base="package.sh"
description="Install packages using a package manager."$'\n'""$'\n'"Supported managers:"$'\n'"- apk"$'\n'"- apt-get"$'\n'"- brew"$'\n'""$'\n'"Return Code: 0 - If \`apk\` is not installed, returns 0."$'\n'"Return Code: 1 - If \`apk\` fails to install the packages"$'\n'""
example="    packageInstall shellcheck"$'\n'""
file="bin/build/tools/package.sh"
fn="packageInstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Install packages using a package manager"$'\n'""
usage="packageInstall [ package ] [ --verbose ] [ --manager packageManager ] [ --force ] [ --show-log ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageInstall[0m [94m[ package ][0m [94m[ --verbose ][0m [94m[ --manager packageManager ][0m [94m[ --force ][0m [94m[ --show-log ][0m

    [94mpackage                   [1;97mOne or more packages to install[0m
    [94m--verbose                 [1;97mFlag. Optional. Display progress to the terminal.[0m
    [94m--manager packageManager  [1;97mString. Optional. Package manager to use. (apk, apt, brew)[0m
    [94m--force                   [1;97mFlag. Optional. Force even if it was updated recently.[0m
    [94m--show-log                [1;97mFlag. Optional. Show package manager logs.[0m

Install packages using a package manager.

Supported managers:
- apk
- apt-get
- brew

Return Code: 0 - If [38;2;0;255;0;48;2;0;0;0mapk[0m is not installed, returns 0.
Return Code: 1 - If [38;2;0;255;0;48;2;0;0;0mapk[0m fails to install the packages

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    packageInstall shellcheck
'
# shellcheck disable=SC2016
helpPlain='Usage: packageInstall [ package ] [ --verbose ] [ --manager packageManager ] [ --force ] [ --show-log ]

    package                   One or more packages to install
    --verbose                 Flag. Optional. Display progress to the terminal.
    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)
    --force                   Flag. Optional. Force even if it was updated recently.
    --show-log                Flag. Optional. Show package manager logs.

Install packages using a package manager.

Supported managers:
- apk
- apt-get
- brew

Return Code: 0 - If apk is not installed, returns 0.
Return Code: 1 - If apk fails to install the packages

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    packageInstall shellcheck
'
