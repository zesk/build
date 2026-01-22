#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="integerTimestamp - Integer. Required. Integer timestamp offset (unix timestamp, same as \`\$(date +%s)\`)"$'\n'"format - String. Optional. How to output the date (e.g. \`%F\` - no \`+\` is required)"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--local - Flag. Optional. Show the local time, not UTC."$'\n'""
base="date.sh"
dateField=""
description="Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)"$'\n'""$'\n'"dateFromTimestamp 1681966800 %F"$'\n'""$'\n'"Return Code: 0 - If parsing is successful"$'\n'"Return Code: 1 - If parsing fails"$'\n'""
environment="Compatible with BSD and GNU date."$'\n'""
example="    dateField=\$(dateFromTimestamp \$init %Y)"$'\n'""
file="bin/build/tools/date.sh"
fn="dateFromTimestamp"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceModified="1769056043"
summary="Converts an integer date to a date formatted timestamp (e.g."
usage="dateFromTimestamp integerTimestamp [ format ] [ --help ] [ --local ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdateFromTimestamp[0m [38;2;255;255;0m[35;48;2;0;0;0mintegerTimestamp[0m[0m [94m[ format ][0m [94m[ --help ][0m [94m[ --local ][0m

    [31mintegerTimestamp  [1;97mInteger. Required. Integer timestamp offset (unix timestamp, same as [38;2;0;255;0;48;2;0;0;0m$(date +%s)[0m)[0m
    [31mformat            [1;97mString. Optional. How to output the date (e.g. [38;2;0;255;0;48;2;0;0;0m%F[0m - no [38;2;0;255;0;48;2;0;0;0m+[0m is required)[0m
    [94m--help            [1;97mFlag. Optional. Display this help.[0m
    [94m--local           [1;97mFlag. Optional. Show the local time, not UTC.[0m

Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)

dateFromTimestamp 1681966800 %F

Return Code: 0 - If parsing is successful
Return Code: 1 - If parsing fails

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Compatible with BSD and GNU date.
- 

Example:
    dateField=$(dateFromTimestamp $init %Y)
'
# shellcheck disable=SC2016
helpPlain='Usage: dateFromTimestamp integerTimestamp [ format ] [ --help ] [ --local ]

    integerTimestamp  Integer. Required. Integer timestamp offset (unix timestamp, same as $(date +%s))
    format            String. Optional. How to output the date (e.g. %F - no + is required)
    --help            Flag. Optional. Display this help.
    --local           Flag. Optional. Show the local time, not UTC.

Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)

dateFromTimestamp 1681966800 %F

Return Code: 0 - If parsing is successful
Return Code: 1 - If parsing fails

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Compatible with BSD and GNU date.
- 

Example:
    dateField=$(dateFromTimestamp $init %Y)
'
