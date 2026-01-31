#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Check if an element exists in an array"$'\n'"Argument: element - EmptyString. Thing to search for"$'\n'"Argument: arrayElement0 ... - Array. Optional. One or more array elements to match"$'\n'"Example:     if inArray \"\$thing\" \"\${things[@]+\"\${things[@]}\"}\"; then"$'\n'"Example:         things+=(\"\$thing\")"$'\n'"Example:     fi"$'\n'"Return Code: 0 - If element is found in array"$'\n'"Return Code: 1 - If element is NOT found in array"$'\n'"Tested: No"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Check if an element exists in an array"$'\n'"Argument: element - EmptyString. Thing to search for"$'\n'"Argument: arrayElement0 ... - Array. Optional. One or more array elements to match"$'\n'"Example:     if inArray \"\$thing\" \"\${things[@]+\"\${things[@]}\"}\"; then"$'\n'"Example:         things+=(\"\$thing\")"$'\n'"Example:     fi"$'\n'"Return Code: 0 - If element is found in array"$'\n'"Return Code: 1 - If element is NOT found in array"$'\n'"Tested: No"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Check if an element exists in an array"
usage="inArray"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]minArray'$'\e''[0m'$'\n'''$'\n''Check if an element exists in an array'$'\n''Argument: element - EmptyString. Thing to search for'$'\n''Argument: arrayElement0 ... - Array. Optional. One or more array elements to match'$'\n''Example:     if inArray "$thing" "${things[@]+"${things[@]}"}"; then'$'\n''Example:         things+=("$thing")'$'\n''Example:     fi'$'\n''Return Code: 0 - If element is found in array'$'\n''Return Code: 1 - If element is NOT found in array'$'\n''Tested: No'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: inArray'$'\n'''$'\n''Check if an element exists in an array'$'\n''Argument: element - EmptyString. Thing to search for'$'\n''Argument: arrayElement0 ... - Array. Optional. One or more array elements to match'$'\n''Example:     if inArray "$thing" "${things[@]+"${things[@]}"}"; then'$'\n''Example:         things+=("$thing")'$'\n''Example:     fi'$'\n''Return Code: 0 - If element is found in array'$'\n''Return Code: 1 - If element is NOT found in array'$'\n''Tested: No'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.488
