#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"packageManager - String. Manager to check."$'\n'""
base="package.sh"
description="Is the package manager supported?"$'\n'"Checks the package manager to be a valid, supported one."$'\n'""
exitCode="0"
file="bin/build/tools/package.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Is the package manager supported?"$'\n'"Checks the package manager to be a valid, supported one."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: packageManager - String. Manager to check."$'\n'"Return Code: 0 - The package manager is valid."$'\n'"Return Code: 1 - The package manager is not valid."$'\n'""$'\n'""
return_code="0 - The package manager is valid."$'\n'"1 - The package manager is not valid."$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1769184734"
summary="Is the package manager supported?"
usage="packageManagerValid [ --help ] [ packageManager ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mpackageManagerValid'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ packageManager ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help          '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mpackageManager  '$'\e''[[value]mString. Manager to check.'$'\e''[[reset]m'$'\n'''$'\n''Is the package manager supported?'$'\n''Checks the package manager to be a valid, supported one.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - The package manager is valid.'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - The package manager is not valid.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageManagerValid [ --help ] [ packageManager ]'$'\n'''$'\n''    --help          Flag. Optional. Display this help.'$'\n''    packageManager  String. Manager to check.'$'\n'''$'\n''Is the package manager supported?'$'\n''Checks the package manager to be a valid, supported one.'$'\n'''$'\n''Return codes:'$'\n''- 0 - The package manager is valid.'$'\n''- 1 - The package manager is not valid.'$'\n'''
