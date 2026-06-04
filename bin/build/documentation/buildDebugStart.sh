#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.\n'
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Start build debugging if it is enabled.\nThis does `set -x` which traces and outputs every shell command\nUse it to debug when you can not figure out what is happening internally.\n\n`BUILD_DEBUG` can be a list of strings like `environment,assert` for example.\nExample:     buildDebugStart || :\n\n'
descriptionLineCount="7"
environment=$'BUILD_DEBUG\n'
example=$'    # ... complex code here\n    buildDebugStop || :. -\n'
file="bin/build/tools/debug.sh"
fn="buildDebugStart"
fnMarker="builddebugstart"
foundNames=([0]="environment" [1]="argument" [2]="example" [3]="requires")
line="88"
rawComment=$'Start build debugging if it is enabled.\nThis does `set -x` which traces and outputs every shell command\nUse it to debug when you can not figure out what is happening internally.\n`BUILD_DEBUG` can be a list of strings like `environment,assert` for example.\nEnvironment: BUILD_DEBUG\nArgument: moduleName - String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.\nExample:     buildDebugStart || :\nExample:     # ... complex code here\nExample:     buildDebugStop || :. -\nRequires: buildDebugEnabled\n\n'
requires=$'buildDebugEnabled\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/debug.sh"
sourceHash="f8901f960335e712ac2680d77a17c49c8edcae50"
sourceLine="88"
summary="Start build debugging if it is enabled."
summaryComputed="true"
usage="buildDebugStart [ moduleName ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildDebugStart'$'\e''[0m '$'\e''[[(blue)]m[ moduleName ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mmoduleName  '$'\e''[[(value)]mString. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.'$'\e''[[(reset)]m'$'\n'''$'\n''Start build debugging if it is enabled.'$'\n''This does '$'\e''[[(code)]mset -x'$'\e''[[(reset)]m which traces and outputs every shell command'$'\n''Use it to debug when you can not figure out what is happening internally.'$'\n'''$'\n'''$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m can be a list of strings like '$'\e''[[(code)]menvironment,assert'$'\e''[[(reset)]m for example.'$'\n''Example:     buildDebugStart || :'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG'$'\n'''$'\n''Example:'$'\n''    # ... complex code here'$'\n''    buildDebugStop || :. -'
# shellcheck disable=SC2016
helpPlain='Usage: buildDebugStart [ moduleName ]'$'\n'''$'\n''    moduleName  String. Optional. Only start debugging if debugging is enabled for ANY of the passed in modules.'$'\n'''$'\n''Start build debugging if it is enabled.'$'\n''This does set -x which traces and outputs every shell command'$'\n''Use it to debug when you can not figure out what is happening internally.'$'\n'''$'\n''BUILD_DEBUG can be a list of strings like environment,assert for example.'$'\n''Example:     buildDebugStart || :'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG'$'\n'''$'\n''Example:'$'\n''    # ... complex code here'$'\n''    buildDebugStop || :. -'
documentationPath="documentation/source/tools/debug.md"
