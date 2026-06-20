#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'element - EmptyString. Thing to search for\narrayElement0 ... - Array. Optional. One or more array elements to match\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Check if an element exists in an array\n\nWithout arguments, displays help.\n\n'
descriptionLineCount="4"
example=$'    if inArray "$thing" "${things[@]+"${things[@]}"}"; then\n        things+=("$thing")\n    fi\n'
file="bin/build/tools/text.sh"
fn="inArray"
fnMarker="inarray"
foundNames=([0]="argument" [1]="example" [2]="return_code" [3]="tested")
line="393"
original="inArray"
rawComment=$'Check if an element exists in an array\nArgument: element - EmptyString. Thing to search for\nArgument: arrayElement0 ... - Array. Optional. One or more array elements to match\nExample:     if inArray "$thing" "${things[@]+"${things[@]}"}"; then\nExample:         things+=("$thing")\nExample:     fi\nReturn Code: 0 - If element is found in array\nReturn Code: 1 - If element is NOT found in array\nTested: No\nWithout arguments, displays help.\n\n'
return_code=$'0 - If element is found in array\n1 - If element is NOT found in array\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="6d769d6727070a6dc8632961d7250fe1f73eea0f"
sourceLine="393"
summary="Check if an element exists in an array"
summaryComputed="true"
tested=$'No\n'
usage="inArray [ element ] [ arrayElement0 ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]minArray'$'\e''[0m '$'\e''[[(blue)]m[ element ]'$'\e''[0m '$'\e''[[(blue)]m[ arrayElement0 ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]melement            '$'\e''[[(value)]mEmptyString. Thing to search for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]marrayElement0 ...  '$'\e''[[(value)]mArray. Optional. One or more array elements to match'$'\e''[[(reset)]m'$'\n'''$'\n''Check if an element exists in an array'$'\n'''$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If element is found in array'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If element is NOT found in array'$'\n'''$'\n''Example:'$'\n''    if inArray "$thing" "${things[@]+"${things[@]}"}"; then'$'\n''        things+=("$thing")'$'\n''    fi'
# shellcheck disable=SC2016
helpPlain='Usage: inArray [ element ] [ arrayElement0 ... ]'$'\n'''$'\n''    element            EmptyString. Thing to search for'$'\n''    arrayElement0 ...  Array. Optional. One or more array elements to match'$'\n'''$'\n''Check if an element exists in an array'$'\n'''$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - If element is found in array'$'\n''- 1 - If element is NOT found in array'$'\n'''$'\n''Example:'$'\n''    if inArray "$thing" "${things[@]+"${things[@]}"}"; then'$'\n''        things+=("$thing")'$'\n''    fi'
documentationPath="documentation/source/tools/text.md"
