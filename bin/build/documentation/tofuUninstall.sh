#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tofu.sh"
argument="package - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="tofu.sh"
description="Uninstall tofu binary and apt sources keys"$'\n'""
file="bin/build/tools/tofu.sh"
foundNames=([0]="argument" [1]="see")
rawComment="Uninstall tofu binary and apt sources keys"$'\n'"Argument: package - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: tofuInstall packageUninstall"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="tofuInstall packageUninstall"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceModified="1769184734"
summary="Uninstall tofu binary and apt sources keys"
usage="tofuUninstall [ package ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtofuUninstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mString. Optional. Additional packages to uninstall using '$'\e''[[(code)]mpackageUninstall'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Uninstall tofu binary and apt sources keys'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tofuUninstall [ package ] [ --help ]'$'\n'''$'\n''    package  String. Optional. Additional packages to uninstall using packageUninstall'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Uninstall tofu binary and apt sources keys'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.565
