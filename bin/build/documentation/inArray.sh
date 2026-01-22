#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="element - EmptyString. Thing to search for"$'\n'"arrayElement0 ... - Array. Optional. One or more array elements to match"$'\n'""
base="text.sh"
description="Check if an element exists in an array"$'\n'""$'\n'"Return Code: 0 - If element is found in array"$'\n'"Return Code: 1 - If element is NOT found in array"$'\n'"Without arguments, displays help."$'\n'""
example="    if inArray \"\$thing\" \"\${things[@]+\"\${things[@]}\"}\"; then"$'\n'"        things+=(\"\$thing\")"$'\n'"    fi"$'\n'""
file="bin/build/tools/text.sh"
fn="inArray"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
summary="Check if an element exists in an array"
tested="No"$'\n'""
usage="inArray [ element ] [ arrayElement0 ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255minArray[0m [94m[ element ][0m [94m[ arrayElement0 ... ][0m

    [94melement            [1;97mEmptyString. Thing to search for[0m
    [94marrayElement0 ...  [1;97mArray. Optional. One or more array elements to match[0m

Check if an element exists in an array

Return Code: 0 - If element is found in array
Return Code: 1 - If element is NOT found in array
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    if inArray "$thing" "${things[@]+"${things[@]}"}"; then
        things+=("$thing")
    fi
'
# shellcheck disable=SC2016
helpPlain='Usage: inArray [ element ] [ arrayElement0 ... ]

    element            EmptyString. Thing to search for
    arrayElement0 ...  Array. Optional. One or more array elements to match

Check if an element exists in an array

Return Code: 0 - If element is found in array
Return Code: 1 - If element is NOT found in array
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    if inArray "$thing" "${things[@]+"${things[@]}"}"; then
        things+=("$thing")
    fi
'
