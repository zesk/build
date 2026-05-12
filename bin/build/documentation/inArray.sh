#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
rawComment=$'Check if an element exists in an array\nArgument: element - EmptyString. Thing to search for\nArgument: arrayElement0 ... - Array. Optional. One or more array elements to match\nExample:     if inArray "$thing" "${things[@]+"${things[@]}"}"; then\nExample:         things+=("$thing")\nExample:     fi\nReturn Code: 0 - If element is found in array\nReturn Code: 1 - If element is NOT found in array\nTested: No\nWithout arguments, displays help.\n\n'
return_code=$'0 - If element is found in array\n1 - If element is NOT found in array\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="393"
summary="Check if an element exists in an array"
summaryComputed="true"
tested=$'No\n'
usage="inArray [ element ] [ arrayElement0 ... ]"
