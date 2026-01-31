#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="tofu.sh"
description="Install tofu binary"$'\n'"Argument: package - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: tofuUninstall packageInstall"$'\n'""
file="bin/build/tools/tofu.sh"
foundNames=()
rawComment="Install tofu binary"$'\n'"Argument: package - String. Optional. Additional packages to install using \`packageInstall\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: tofuUninstall packageInstall"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceHash="43ee145bf6b54d6972866add37ebf9eda9c165df"
summary="Install tofu binary"
usage="tofuInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtofuInstall'$'\e''[0m'$'\n'''$'\n''Install tofu binary'$'\n''Argument: package - String. Optional. Additional packages to install using '$'\e''[[(code)]mpackageInstall'$'\e''[[(reset)]m'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''See: tofuUninstall packageInstall'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tofuInstall'$'\n'''$'\n''Install tofu binary'$'\n''Argument: package - String. Optional. Additional packages to install using packageInstall'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''See: tofuUninstall packageInstall'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.492
