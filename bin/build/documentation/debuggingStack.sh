#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="dump.sh"
description="Dump the function and include stacks and the current environment"$'\n'"Argument: -x - Flag. Optional. Show exported variables. (verbose)"$'\n'"Argument: --me - Flag. Optional. Show calling function call stack frame."$'\n'"Argument: --exit - Flag. Optional. Exit with code 0 after output."$'\n'"Requires: printf usageDocument"$'\n'"Environment: BUILD_DEBUG"$'\n'"BUILD_DEBUG: debuggingStack - \`debuggingStack\` shows arguments passed (extra) and exports (optional flag) ALWAYS"$'\n'"Requires: throwArgument"$'\n'""
file="bin/build/tools/dump.sh"
foundNames=()
rawComment="Dump the function and include stacks and the current environment"$'\n'"Argument: -x - Flag. Optional. Show exported variables. (verbose)"$'\n'"Argument: --me - Flag. Optional. Show calling function call stack frame."$'\n'"Argument: --exit - Flag. Optional. Exit with code 0 after output."$'\n'"Requires: printf usageDocument"$'\n'"Environment: BUILD_DEBUG"$'\n'"BUILD_DEBUG: debuggingStack - \`debuggingStack\` shows arguments passed (extra) and exports (optional flag) ALWAYS"$'\n'"Requires: throwArgument"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceHash="6a45ba93dc346627d009bc14e9582d9ccda6e36e"
summary="Dump the function and include stacks and the current environment"
usage="debuggingStack"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdebuggingStack'$'\e''[0m'$'\n'''$'\n''Dump the function and include stacks and the current environment'$'\n''Argument: -x - Flag. Optional. Show exported variables. (verbose)'$'\n''Argument: --me - Flag. Optional. Show calling function call stack frame.'$'\n''Argument: --exit - Flag. Optional. Exit with code 0 after output.'$'\n''Requires: printf usageDocument'$'\n''Environment: BUILD_DEBUG'$'\n''BUILD_DEBUG: debuggingStack - '$'\e''[[(code)]mdebuggingStack'$'\e''[[(reset)]m shows arguments passed (extra) and exports (optional flag) ALWAYS'$'\n''Requires: throwArgument'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: debuggingStack'$'\n'''$'\n''Dump the function and include stacks and the current environment'$'\n''Argument: -x - Flag. Optional. Show exported variables. (verbose)'$'\n''Argument: --me - Flag. Optional. Show calling function call stack frame.'$'\n''Argument: --exit - Flag. Optional. Exit with code 0 after output.'$'\n''Requires: printf usageDocument'$'\n''Environment: BUILD_DEBUG'$'\n''BUILD_DEBUG: debuggingStack - debuggingStack shows arguments passed (extra) and exports (optional flag) ALWAYS'$'\n''Requires: throwArgument'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.482
