#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="encodedValue - String. Required. Value to convert to tokens, one per line"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Convert an array value which was loaded already"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentValueConvertArray"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769055842"
stdout="Array values separated by newlines"$'\n'""
summary="Convert an array value which was loaded already"
usage="environmentValueConvertArray encodedValue [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentValueConvertArray[0m [38;2;255;255;0m[35;48;2;0;0;0mencodedValue[0m[0m [94m[ --help ][0m

    [31mencodedValue  [1;97mString. Required. Value to convert to tokens, one per line[0m
    [94m--help        [1;97mFlag. Optional. Display this help.[0m

Convert an array value which was loaded already

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Array values separated by newlines
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueConvertArray encodedValue [ --help ]

    encodedValue  String. Required. Value to convert to tokens, one per line
    --help        Flag. Optional. Display this help.

Convert an array value which was loaded already

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
Array values separated by newlines
'
