#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="package - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="tofu.sh"
description="Install tofu binary"$'\n'""
file="bin/build/tools/tofu.sh"
foundNames=([0]="argument" [1]="see")
rawComment="Install tofu binary"$'\n'"Argument: package - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: tofuUninstall packageInstall"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="tofuUninstall packageInstall"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceHash="43ee145bf6b54d6972866add37ebf9eda9c165df"
summary="Install tofu binary"
summaryComputed="true"
usage="tofuInstall [ package ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtofuInstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mString. Optional. Additional packages to install using '$'\e''[[(code)]mpackageInstall'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Install tofu binary'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mtofuInstall [ package ] [ --help ]'$'\n'''$'\n''    package  String. Optional. Additional packages to install using packageInstall'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Install tofu binary'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
