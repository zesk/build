#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="element - EmptyString. Thing to search for"$'\n'"arrayElement0 ... - Array. Optional. One or more array elements to match"$'\n'""
base="text.sh"
description="Check if an element exists in an array"$'\n'"Without arguments, displays help."$'\n'""
example="    if inArray \"\$thing\" \"\${things[@]+\"\${things[@]}\"}\"; then"$'\n'"        things+=(\"\$thing\")"$'\n'"    fi"$'\n'""
exitCode="0"
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="example" [2]="return_code" [3]="tested")
rawComment="Check if an element exists in an array"$'\n'"Argument: element - EmptyString. Thing to search for"$'\n'"Argument: arrayElement0 ... - Array. Optional. One or more array elements to match"$'\n'"Example:     if inArray \"\$thing\" \"\${things[@]+\"\${things[@]}\"}\"; then"$'\n'"Example:         things+=(\"\$thing\")"$'\n'"Example:     fi"$'\n'"Return Code: 0 - If element is found in array"$'\n'"Return Code: 1 - If element is NOT found in array"$'\n'"Tested: No"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - If element is found in array"$'\n'"1 - If element is NOT found in array"$'\n'""
sourceModified="1769320918"
summary="Check if an element exists in an array"
tested="No"$'\n'""
usage="inArray [ element ] [ arrayElement0 ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]minArray'$'\e''[0m '$'\e''[[blue]m[ element ]'$'\e''[0m '$'\e''[[blue]m[ arrayElement0 ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]melement            '$'\e''[[value]mEmptyString. Thing to search for'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]marrayElement0 ...  '$'\e''[[value]mArray. Optional. One or more array elements to match'$'\e''[[reset]m'$'\n'''$'\n''Check if an element exists in an array'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - If element is found in array'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - If element is NOT found in array'$'\n'''$'\n''Example:'$'\n''    if inArray "$thing" "${things[@]+"${things[@]}"}"; then'$'\n''        things+=("$thing")'$'\n''    fi'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: inArray [ element ] [ arrayElement0 ... ]'$'\n'''$'\n''    element            EmptyString. Thing to search for'$'\n''    arrayElement0 ...  Array. Optional. One or more array elements to match'$'\n'''$'\n''Check if an element exists in an array'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - If element is found in array'$'\n''- 1 - If element is NOT found in array'$'\n'''$'\n''Example:'$'\n''    if inArray "$thing" "${things[@]+"${things[@]}"}"; then'$'\n''        things+=("$thing")'$'\n''    fi'$'\n'''
