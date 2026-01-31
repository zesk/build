#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="debugger.sh"
description="Disables the debugger immediately"$'\n'"Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively"$'\n'"    Usage: bashDebuggerDisable [ --help ]"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: bashDebug bashDebuggerEnable"$'\n'""
file="bin/build/tools/debugger.sh"
foundNames=()
rawComment="Disables the debugger immediately"$'\n'"Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively"$'\n'"    Usage: bashDebuggerDisable [ --help ]"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: bashDebug bashDebuggerEnable"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debugger.sh"
sourceHash="6ad7118699fc0df1b74d7db2a4f2a2eda40309d8"
summary="Disables the debugger immediately"
usage="bashDebuggerDisable"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDebuggerDisable'$'\e''[0m'$'\n'''$'\n''Disables the debugger immediately'$'\n''Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively'$'\n''    Usage: bashDebuggerDisable [ --help ]'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''See: bashDebug bashDebuggerEnable'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashDebuggerDisable'$'\n'''$'\n''Disables the debugger immediately'$'\n''Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively'$'\n''    Usage: bashDebuggerDisable [ --help ]'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''See: bashDebug bashDebuggerEnable'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.462
