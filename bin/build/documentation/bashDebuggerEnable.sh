#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debugger.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debugger.sh"
description="Enables the debugger immediately"$'\n'""$'\n'"    Usage: bashDebuggerEnable [ --help ]"$'\n'""$'\n'"Saves file descriptors 0 1 and 2 as 20, 21 and 22 respectively"$'\n'""
file="bin/build/tools/debugger.sh"
fn="bashDebuggerEnable"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashDebug bashDebuggerDisable"$'\n'""
sourceFile="bin/build/tools/debugger.sh"
sourceModified="1769063211"
summary="Enables the debugger immediately"
usage="bashDebuggerEnable [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashDebuggerEnable[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Enables the debugger immediately

    Usage: bashDebuggerEnable [ --help ]

Saves file descriptors 0 1 and 2 as 20, 21 and 22 respectively

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashDebuggerEnable [ --help ]

    --help  Flag. Optional. Display this help.

Enables the debugger immediately

    Usage: bashDebuggerEnable [ --help ]

Saves file descriptors 0 1 and 2 as 20, 21 and 22 respectively

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
