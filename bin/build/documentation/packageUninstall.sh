#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="package - String. Required. One or more packages to uninstall"$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""
base="package.sh"
description="Removes packages using the current package manager."$'\n'""$'\n'""
example="    packageUninstall shellcheck"$'\n'""
file="bin/build/tools/package.sh"
fn="packageUninstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1769063211"
summary="Removes packages using package manager"$'\n'""
usage="packageUninstall package [ --manager packageManager ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageUninstall[0m [38;2;255;255;0m[35;48;2;0;0;0mpackage[0m[0m [94m[ --manager packageManager ][0m

    [31mpackage                   [1;97mString. Required. One or more packages to uninstall[0m
    [94m--manager packageManager  [1;97mString. Optional. Package manager to use. (apk, apt, brew)[0m

Removes packages using the current package manager.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    packageUninstall shellcheck
'
# shellcheck disable=SC2016
helpPlain='Usage: packageUninstall package [ --manager packageManager ]

    package                   String. Required. One or more packages to uninstall
    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)

Removes packages using the current package manager.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    packageUninstall shellcheck
'
