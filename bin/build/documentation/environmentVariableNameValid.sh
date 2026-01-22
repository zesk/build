#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="variableName ... - String. Required. Exit status 0 if all variables names are valid ones."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Validates zero or more environment variable names."$'\n'""$'\n'"- alpha"$'\n'"- digit"$'\n'"- underscore"$'\n'""$'\n'"First letter MUST NOT be a digit"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentVariableNameValid"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769061401"
summary="Validates zero or more environment variable names."
usage="environmentVariableNameValid variableName ... [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentVariableNameValid[0m [38;2;255;255;0m[35;48;2;0;0;0mvariableName ...[0m[0m [94m[ --help ][0m

    [31mvariableName ...  [1;97mString. Required. Exit status 0 if all variables names are valid ones.[0m
    [94m--help            [1;97mFlag. Optional. Display this help.[0m

Validates zero or more environment variable names.

- alpha
- digit
- underscore

First letter MUST NOT be a digit

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentVariableNameValid variableName ... [ --help ]

    variableName ...  String. Required. Exit status 0 if all variables names are valid ones.
    --help            Flag. Optional. Display this help.

Validates zero or more environment variable names.

- alpha
- digit
- underscore

First letter MUST NOT be a digit

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
