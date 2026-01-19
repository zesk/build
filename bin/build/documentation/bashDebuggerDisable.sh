#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debugger.sh"
description="Disables the debugger immediately"$'\n'"Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively"$'\n'""$'\n'"    Usage: bashDebuggerDisable [ --help ]"$'\n'""$'\n'""
fn="bashDebuggerDisable"
foundNames=([0]="argument" [1]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashDebug bashDebuggerEnable"$'\n'""
source="bin/build/tools/debugger.sh"
summary="Disables the debugger immediately"
usage="bashDebuggerDisable [ --help ]"
