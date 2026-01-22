#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/_sugar.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"value - String. Optional. Value to check if it is a boolean."$'\n'""
base="_sugar.sh"
description="Boolean test"$'\n'"If you want \"true-ish\" use \`isTrue\`."$'\n'"Returns 0 if \`value\` is boolean \`false\` or \`true\`."$'\n'"Is this a boolean? (\`true\` or \`false\`)"$'\n'"Return Code: 0 - if value is a boolean"$'\n'"Return Code: 1 - if value is not a boolean"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="isBoolean"
foundNames=""
requires="usageDocument printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="isTrue parseBoolean"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceModified="1769063211"
summary="Boolean test"
usage="isBoolean [ --help ] [ value ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misBoolean[0m [94m[ --help ][0m [94m[ value ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94mvalue   [1;97mString. Optional. Value to check if it is a boolean.[0m

Boolean test
If you want "true-ish" use [38;2;0;255;0;48;2;0;0;0misTrue[0m.
Returns 0 if [38;2;0;255;0;48;2;0;0;0mvalue[0m is boolean [38;2;0;255;0;48;2;0;0;0mfalse[0m or [38;2;0;255;0;48;2;0;0;0mtrue[0m.
Is this a boolean? ([38;2;0;255;0;48;2;0;0;0mtrue[0m or [38;2;0;255;0;48;2;0;0;0mfalse[0m)
Return Code: 0 - if value is a boolean
Return Code: 1 - if value is not a boolean

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isBoolean [ --help ] [ value ]

    --help  Flag. Optional. Display this help.
    value   String. Optional. Value to check if it is a boolean.

Boolean test
If you want "true-ish" use isTrue.
Returns 0 if value is boolean false or true.
Is this a boolean? (true or false)
Return Code: 0 - if value is a boolean
Return Code: 1 - if value is not a boolean

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
