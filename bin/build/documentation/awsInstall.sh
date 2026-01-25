#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="none"
base="aws.sh"
description="aws Command-Line install"$'\n'"Installs x86 or aarch64 binary based on \`HOSTTYPE\`."$'\n'""
exitCode="0"
file="bin/build/tools/aws.sh"
foundNames=([0]="requires")
rawComment="aws Command-Line install"$'\n'"Installs x86 or aarch64 binary based on \`HOSTTYPE\`."$'\n'"Requires: packageInstall urlFetch"$'\n'""$'\n'""
requires="packageInstall urlFetch"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1769185802"
summary="aws Command-Line install"
usage="awsInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mawsInstall'$'\e''[0m'$'\n'''$'\n''aws Command-Line install'$'\n''Installs x86 or aarch64 binary based on '$'\e''[[code]mHOSTTYPE'$'\e''[[reset]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: awsInstall'$'\n'''$'\n''aws Command-Line install'$'\n''Installs x86 or aarch64 binary based on HOSTTYPE.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
