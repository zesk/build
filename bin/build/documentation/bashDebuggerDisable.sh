#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debugger.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debugger.sh"
description="Disables the debugger immediately"$'\n'"Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively"$'\n'""$'\n'"    Usage: bashDebuggerDisable [ --help ]"$'\n'""$'\n'""
file="bin/build/tools/debugger.sh"
fn="bashDebuggerDisable"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashDebug bashDebuggerEnable"$'\n'""
sourceFile="bin/build/tools/debugger.sh"
sourceModified="1768761768"
summary="Disables the debugger immediately"
usage="bashDebuggerDisable [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashDebuggerDisable[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Disables the debugger immediately
Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively

    Usage: bashDebuggerDisable [ --help ]

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashDebuggerDisable [ --help ]

    --help  Flag. Optional. Display this help.

Disables the debugger immediately
Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively

    Usage: bashDebuggerDisable [ --help ]

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
