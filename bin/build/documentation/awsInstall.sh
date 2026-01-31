#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="aws.sh"
description="aws Command-Line install"$'\n'"Installs x86 or aarch64 binary based on \`HOSTTYPE\`."$'\n'""
file="bin/build/tools/aws.sh"
foundNames=([0]="requires")
rawComment="aws Command-Line install"$'\n'"Installs x86 or aarch64 binary based on \`HOSTTYPE\`."$'\n'"Requires: packageInstall urlFetch"$'\n'""$'\n'""
requires="packageInstall urlFetch"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="aws Command-Line install"
summaryComputed="true"
usage="awsInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mawsInstall'$'\e''[0m'$'\n'''$'\n''aws Command-Line install'$'\n''Installs x86 or aarch64 binary based on '$'\e''[[(code)]mHOSTTYPE'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: awsInstall'$'\n'''$'\n''aws Command-Line install'$'\n''Installs x86 or aarch64 binary based on [[(code)]mHOSTTYPE.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
# elapsed 3.277
