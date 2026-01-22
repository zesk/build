#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="date - String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
description="Converts a date to an integer timestamp"$'\n'""$'\n'"Return Code: 1 - if parsing fails"$'\n'"Return Code: 0 - if parsing succeeds"$'\n'""
environment="Compatible with BSD and GNU date."$'\n'""
example="    timestamp=\$(dateToTimestamp '2023-10-15')"$'\n'""
file="bin/build/tools/date.sh"
fn="dateToTimestamp"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceModified="1769056043"
summary="Converts a date to an integer timestamp"
usage="dateToTimestamp [ date ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdateToTimestamp[0m [94m[ date ][0m [94m[ --help ][0m

    [94mdate    [1;97mString in the form [38;2;0;255;0;48;2;0;0;0mYYYY-MM-DD[0m (e.g. [38;2;0;255;0;48;2;0;0;0m2023-10-15[0m)[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Converts a date to an integer timestamp

Return Code: 1 - if parsing fails
Return Code: 0 - if parsing succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Compatible with BSD and GNU date.
- 

Example:
    timestamp=$(dateToTimestamp '\''2023-10-15'\'')
'
# shellcheck disable=SC2016
helpPlain='Usage: dateToTimestamp [ date ] [ --help ]

    date    String in the form YYYY-MM-DD (e.g. 2023-10-15)
    --help  Flag. Optional. Display this help.

Converts a date to an integer timestamp

Return Code: 1 - if parsing fails
Return Code: 0 - if parsing succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Compatible with BSD and GNU date.
- 

Example:
    timestamp=$(dateToTimestamp '\''2023-10-15'\'')
'
