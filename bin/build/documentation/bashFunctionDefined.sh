#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="functionName - String. Required. Name of function to check."$'\n'"file ... - File. Required. One or more files to check if a function is defined within."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Is a function defined in a bash source file?"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFunctionDefined"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1768776883"
summary="Is a function defined in a bash source file?"$'\n'""
usage="bashFunctionDefined functionName file ... [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashFunctionDefined[0m [38;2;255;255;0m[35;48;2;0;0;0mfunctionName[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfile ...[0m[0m [94m[ --help ][0m

    [31mfunctionName  [1;97mString. Required. Name of function to check.[0m
    [31mfile ...      [1;97mFile. Required. One or more files to check if a function is defined within.[0m
    [94m--help        [1;97mFlag. Optional. Display this help.[0m

Is a function defined in a bash source file?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionDefined functionName file ... [ --help ]

    functionName  String. Required. Name of function to check.
    file ...      File. Required. One or more files to check if a function is defined within.
    --help        Flag. Optional. Display this help.

Is a function defined in a bash source file?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
