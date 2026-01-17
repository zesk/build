#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="fieldCount -  Integer. Optional.Number of field to remove. Default is just first \`1\`."$'\n'""
base="text.sh"
description="Remove fields from left to right from a text file as a pipe"$'\n'"Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899"$'\n'""
file="bin/build/tools/text.sh"
fn="removeFields"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768686587"
stdin="A file with fields separated by spaces"$'\n'""
stdout="The same file with the first \`fieldCount\` fields removed from each line."$'\n'""
summary="Remove fields from left to right from a text file"
usage="removeFields [ fieldCount ]"
