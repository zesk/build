#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="name - String. Required. Name to write."$'\n'"value - EmptyString. Optional. Value to write."$'\n'"... - EmptyString. Optional. Additional values, when supplied, write this value as an array."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Write a value to a state file as NAME=\"value\""$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentValueWrite"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769061401"
summary="Write a value to a state file as NAME=\"value\""
usage="environmentValueWrite name [ value ] [ ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentValueWrite[0m [38;2;255;255;0m[35;48;2;0;0;0mname[0m[0m [94m[ value ][0m [94m[ ... ][0m [94m[ --help ][0m

    [31mname    [1;97mString. Required. Name to write.[0m
    [94mvalue   [1;97mEmptyString. Optional. Value to write.[0m
    [94m...     [1;97mEmptyString. Optional. Additional values, when supplied, write this value as an array.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Write a value to a state file as NAME="value"

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentValueWrite name [ value ] [ ... ] [ --help ]

    name    String. Required. Name to write.
    value   EmptyString. Optional. Value to write.
    ...     EmptyString. Optional. Additional values, when supplied, write this value as an array.
    --help  Flag. Optional. Display this help.

Write a value to a state file as NAME="value"

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
