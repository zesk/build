#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debugger.sh"
description="Disables the debugger immediately"$'\n'"Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively"$'\n'""
file="bin/build/tools/debugger.sh"
fn="bashDebuggerDisable"
foundNames=([0]="____usage" [1]="argument" [2]="see")
rawComment="Disables the debugger immediately"$'\n'"Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively"$'\n'"    Usage: bashDebuggerDisable [ --help ]"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: bashDebug bashDebuggerEnable"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashDebug bashDebuggerEnable"$'\n'""
sourceFile="bin/build/tools/debugger.sh"
sourceHash="6ad7118699fc0df1b74d7db2a4f2a2eda40309d8"
summary="Disables the debugger immediately"
summaryComputed="true"
usage="bashDebuggerDisable [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
