#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="--local - Flag. Optional. Local yesterday"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
description="Returns yesterday's date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'""$'\n'""
example="    rotated=\"\$log.\$(yesterdayDate --local)\""$'\n'""
file="bin/build/tools/date.sh"
fn="yesterdayDate"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceModified="1769056043"
summary="Yesterday's date (UTC time)"$'\n'""
usage="yesterdayDate [ --local ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255myesterdayDate[0m [94m[ --local ][0m [94m[ --help ][0m

    [94m--local  [1;97mFlag. Optional. Local yesterday[0m
    [94m--help   [1;97mFlag. Optional. Display this help.[0m

Returns yesterday'\''s date, in YYYY-MM-DD format. (same as [38;2;0;255;0;48;2;0;0;0m%F[0m)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    rotated="$log.$(yesterdayDate --local)"
'
# shellcheck disable=SC2016
helpPlain='Usage: yesterdayDate [ --local ] [ --help ]

    --local  Flag. Optional. Local yesterday
    --help   Flag. Optional. Display this help.

Returns yesterday'\''s date, in YYYY-MM-DD format. (same as %F)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    rotated="$log.$(yesterdayDate --local)"
'
