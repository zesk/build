#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="package - String. Required. One or more packages to uninstall"$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""
base="package.sh"
description="Removes packages using the current package manager."$'\n'""
example="    packageUninstall shellcheck"$'\n'""
file="bin/build/tools/package.sh"
fn="packageUninstall"
foundNames=([0]="example" [1]="summary" [2]="argument")
rawComment="Removes packages using the current package manager."$'\n'"Example:     {fn} shellcheck"$'\n'"Summary: Removes packages using package manager"$'\n'"Argument: package - String. Required. One or more packages to uninstall"$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="99cc82a172db71c0b0f1d98033837052daa954ed"
summary="Removes packages using package manager"$'\n'""
usage="packageUninstall package [ --manager packageManager ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageUninstall'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpackage'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --manager packageManager ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mpackage                   '$'\e''[[(value)]mString. Required. One or more packages to uninstall'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--manager packageManager  '$'\e''[[(value)]mString. Optional. Package manager to use. (apk, apt, brew)'$'\e''[[(reset)]m'$'\n'''$'\n''Removes packages using the current package manager.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    packageUninstall shellcheck'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageUninstall package [ --manager packageManager ]'$'\n'''$'\n''    package                   String. Required. One or more packages to uninstall'$'\n''    --manager packageManager  String. Optional. Package manager to use. (apk, apt, brew)'$'\n'''$'\n''Removes packages using the current package manager.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    packageUninstall shellcheck'$'\n'''
