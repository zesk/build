#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Converts backticks, bold and italic to console colors."$'\n'""
file="bin/build/tools/colors.sh"
fn="markdownToConsole"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1768758955"
stdin="Markdown"$'\n'""
stdout="decorated console output"$'\n'""
summary="Converts backticks, bold and italic to console colors."$'\n'""
usage="markdownToConsole [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmarkdownToConsole[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Converts backticks, bold and italic to console colors.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Markdown

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
decorated console output
'
# shellcheck disable=SC2016
helpPlain='Usage: markdownToConsole [ --help ]

    --help  Flag. Optional. Display this help.

Converts backticks, bold and italic to console colors.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Markdown

Writes to stdout:
decorated console output
'
