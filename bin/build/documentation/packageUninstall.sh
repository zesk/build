#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="package.sh"
description="Removes packages using the current package manager."$'\n'"Example:     {fn} shellcheck"$'\n'"Summary: Removes packages using package manager"$'\n'"Argument: package - String. Required. One or more packages to uninstall"$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""
file="bin/build/tools/package.sh"
foundNames=()
rawComment="Removes packages using the current package manager."$'\n'"Example:     {fn} shellcheck"$'\n'"Summary: Removes packages using package manager"$'\n'"Argument: package - String. Required. One or more packages to uninstall"$'\n'"Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="42f79b3d34a0383d43d5dccba57a982493535358"
summary="Removes packages using the current package manager."
usage="packageUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageUninstall'$'\e''[0m'$'\n'''$'\n''Removes packages using the current package manager.'$'\n''Example:     packageUninstall shellcheck'$'\n''Summary: Removes packages using package manager'$'\n''Argument: package - String. Required. One or more packages to uninstall'$'\n''Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageUninstall'$'\n'''$'\n''Removes packages using the current package manager.'$'\n''Example:     packageUninstall shellcheck'$'\n''Summary: Removes packages using package manager'$'\n''Argument: package - String. Required. One or more packages to uninstall'$'\n''Argument: --manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.487
