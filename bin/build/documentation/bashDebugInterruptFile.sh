#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--error - Flag. Add ERR trap."$'\n'"--interrupt - Flag. Add INT trap."$'\n'""
base="debug.sh"
description="Adds a trap to capture the debugging stack on interrupt"$'\n'"Use this in a bash script which runs forever or runs in an infinite loop to"$'\n'"determine where the problem or loop exists."$'\n'""
file="bin/build/tools/debug.sh"
fn="bashDebugInterruptFile"
requires="trap"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769059754"
summary="Adds a trap to capture the debugging stack on interrupt"
usage="bashDebugInterruptFile [ --help ] [ --error ] [ --interrupt ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashDebugInterruptFile[0m [94m[ --help ][0m [94m[ --error ][0m [94m[ --interrupt ][0m

    [94m--help       [1;97mFlag. Optional. Display this help.[0m
    [94m--error      [1;97mFlag. Add ERR trap.[0m
    [94m--interrupt  [1;97mFlag. Add INT trap.[0m

Adds a trap to capture the debugging stack on interrupt
Use this in a bash script which runs forever or runs in an infinite loop to
determine where the problem or loop exists.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashDebugInterruptFile [ --help ] [ --error ] [ --interrupt ]

    --help       Flag. Optional. Display this help.
    --error      Flag. Add ERR trap.
    --interrupt  Flag. Add INT trap.

Adds a trap to capture the debugging stack on interrupt
Use this in a bash script which runs forever or runs in an infinite loop to
determine where the problem or loop exists.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
