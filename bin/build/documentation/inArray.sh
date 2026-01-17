#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="element - EmptyString. Thing to search for"$'\n'"arrayElement0 ... - Array. Optional. One or more array elements to match"$'\n'""
base="text.sh"
description="Check if an element exists in an array"$'\n'""$'\n'"Return Code: 0 - If element is found in array"$'\n'"Return Code: 1 - If element is NOT found in array"$'\n'"Without arguments, displays help."$'\n'""
example="    if inArray \"\$thing\" \"\${things[@]+\"\${things[@]}\"}\"; then"$'\n'"        things+=(\"\$thing\")"$'\n'"    fi"$'\n'""
file="bin/build/tools/text.sh"
fn="inArray"
foundNames=([0]="argument" [1]="example" [2]="tested")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768686587"
summary="Check if an element exists in an array"
tested="No"$'\n'""
usage="inArray [ element ] [ arrayElement0 ... ]"
