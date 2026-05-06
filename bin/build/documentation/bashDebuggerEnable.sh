#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debugger.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Enables the debugger immediately."$'\n'""$'\n'"Saves file descriptors 0 1 and 2 as 20, 21 and 22 respectively"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/debugger.sh"
fn="bashDebuggerEnable"
fnMarker="bashdebuggerenable"
foundNames=([0]="summary" [1]="____usage" [2]="argument" [3]="see")
line="61"
rawComment="Summary: Enable the debugger"$'\n'"Enables the debugger immediately."$'\n'"    Usage: bashDebuggerEnable [ --help ]"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Saves file descriptors 0 1 and 2 as 20, 21 and 22 respectively"$'\n'"See: bashDebug bashDebuggerDisable"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashDebug bashDebuggerDisable"$'\n'""
sourceFile="bin/build/tools/debugger.sh"
sourceHash="eb917fc1a453c6909bff7a48c28fcd6f23dae1ab"
sourceLine="61"
summary="Enable the debugger"
summaryComputed=""
usage="bashDebuggerEnable [ --help ]"
