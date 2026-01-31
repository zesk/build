#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Remove fields from left to right from a text file as a pipe"$'\n'"Argument: fieldCount - Integer. Optional. Number of field to remove. Default is just first \`1\`."$'\n'"Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899"$'\n'"stdin: A file with fields separated by spaces"$'\n'"stdout: The same file with the first \`fieldCount\` fields removed from each line."$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Remove fields from left to right from a text file as a pipe"$'\n'"Argument: fieldCount - Integer. Optional. Number of field to remove. Default is just first \`1\`."$'\n'"Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899"$'\n'"stdin: A file with fields separated by spaces"$'\n'"stdout: The same file with the first \`fieldCount\` fields removed from each line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Remove fields from left to right from a text file"
usage="removeFields"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mremoveFields'$'\e''[0m'$'\n'''$'\n''Remove fields from left to right from a text file as a pipe'$'\n''Argument: fieldCount - Integer. Optional. Number of field to remove. Default is just first '$'\e''[[(code)]m1'$'\e''[[(reset)]m.'$'\n''Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899'$'\n''stdin: A file with fields separated by spaces'$'\n''stdout: The same file with the first '$'\e''[[(code)]mfieldCount'$'\e''[[(reset)]m fields removed from each line.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: removeFields'$'\n'''$'\n''Remove fields from left to right from a text file as a pipe'$'\n''Argument: fieldCount - Integer. Optional. Number of field to remove. Default is just first 1.'$'\n''Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899'$'\n''stdin: A file with fields separated by spaces'$'\n''stdout: The same file with the first fieldCount fields removed from each line.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.484
