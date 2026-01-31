#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
description="Start build debugging if it is enabled."$'\n'"This does \`set -x\` which traces and outputs every shell command"$'\n'"Use it to debug when you can not figure out what is happening internally."$'\n'"\`BUILD_DEBUG\` can be a list of strings like \`environment,assert\` for example."$'\n'"Environment: BUILD_DEBUG"$'\n'"Argument: moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules."$'\n'"Example:     buildDebugStart || :"$'\n'"Example:     # ... complex code here"$'\n'"Example:     buildDebugStop || :. -"$'\n'"Requires: buildDebugEnabled"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=()
rawComment="Start build debugging if it is enabled."$'\n'"This does \`set -x\` which traces and outputs every shell command"$'\n'"Use it to debug when you can not figure out what is happening internally."$'\n'"\`BUILD_DEBUG\` can be a list of strings like \`environment,assert\` for example."$'\n'"Environment: BUILD_DEBUG"$'\n'"Argument: moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules."$'\n'"Example:     buildDebugStart || :"$'\n'"Example:     # ... complex code here"$'\n'"Example:     buildDebugStop || :. -"$'\n'"Requires: buildDebugEnabled"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="3e4ac7234593313eddb63a76e2aa170841269b82"
summary="Start build debugging if it is enabled."
usage="buildDebugStart"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildDebugStart'$'\e''[0m'$'\n'''$'\n''Start build debugging if it is enabled.'$'\n''This does '$'\e''[[(code)]mset -x'$'\e''[[(reset)]m which traces and outputs every shell command'$'\n''Use it to debug when you can not figure out what is happening internally.'$'\n'''$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m can be a list of strings like '$'\e''[[(code)]menvironment,assert'$'\e''[[(reset)]m for example.'$'\n''Environment: BUILD_DEBUG'$'\n''Argument: moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.'$'\n''Example:     buildDebugStart || :'$'\n''Example:     # ... complex code here'$'\n''Example:     buildDebugStop || :. -'$'\n''Requires: buildDebugEnabled'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildDebugStart'$'\n'''$'\n''Start build debugging if it is enabled.'$'\n''This does set -x which traces and outputs every shell command'$'\n''Use it to debug when you can not figure out what is happening internally.'$'\n''BUILD_DEBUG can be a list of strings like environment,assert for example.'$'\n''Environment: BUILD_DEBUG'$'\n''Argument: moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.'$'\n''Example:     buildDebugStart || :'$'\n''Example:     # ... complex code here'$'\n''Example:     buildDebugStop || :. -'$'\n''Requires: buildDebugEnabled'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.446
