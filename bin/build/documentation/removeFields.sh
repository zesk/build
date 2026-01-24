#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="fieldCount - Integer. Optional. Number of field to remove. Default is just first \`1\`."$'\n'""
base="text.sh"
description="Remove fields from left to right from a text file as a pipe"$'\n'""
exitCode="0"
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="partial_credit" [2]="stdin" [3]="stdout")
partial_credit="https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899"$'\n'""
rawComment="Remove fields from left to right from a text file as a pipe"$'\n'"Argument: fieldCount - Integer. Optional. Number of field to remove. Default is just first \`1\`."$'\n'"Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899"$'\n'"stdin: A file with fields separated by spaces"$'\n'"stdout: The same file with the first \`fieldCount\` fields removed from each line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769226342"
stdin="A file with fields separated by spaces"$'\n'""
stdout="The same file with the first \`fieldCount\` fields removed from each line."$'\n'""
summary="Remove fields from left to right from a text file"
usage="removeFields [ fieldCount ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mremoveFields'$'\e''[0m '$'\e''[[blue]m[ fieldCount ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mfieldCount  '$'\e''[[value]mInteger. Optional. Number of field to remove. Default is just first '$'\e''[[code]m1'$'\e''[[reset]m.'$'\e''[[reset]m'$'\n'''$'\n''Remove fields from left to right from a text file as a pipe'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''A file with fields separated by spaces'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''The same file with the first '$'\e''[[code]mfieldCount'$'\e''[[reset]m fields removed from each line.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: removeFields [ fieldCount ]'$'\n'''$'\n''    fieldCount  Integer. Optional. Number of field to remove. Default is just first 1.'$'\n'''$'\n''Remove fields from left to right from a text file as a pipe'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''A file with fields separated by spaces'$'\n'''$'\n''Writes to stdout:'$'\n''The same file with the first fieldCount fields removed from each line.'$'\n'''
