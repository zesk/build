#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="package.sh"
description="Is the package manager supported?"$'\n'"Checks the package manager to be a valid, supported one."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: packageManager - String. Manager to check."$'\n'"Return Code: 0 - The package manager is valid."$'\n'"Return Code: 1 - The package manager is not valid."$'\n'""
file="bin/build/tools/package.sh"
foundNames=()
rawComment="Is the package manager supported?"$'\n'"Checks the package manager to be a valid, supported one."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: packageManager - String. Manager to check."$'\n'"Return Code: 0 - The package manager is valid."$'\n'"Return Code: 1 - The package manager is not valid."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="42f79b3d34a0383d43d5dccba57a982493535358"
summary="Is the package manager supported?"
usage="packageManagerValid"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageManagerValid'$'\e''[0m'$'\n'''$'\n''Is the package manager supported?'$'\n''Checks the package manager to be a valid, supported one.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: packageManager - String. Manager to check.'$'\n''Return Code: 0 - The package manager is valid.'$'\n''Return Code: 1 - The package manager is not valid.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageManagerValid'$'\n'''$'\n''Is the package manager supported?'$'\n''Checks the package manager to be a valid, supported one.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: packageManager - String. Manager to check.'$'\n''Return Code: 0 - The package manager is valid.'$'\n''Return Code: 1 - The package manager is not valid.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.492
