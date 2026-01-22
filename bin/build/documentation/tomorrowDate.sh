#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="--local - Flag. Optional. Local tomorrow"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
description="Returns tomorrow's date (UTC time), in YYYY-MM-DD format. (same as \`%F\`)"$'\n'""$'\n'""
example="    rotated=\"\$log.\$(tomorrowDate)\""$'\n'""
file="bin/build/tools/date.sh"
fn="tomorrowDate"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
rotated=""
sourceFile="bin/build/tools/date.sh"
sourceModified="1769063211"
summary="Tomorrow's date in UTC"$'\n'""
usage="tomorrowDate [ --local ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtomorrowDate[0m [94m[ --local ][0m [94m[ --help ][0m

    [94m--local  [1;97mFlag. Optional. Local tomorrow[0m
    [94m--help   [1;97mFlag. Optional. Display this help.[0m

Returns tomorrow'\''s date (UTC time), in YYYY-MM-DD format. (same as [38;2;0;255;0;48;2;0;0;0m%F[0m)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    rotated="$log.$(tomorrowDate)"
'
# shellcheck disable=SC2016
helpPlain='Usage: tomorrowDate [ --local ] [ --help ]

    --local  Flag. Optional. Local tomorrow
    --help   Flag. Optional. Display this help.

Returns tomorrow'\''s date (UTC time), in YYYY-MM-DD format. (same as %F)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    rotated="$log.$(tomorrowDate)"
'
