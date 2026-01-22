#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/validate.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"type - String. Optional. Type to validate as \`validate\` type."$'\n'""
base="validate.sh"
description="Are all arguments passed a valid validate type?"$'\n'""
example="    isValidateType string || returnMessage 1 \"string is not a type.\""$'\n'""
file="bin/build/tools/validate.sh"
fn="isValidateType"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/validate.sh"
sourceModified="1768758955"
summary="Are all arguments passed a valid validate type?"
usage="isValidateType [ --help ] [ type ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misValidateType[0m [94m[ --help ][0m [94m[ type ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94mtype    [1;97mString. Optional. Type to validate as [38;2;0;255;0;48;2;0;0;0mvalidate[0m type.[0m

Are all arguments passed a valid validate type?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    isValidateType string || returnMessage 1 "string is not a type."
'
# shellcheck disable=SC2016
helpPlain='Usage: isValidateType [ --help ] [ type ]

    --help  Flag. Optional. Display this help.
    type    String. Optional. Type to validate as validate type.

Are all arguments passed a valid validate type?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    isValidateType string || returnMessage 1 "string is not a type."
'
