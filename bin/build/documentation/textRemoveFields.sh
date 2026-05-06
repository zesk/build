#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="fieldCount - Integer. Optional. Number of field to remove. Default is just first \`1\`."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove fields from left to right from a text file as a pipe"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="textRemoveFields"
fnMarker="textremovefields"
foundNames=([0]="argument" [1]="partial_credit" [2]="stdin" [3]="stdout")
line="1108"
partial_credit="https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899"$'\n'""
rawComment="Remove fields from left to right from a text file as a pipe"$'\n'"Argument: fieldCount - Integer. Optional. Number of field to remove. Default is just first \`1\`."$'\n'"Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899"$'\n'"stdin: A file with fields separated by spaces"$'\n'"stdout: The same file with the first \`fieldCount\` fields removed from each line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="1108"
stdin="A file with fields separated by spaces"$'\n'""
stdout="The same file with the first \`fieldCount\` fields removed from each line."$'\n'""
summary="Remove fields from left to right from a text file"
summaryComputed="true"
usage="textRemoveFields [ fieldCount ]"
