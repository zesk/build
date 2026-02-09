#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-09
# shellcheck disable=SC2034
argument="none"
base="package.sh"
description="Determine the default package manager on this platform."$'\n'"Output is one of:"$'\n'"- apk apt brew port"$'\n'""
file="bin/build/tools/package.sh"
foundNames=([0]="see")
rawComment="Determine the default package manager on this platform."$'\n'"Output is one of:"$'\n'"- apk apt brew port"$'\n'"See: platform"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="platform"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="9446d27b896551a886e9f28cfed65cfe5e5451bf"
summary="Determine the default package manager on this platform."
summaryComputed="true"
usage="packageManagerDefault"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageManagerDefault'$'\e''[0m'$'\n'''$'\n''Determine the default package manager on this platform.'$'\n''Output is one of:'$'\n''- apk apt brew port'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageManagerDefault'$'\n'''$'\n''Determine the default package manager on this platform.'$'\n''Output is one of:'$'\n''- apk apt brew port'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
