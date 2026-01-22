#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/list.sh"
argument="separator - EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter."$'\n'"text0 ... - String. Optional. One or more strings to join"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
description="Output arguments joined by a character"$'\n'""
file="bin/build/tools/list.sh"
fn="listJoin"
output="text"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceModified="1768759476"
summary="Output arguments joined by a character"
usage="listJoin separator [ text0 ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mlistJoin[0m [38;2;255;255;0m[35;48;2;0;0;0mseparator[0m[0m [94m[ text0 ... ][0m [94m[ --help ][0m

    [31mseparator  [1;97mEmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.[0m
    [94mtext0 ...  [1;97mString. Optional. One or more strings to join[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Output arguments joined by a character

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: listJoin separator [ text0 ... ] [ --help ]

    separator  EmptyString. Required. Single character to join elements. If a multi-character string is used only the first character is used as the delimiter.
    text0 ...  String. Optional. One or more strings to join
    --help     Flag. Optional. Display this help.

Output arguments joined by a character

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
