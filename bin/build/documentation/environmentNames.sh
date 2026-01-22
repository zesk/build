#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="List names of environment values set in a bash state file"$'\n'""
example="    environmentNames < \"\$stateFile\""$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentNames"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769063211"
summary="List names of environment values set in a bash state"
usage="environmentNames [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentNames[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

List names of environment values set in a bash state file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    environmentNames < "$stateFile"
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentNames [ --help ]

    --help  Flag. Optional. Display this help.

List names of environment values set in a bash state file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    environmentNames < "$stateFile"
'
