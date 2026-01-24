#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tofu.sh"
argument="package - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="tofu.sh"
description="Install tofu binary"$'\n'""
exitCode="0"
file="bin/build/tools/tofu.sh"
foundNames=([0]="argument" [1]="see")
rawComment="Install tofu binary"$'\n'"Argument: package - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: tofuUninstall packageInstall"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="tofuUninstall packageInstall"$'\n'""
sourceModified="1769184734"
summary="Install tofu binary"
usage="tofuInstall [ package ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mtofuInstall'$'\e''[0m '$'\e''[[blue]m[ package ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mpackage  '$'\e''[[value]mString. Optional. Additional packages to install using '$'\e''[[code]mpackageInstall'$'\e''[[reset]m'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help   '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Install tofu binary'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tofuInstall [ package ] [ --help ]'$'\n'''$'\n''    package  String. Optional. Additional packages to install using packageInstall'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Install tofu binary'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
