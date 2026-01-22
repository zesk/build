#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="needle - String. Required. String to replace."$'\n'"replacement - EmptyString.  String to replace needle with."$'\n'"haystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input."$'\n'""
base="text.sh"
description="Replace all occurrences of a string within another string"$'\n'""
file="bin/build/tools/text.sh"
fn="stringReplace"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769063211"
stdin="If no haystack supplied reads from standard input and replaces the string on each line read."$'\n'""
stdout="New string with needle replaced"$'\n'""
summary="Replace all occurrences of a string within another string"
usage="stringReplace needle [ replacement ] [ haystack ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mstringReplace[0m [38;2;255;255;0m[35;48;2;0;0;0mneedle[0m[0m [94m[ replacement ][0m [94m[ haystack ][0m

    [31mneedle       [1;97mString. Required. String to replace.[0m
    [94mreplacement  [1;97mEmptyString.  String to replace needle with.[0m
    [94mhaystack     [1;97mEmptyString. Optional. String to modify. If not supplied, reads from standard input.[0m

Replace all occurrences of a string within another string

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
If no haystack supplied reads from standard input and replaces the string on each line read.

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
New string with needle replaced
'
# shellcheck disable=SC2016
helpPlain='Usage: stringReplace needle [ replacement ] [ haystack ]

    needle       String. Required. String to replace.
    replacement  EmptyString.  String to replace needle with.
    haystack     EmptyString. Optional. String to modify. If not supplied, reads from standard input.

Replace all occurrences of a string within another string

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
If no haystack supplied reads from standard input and replaces the string on each line read.

Writes to stdout:
New string with needle replaced
'
