#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"packageManager - String. Manager to check."$'\n'""
base="package.sh"
description="Is the package manager supported?"$'\n'"Checks the package manager to be a valid, supported one."$'\n'"Return Code: 0 - The package manager is valid."$'\n'"Return Code: 1 - The package manager is not valid."$'\n'""
file="bin/build/tools/package.sh"
fn="packageManagerValid"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Is the package manager supported?"
usage="packageManagerValid [ --help ] [ packageManager ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageManagerValid[0m [94m[ --help ][0m [94m[ packageManager ][0m

    [94m--help          [1;97mFlag. Optional. Display this help.[0m
    [94mpackageManager  [1;97mString. Manager to check.[0m

Is the package manager supported?
Checks the package manager to be a valid, supported one.
Return Code: 0 - The package manager is valid.
Return Code: 1 - The package manager is not valid.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: packageManagerValid [ --help ] [ packageManager ]

    --help          Flag. Optional. Display this help.
    packageManager  String. Manager to check.

Is the package manager supported?
Checks the package manager to be a valid, supported one.
Return Code: 0 - The package manager is valid.
Return Code: 1 - The package manager is not valid.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
