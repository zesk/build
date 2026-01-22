#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="none"
base="text.sh"
description="Replaces the first and only the first occurrence of a pattern in a line with a replacement string."$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
fn="replaceFirstPattern"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs modified lines"$'\n'""
summary="Replaces the first and only the first occurrence of a"
usage="replaceFirstPattern"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreplaceFirstPattern[0m

Replaces the first and only the first occurrence of a pattern in a line with a replacement string.
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Reads lines from stdin until EOF

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Outputs modified lines
'
# shellcheck disable=SC2016
helpPlain='Usage: replaceFirstPattern

Replaces the first and only the first occurrence of a pattern in a line with a replacement string.
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Reads lines from stdin until EOF

Writes to stdout:
Outputs modified lines
'
