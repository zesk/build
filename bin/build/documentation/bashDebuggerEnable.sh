#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="debugger.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Enables the debugger immediately.\n\nSaves file descriptors 0 1 and 2 as 20, 21 and 22 respectively\n\n'
descriptionLineCount="4"
file="bin/build/tools/debugger.sh"
fn="bashDebuggerEnable"
fnMarker="bashdebuggerenable"
foundNames=([0]="summary" [1]="____usage" [2]="argument" [3]="see")
line="63"
original="bashDebuggerEnable"
rawComment=$'Summary: Enable the debugger\nEnables the debugger immediately.\n    Usage: bashDebuggerEnable [ --help ]\nArgument: --help - Flag. Optional. Display this help.\nSaves file descriptors 0 1 and 2 as 20, 21 and 22 respectively\nSee: bashDebug bashDebuggerDisable\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'bashDebug bashDebuggerDisable\n'
sourceFile="bin/build/tools/debugger.sh"
sourceHash="bd55a6573cd344af04d89e81c9efb1b1eaf00e5a"
sourceLine="63"
summary="Enable the debugger"
summaryComputed=""
usage="bashDebuggerEnable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDebuggerEnable'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Enables the debugger immediately.'$'\n'''$'\n''Saves file descriptors 0 1 and 2 as 20, 21 and 22 respectively'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashDebuggerEnable [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Enables the debugger immediately.'$'\n'''$'\n''Saves file descriptors 0 1 and 2 as 20, 21 and 22 respectively'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/debug.md"
