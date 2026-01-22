#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="stateFile - File. Required. File to access, must exist."$'\n'"name - EnvironmentVariable. Required. Name to read."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Read an array value from a state file"$'\n'"Outputs array elements, one per line."$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentValueReadArray"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769061401"
summary="Read an array value from a state file"
usage="environmentValueReadArray stateFile name [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentValueReadArray[0m [38;2;255;255;0m[35;48;2;0;0;0mstateFile[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mname[0m[0m [94m[ --help ][0m

    [31mstateFile  [1;97mFile. Required. File to access, must exist.[0m
    [31mname       [1;97mEnvironmentVariable. Required. Name to read.[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Read an array value from a state file
Outputs array elements, one per line.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueReadArray stateFile name [ --help ]

    stateFile  File. Required. File to access, must exist.
    name       EnvironmentVariable. Required. Name to read.
    --help     Flag. Optional. Display this help.

Read an array value from a state file
Outputs array elements, one per line.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
