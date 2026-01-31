#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="tofu.sh"
description="Uninstall tofu binary and apt sources keys"$'\n'"Argument: package - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: tofuInstall packageUninstall"$'\n'""
file="bin/build/tools/tofu.sh"
foundNames=()
rawComment="Uninstall tofu binary and apt sources keys"$'\n'"Argument: package - String. Optional. Additional packages to uninstall using \`packageUninstall\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: tofuInstall packageUninstall"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/tofu.sh"
sourceHash="43ee145bf6b54d6972866add37ebf9eda9c165df"
summary="Uninstall tofu binary and apt sources keys"
usage="tofuUninstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtofuUninstall'$'\e''[0m'$'\n'''$'\n''Uninstall tofu binary and apt sources keys'$'\n''Argument: package - String. Optional. Additional packages to uninstall using '$'\e''[[(code)]mpackageUninstall'$'\e''[[(reset)]m'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''See: tofuInstall packageUninstall'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: tofuUninstall'$'\n'''$'\n''Uninstall tofu binary and apt sources keys'$'\n''Argument: package - String. Optional. Additional packages to uninstall using packageUninstall'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''See: tofuInstall packageUninstall'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.541
