#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="needle - String. Required."$'\n'"haystack - String. Required."$'\n'""
base="text.sh"
description="Outputs the integer offset of \`needle\` if found as substring in \`haystack\` (case-insensitive)"$'\n'"If \`haystack\` is not found, -1 is output"$'\n'""
file="bin/build/tools/text.sh"
fn="stringOffsetInsensitive"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdout="\`Integer\`. The offset at which the \`needle\` was found in \`haystack\`. Outputs -1 if not found."$'\n'""
summary="Outputs the integer offset of \`needle\` if found as substring"
usage="stringOffsetInsensitive needle haystack"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mstringOffsetInsensitive[0m [38;2;255;255;0m[35;48;2;0;0;0mneedle[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mhaystack[0m[0m

    [31mneedle    [1;97mString. Required.[0m
    [31mhaystack  [1;97mString. Required.[0m

Outputs the integer offset of [38;2;0;255;0;48;2;0;0;0mneedle[0m if found as substring in [38;2;0;255;0;48;2;0;0;0mhaystack[0m (case-insensitive)
If [38;2;0;255;0;48;2;0;0;0mhaystack[0m is not found, -1 is output

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
[38;2;0;255;0;48;2;0;0;0mInteger[0m. The offset at which the [38;2;0;255;0;48;2;0;0;0mneedle[0m was found in [38;2;0;255;0;48;2;0;0;0mhaystack[0m. Outputs -1 if not found.
'
# shellcheck disable=SC2016
helpPlain='Usage: stringOffsetInsensitive needle haystack

    needle    String. Required.
    haystack  String. Required.

Outputs the integer offset of needle if found as substring in haystack (case-insensitive)
If haystack is not found, -1 is output

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
Integer. The offset at which the needle was found in haystack. Outputs -1 if not found.
'
