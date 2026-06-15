#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument="moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules."$'\n'""
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Start bash debugging if it is enabled."$'\n'"This does \`set\` \`-x\` which traces and outputs every shell command."$'\n'"Use it to debug when you can not figure out what is happening internally."$'\n'""$'\n'"\`BUILD_DEBUG\` can be a list of strings like \`environment,assert\` for example."$'\n'""$'\n'"Example:"$'\n'"Example:     buildDebugStart || :"$'\n'""$'\n'""
descriptionLineCount="9"
environment="BUILD_DEBUG"$'\n'""
example="    # ... complex code here"$'\n'"    buildDebugStop || :. -"$'\n'""
file="bin/build/tools/debug.sh"
fn="buildDebugStart"
fnMarker="builddebugstart"
foundNames=([0]="argument" [1]="summary" [2]="environment" [3]="example" [4]="requires" [5]="return_code")
line="96"
rawComment="Argument: moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules."$'\n'"Summary: Start bash debugging"$'\n'"Start bash debugging if it is enabled."$'\n'"This does \`set\` \`-x\` which traces and outputs every shell command."$'\n'"Use it to debug when you can not figure out what is happening internally."$'\n'"\`BUILD_DEBUG\` can be a list of strings like \`environment,assert\` for example."$'\n'"Environment: BUILD_DEBUG"$'\n'"Example:"$'\n'"Example:     buildDebugStart || :"$'\n'"Example:     # ... complex code here"$'\n'"Example:     buildDebugStop || :. -"$'\n'"Requires: buildDebugEnabled"$'\n'"Return Code: 0 - bash debugging was started"$'\n'"Return Code: 1 - bash debugging was not started because token did not match."$'\n'""$'\n'""
requires="buildDebugEnabled"$'\n'""
return_code="0 - bash debugging was started"$'\n'"1 - bash debugging was not started because token did not match."$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="31fe892c1ce36e9aab313274a8fe87aa1c2ff9a6"
sourceLine="96"
summary="Start bash debugging"
summaryComputed=""
usage="buildDebugStart [ moduleName ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildDebugStart'$'\e''[0m '$'\e''[[(blue)]m[ moduleName ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mmoduleName  '$'\e''[[(value)]mString. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.'$'\e''[[(reset)]m'$'\n'''$'\n''Start bash debugging if it is enabled.'$'\n''This does '$'\e''[[(code)]mset'$'\e''[[(reset)]m '$'\e''[[(code)]m-x'$'\e''[[(reset)]m which traces and outputs every shell command.'$'\n''Use it to debug when you can not figure out what is happening internally.'$'\n'''$'\n'''$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m can be a list of strings like '$'\e''[[(code)]menvironment,assert'$'\e''[[(reset)]m for example.'$'\n'''$'\n''Example:'$'\n''Example:     buildDebugStart || :'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - bash debugging was started'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - bash debugging was not started because token did not match.'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG'$'\n'''$'\n''Example:'$'\n''    # ... complex code here'$'\n''    buildDebugStop || :. -'
# shellcheck disable=SC2016
helpPlain='Usage: buildDebugStart [ moduleName ]'$'\n'''$'\n''    moduleName  String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.'$'\n'''$'\n''Start bash debugging if it is enabled.'$'\n''This does set -x which traces and outputs every shell command.'$'\n''Use it to debug when you can not figure out what is happening internally.'$'\n'''$'\n''BUILD_DEBUG can be a list of strings like environment,assert for example.'$'\n'''$'\n''Example:'$'\n''Example:     buildDebugStart || :'$'\n'''$'\n''Return codes:'$'\n''- 0 - bash debugging was started'$'\n''- 1 - bash debugging was not started because token did not match.'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG'$'\n'''$'\n''Example:'$'\n''    # ... complex code here'$'\n''    buildDebugStop || :. -'
documentationPath="documentation/source/tools/debug.md"
