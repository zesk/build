#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="none"
base="package.sh"
description="Determine the default package manager on this platform."$'\n'"Output is one of:"$'\n'"- apk apt brew port"$'\n'""
file="bin/build/tools/package.sh"
fn="packageManagerDefault"
foundNames=([0]="see")
line="625"
lowerFn="packagemanagerdefault"
rawComment="Determine the default package manager on this platform."$'\n'"Output is one of:"$'\n'"- apk apt brew port"$'\n'"See: platform"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="platform"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="06e25fa25995eb0e6d2d2931f09e11b0a6055bee"
sourceLine="625"
summary="Determine the default package manager on this platform."
summaryComputed="true"
usage="packageManagerDefault"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageManagerDefault'$'\e''[0m'$'\n'''$'\n''Determine the default package manager on this platform.'$'\n''Output is one of:'$'\n''- apk apt brew port'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageManagerDefault'$'\n'''$'\n''Determine the default package manager on this platform.'$'\n''Output is one of:'$'\n''- apk apt brew port'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/package.md"
