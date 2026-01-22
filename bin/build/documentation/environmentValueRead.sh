#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="stateFile - EnvironmentFile. Required. File to read a value from."$'\n'"name - EnvironmentVariable. Required. Variable to read."$'\n'"default - EmptyString. Optional. Default value of the environment variable if it does not exist."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Return Code: 1 - If value is not found and no default argument is supplied (2 arguments)"$'\n'"Return Code: 0 - If value"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentValueRead"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769055842"
summary="Return Code: 1 - If value is not found and"
usage="environmentValueRead stateFile name [ default ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentValueRead[0m [38;2;255;255;0m[35;48;2;0;0;0mstateFile[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mname[0m[0m [94m[ default ][0m [94m[ --help ][0m

    [31mstateFile  [1;97mEnvironmentFile. Required. File to read a value from.[0m
    [31mname       [1;97mEnvironmentVariable. Required. Variable to read.[0m
    [94mdefault    [1;97mEmptyString. Optional. Default value of the environment variable if it does not exist.[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Return Code: 1 - If value is not found and no default argument is supplied (2 arguments)
Return Code: 0 - If value

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueRead stateFile name [ default ] [ --help ]

    stateFile  EnvironmentFile. Required. File to read a value from.
    name       EnvironmentVariable. Required. Variable to read.
    default    EmptyString. Optional. Default value of the environment variable if it does not exist.
    --help     Flag. Optional. Display this help.

Return Code: 1 - If value is not found and no default argument is supplied (2 arguments)
Return Code: 0 - If value

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
