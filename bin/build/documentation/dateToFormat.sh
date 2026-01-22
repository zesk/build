#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="date - String. Required. String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"format - String. Optional. Format string for the \`date\` command (e.g. \`%s\`)"$'\n'""
base="date.sh"
description="Converts a date (\`YYYY-MM-DD\`) to another format."$'\n'""$'\n'"Compatible with BSD and GNU date."$'\n'"Return Code: 1 - if parsing fails"$'\n'"Return Code: 0 - if parsing succeeds"$'\n'""
example="    dateToFormat 2023-04-20 %s 1681948800"$'\n'"    timestamp=\$(dateToFormat '2023-10-15' %s)"$'\n'""
file="bin/build/tools/date.sh"
fn="dateToFormat"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceModified="1769063211"
summary="Platform agnostic date conversion"$'\n'""
timestamp=""
usage="dateToFormat date [ format ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdateToFormat[0m [38;2;255;255;0m[35;48;2;0;0;0mdate[0m[0m [94m[ format ][0m

    [31mdate    [1;97mString. Required. String in the form [38;2;0;255;0;48;2;0;0;0mYYYY-MM-DD[0m (e.g. [38;2;0;255;0;48;2;0;0;0m2023-10-15[0m)[0m
    [94mformat  [1;97mString. Optional. Format string for the [38;2;0;255;0;48;2;0;0;0mdate[0m command (e.g. [38;2;0;255;0;48;2;0;0;0m%s[0m)[0m

Converts a date ([38;2;0;255;0;48;2;0;0;0mYYYY-MM-DD[0m) to another format.

Compatible with BSD and GNU date.
Return Code: 1 - if parsing fails
Return Code: 0 - if parsing succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    dateToFormat 2023-04-20 %s 1681948800
    timestamp=$(dateToFormat '\''2023-10-15'\'' %s)
'
# shellcheck disable=SC2016
helpPlain='Usage: dateToFormat date [ format ]

    date    String. Required. String in the form YYYY-MM-DD (e.g. 2023-10-15)
    format  String. Optional. Format string for the date command (e.g. %s)

Converts a date (YYYY-MM-DD) to another format.

Compatible with BSD and GNU date.
Return Code: 1 - if parsing fails
Return Code: 0 - if parsing succeeds

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    dateToFormat 2023-04-20 %s 1681948800
    timestamp=$(dateToFormat '\''2023-10-15'\'' %s)
'
