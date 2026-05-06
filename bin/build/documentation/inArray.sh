#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="element - EmptyString. Thing to search for"$'\n'"arrayElement0 ... - Array. Optional. One or more array elements to match"$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check if an element exists in an array"$'\n'""$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="4"
example="    if inArray \"\$thing\" \"\${things[@]+\"\${things[@]}\"}\"; then"$'\n'"        things+=(\"\$thing\")"$'\n'"    fi"$'\n'""
file="bin/build/tools/text.sh"
fn="inArray"
fnMarker="inarray"
foundNames=([0]="argument" [1]="example" [2]="return_code" [3]="tested")
line="391"
rawComment="Check if an element exists in an array"$'\n'"Argument: element - EmptyString. Thing to search for"$'\n'"Argument: arrayElement0 ... - Array. Optional. One or more array elements to match"$'\n'"Example:     if inArray \"\$thing\" \"\${things[@]+\"\${things[@]}\"}\"; then"$'\n'"Example:         things+=(\"\$thing\")"$'\n'"Example:     fi"$'\n'"Return Code: 0 - If element is found in array"$'\n'"Return Code: 1 - If element is NOT found in array"$'\n'"Tested: No"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - If element is found in array"$'\n'"1 - If element is NOT found in array"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="391"
summary="Check if an element exists in an array"
summaryComputed="true"
tested="No"$'\n'""
usage="inArray [ element ] [ arrayElement0 ... ]"
