#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/type.sh"
argument="variableName - String. Required. Variable name to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="type.sh"
description="Is a variable declared as an array?"$'\n'""
file="bin/build/tools/type.sh"
fn="isArray"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceModified="1768721470"
summary="Is a variable declared as an array?"
usage="isArray variableName [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misArray[0m [38;2;255;255;0m[35;48;2;0;0;0mvariableName[0m[0m [94m[ --help ][0m

    [31mvariableName  [1;97mString. Required. Variable name to check.[0m
    [94m--help        [1;97mFlag. Optional. Display this help.[0m

Is a variable declared as an array?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isArray variableName [ --help ]

    variableName  String. Required. Variable name to check.
    --help        Flag. Optional. Display this help.

Is a variable declared as an array?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
