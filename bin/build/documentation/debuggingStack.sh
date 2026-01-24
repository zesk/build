#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="-x - Flag. Optional. Show exported variables. (verbose)"$'\n'"--me - Flag. Optional. Show calling function call stack frame."$'\n'"--exit - Flag. Optional. Exit with code 0 after output."$'\n'""
base="dump.sh"
build_debug="debuggingStack - \`debuggingStack\` shows arguments passed (extra) and exports (optional flag) ALWAYS"$'\n'""
description="Dump the function and include stacks and the current environment"$'\n'""
environment="BUILD_DEBUG"$'\n'""
exitCode="0"
file="bin/build/tools/dump.sh"
foundNames=([0]="argument" [1]="requires" [2]="environment" [3]="build_debug")
rawComment="Dump the function and include stacks and the current environment"$'\n'"Argument: -x - Flag. Optional. Show exported variables. (verbose)"$'\n'"Argument: --me - Flag. Optional. Show calling function call stack frame."$'\n'"Argument: --exit - Flag. Optional. Exit with code 0 after output."$'\n'"Requires: printf usageDocument"$'\n'"Environment: BUILD_DEBUG"$'\n'"BUILD_DEBUG: debuggingStack - \`debuggingStack\` shows arguments passed (extra) and exports (optional flag) ALWAYS"$'\n'"Requires: throwArgument"$'\n'""$'\n'""
requires="printf usageDocument"$'\n'"throwArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceModified="1769184734"
summary="Dump the function and include stacks and the current environment"
usage="debuggingStack [ -x ] [ --me ] [ --exit ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdebuggingStack'$'\e''[0m '$'\e''[[blue]m[ -x ]'$'\e''[0m '$'\e''[[blue]m[ --me ]'$'\e''[0m '$'\e''[[blue]m[ --exit ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m-x      '$'\e''[[value]mFlag. Optional. Show exported variables. (verbose)'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--me    '$'\e''[[value]mFlag. Optional. Show calling function call stack frame.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--exit  '$'\e''[[value]mFlag. Optional. Exit with code 0 after output.'$'\e''[[reset]m'$'\n'''$'\n''Dump the function and include stacks and the current environment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG'$'\n'''$'\n'''$'\e''[[code]mBUILD_DEBUG'$'\e''[[reset]m settings:'$'\n''- '$'\e''[[code]mdebuggingStack'$'\e''[[reset]m - '$'\e''[[code]mdebuggingStack'$'\e''[[reset]m shows arguments passed (extra) and exports (optional flag) ALWAYS'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: debuggingStack [ -x ] [ --me ] [ --exit ]'$'\n'''$'\n''    -x      Flag. Optional. Show exported variables. (verbose)'$'\n''    --me    Flag. Optional. Show calling function call stack frame.'$'\n''    --exit  Flag. Optional. Exit with code 0 after output.'$'\n'''$'\n''Dump the function and include stacks and the current environment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG'$'\n'''$'\n''BUILD_DEBUG settings:'$'\n''- debuggingStack - debuggingStack shows arguments passed (extra) and exports (optional flag) ALWAYS'$'\n'''
