#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debugger.sh"
description="Disables the debugger immediately"$'\n'"Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively"$'\n'""
file="bin/build/tools/debugger.sh"
fn="bashDebuggerDisable"
foundNames=([0]="____usage" [1]="argument" [2]="see")
line="93"
lowerFn="bashdebuggerdisable"
rawComment="Disables the debugger immediately"$'\n'"Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively"$'\n'"    Usage: bashDebuggerDisable [ --help ]"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: bashDebug bashDebuggerEnable"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashDebug bashDebuggerEnable"$'\n'""
sourceFile="bin/build/tools/debugger.sh"
sourceHash="2f829aa199a00fb332fd6b41ece814a617d0375d"
sourceLine="93"
summary="Disables the debugger immediately"
summaryComputed="true"
usage="bashDebuggerDisable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDebuggerDisable'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Disables the debugger immediately'$'\n''Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashDebuggerDisable [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Disables the debugger immediately'$'\n''Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/debug.md"
