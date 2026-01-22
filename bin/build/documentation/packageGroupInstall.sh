#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="group - String. Required. Currently allowed: \"python\""$'\n'""
base="package.sh"
description="Install a package group"$'\n'"Any unrecognized groups are installed using the name as-is."$'\n'""
file="bin/build/tools/package.sh"
fn="packageGroupInstall"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Install a package group"
usage="packageGroupInstall group"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageGroupInstall[0m [38;2;255;255;0m[35;48;2;0;0;0mgroup[0m[0m

    [31mgroup  [1;97mString. Required. Currently allowed: "python"[0m

Install a package group
Any unrecognized groups are installed using the name as-is.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: packageGroupInstall group

    group  String. Required. Currently allowed: "python"

Install a package group
Any unrecognized groups are installed using the name as-is.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
