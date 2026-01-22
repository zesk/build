#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="startLine - Integer. Required. Starting line number."$'\n'"endLine - Integer. Required. Ending line number."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
description="Extract a range of lines from a file"$'\n'""
file="bin/build/tools/text.sh"
fn="fileExtractLines"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
stdin="Reads lines until EOF"$'\n'""
stdout="Outputs the selected lines only"$'\n'""
summary="Extract a range of lines from a file"
usage="fileExtractLines startLine endLine [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileExtractLines[0m [38;2;255;255;0m[35;48;2;0;0;0mstartLine[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mendLine[0m[0m [94m[ --help ][0m

    [31mstartLine  [1;97mInteger. Required. Starting line number.[0m
    [31mendLine    [1;97mInteger. Required. Ending line number.[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Extract a range of lines from a file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Reads lines until EOF

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Outputs the selected lines only
'
# shellcheck disable=SC2016
helpPlain='Usage: fileExtractLines startLine endLine [ --help ]

    startLine  Integer. Required. Starting line number.
    endLine    Integer. Required. Ending line number.
    --help     Flag. Optional. Display this help.

Extract a range of lines from a file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Reads lines until EOF

Writes to stdout:
Outputs the selected lines only
'
