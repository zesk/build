#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-17
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
depends="-"$'\n'""
description="Returns whether the shell has the debugging flag set"$'\n'"Useful if you need to temporarily enable or disable it."$'\n'""
file="bin/build/tools/debug.sh"
fn="isBashDebug"
foundNames=([0]="depends")
rawComment="Returns whether the shell has the debugging flag set"$'\n'"Useful if you need to temporarily enable or disable it."$'\n'"Depends: -"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="2f51c47feaa2c102da41395dd941f16b4a4a179a"
summary="Returns whether the shell has the debugging flag set"
summaryComputed="true"
usage="isBashDebug"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misBashDebug'$'\e''[0m'$'\n'''$'\n''Returns whether the shell has the debugging flag set'$'\n''Useful if you need to temporarily enable or disable it.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isBashDebug'$'\n'''$'\n''Returns whether the shell has the debugging flag set'$'\n''Useful if you need to temporarily enable or disable it.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
