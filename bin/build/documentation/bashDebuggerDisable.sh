#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="debugger.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Disables the debugger immediately.\nRestores file descriptors 0 1 and 2 from 20, 21 and 22 respectively\n\n'
descriptionLineCount="3"
file="bin/build/tools/debugger.sh"
fn="bashDebuggerDisable"
fnMarker="bashdebuggerdisable"
foundNames=([0]="summary" [1]="____usage" [2]="argument" [3]="see")
line="98"
original="bashDebuggerDisable"
rawComment=$'Summary: Disable the debugger\nDisables the debugger immediately.\nRestores file descriptors 0 1 and 2 from 20, 21 and 22 respectively\n    Usage: bashDebuggerDisable [ --help ]\nArgument: --help - Flag. Optional. Display this help.\nSee: bashDebug bashDebuggerEnable\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'bashDebug bashDebuggerEnable\n'
sourceFile="bin/build/tools/debugger.sh"
sourceHash="bd55a6573cd344af04d89e81c9efb1b1eaf00e5a"
sourceLine="98"
summary="Disable the debugger"
summaryComputed=""
usage="bashDebuggerDisable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDebuggerDisable'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Disables the debugger immediately.'$'\n''Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashDebuggerDisable [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Disables the debugger immediately.'$'\n''Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/debug.md"
