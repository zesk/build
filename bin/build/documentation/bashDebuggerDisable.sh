#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-22
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debugger.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Disables the debugger immediately."$'\n'"Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/debugger.sh"
fn="bashDebuggerDisable"
fnMarker="bashdebuggerdisable"
foundNames=([0]="summary" [1]="____usage" [2]="argument" [3]="see")
line="98"
rawComment="Summary: Disable the debugger"$'\n'"Disables the debugger immediately."$'\n'"Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively"$'\n'"    Usage: bashDebuggerDisable [ --help ]"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: bashDebug bashDebuggerEnable"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashDebug bashDebuggerEnable"$'\n'""
sourceFile="bin/build/tools/debugger.sh"
sourceHash="88503835f6348f148bb8f4c15fc6b863517030bb"
sourceLine="98"
summary="Disable the debugger"
summaryComputed=""
usage="bashDebuggerDisable [ --help ]"
