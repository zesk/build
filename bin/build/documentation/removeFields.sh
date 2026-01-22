#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="fieldCount - Integer. Optional. Number of field to remove. Default is just first \`1\`."$'\n'""
base="text.sh"
description="Remove fields from left to right from a text file as a pipe"$'\n'"Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899"$'\n'""
file="bin/build/tools/text.sh"
fn="removeFields"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="A file with fields separated by spaces"$'\n'""
stdout="The same file with the first \`fieldCount\` fields removed from each line."$'\n'""
summary="Remove fields from left to right from a text file"
usage="removeFields [ fieldCount ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mremoveFields[0m [94m[ fieldCount ][0m

    [94mfieldCount  [1;97mInteger. Optional. Number of field to remove. Default is just first [38;2;0;255;0;48;2;0;0;0m1[0m.[0m

Remove fields from left to right from a text file as a pipe
Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
A file with fields separated by spaces

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
The same file with the first [38;2;0;255;0;48;2;0;0;0mfieldCount[0m fields removed from each line.
'
# shellcheck disable=SC2016
helpPlain='Usage: removeFields [ fieldCount ]

    fieldCount  Integer. Optional. Number of field to remove. Default is just first 1.

Remove fields from left to right from a text file as a pipe
Partial Credit: https://stackoverflow.com/questions/4198138/printing-everything-except-the-first-field-with-awk/31849899#31849899

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
A file with fields separated by spaces

Writes to stdout:
The same file with the first fieldCount fields removed from each line.
'
