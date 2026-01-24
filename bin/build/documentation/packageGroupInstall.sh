#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="group - String. Required. Currently allowed: \"python\""$'\n'""
base="package.sh"
description="Install a package group"$'\n'"Any unrecognized groups are installed using the name as-is."$'\n'""
exitCode="0"
file="bin/build/tools/package.sh"
foundNames=([0]="argument")
rawComment="Install a package group"$'\n'"Argument: group - String. Required. Currently allowed: \"python\""$'\n'"Any unrecognized groups are installed using the name as-is."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769184734"
summary="Install a package group"
usage="packageGroupInstall group"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mpackageGroupInstall'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mgroup'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mgroup  '$'\e''[[value]mString. Required. Currently allowed: "python"'$'\e''[[reset]m'$'\n'''$'\n''Install a package group'$'\n''Any unrecognized groups are installed using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageGroupInstall group'$'\n'''$'\n''    group  String. Required. Currently allowed: "python"'$'\n'''$'\n''Install a package group'$'\n''Any unrecognized groups are installed using the name as-is.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
