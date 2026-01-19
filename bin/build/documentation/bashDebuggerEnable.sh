#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debugger.sh"
description="Enables the debugger immediately"$'\n'""$'\n'"    Usage: bashDebuggerEnable [ --help ]"$'\n'""$'\n'"Saves file descriptors 0 1 and 2 as 20, 21 and 22 respectively"$'\n'""
fn="bashDebuggerEnable"
foundNames=([0]="argument" [1]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashDebug bashDebuggerDisable"$'\n'""
source="bin/build/tools/debugger.sh"
summary="Enables the debugger immediately"
usage="bashDebuggerEnable [ --help ]"
