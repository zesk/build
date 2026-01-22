#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="--local - Flag. Optional. Local today."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
date=""
description="Returns the current date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'""
environment="Compatible with BSD and GNU date."$'\n'""
example="    date=\"\$(todayDate)\""$'\n'""
file="bin/build/tools/date.sh"
fn="todayDate"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceModified="1769056043"
summary="Today's date in UTC"$'\n'""
usage="todayDate [ --local ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtodayDate[0m [94m[ --local ][0m [94m[ --help ][0m

    [94m--local  [1;97mFlag. Optional. Local today.[0m
    [94m--help   [1;97mFlag. Optional. Display this help.[0m

Returns the current date, in YYYY-MM-DD format. (same as [38;2;0;255;0;48;2;0;0;0m%F[0m)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Compatible with BSD and GNU date.
- 

Example:
    date="$(todayDate)"
'
# shellcheck disable=SC2016
helpPlain='Usage: todayDate [ --local ] [ --help ]

    --local  Flag. Optional. Local today.
    --help   Flag. Optional. Display this help.

Returns the current date, in YYYY-MM-DD format. (same as %F)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- Compatible with BSD and GNU date.
- 

Example:
    date="$(todayDate)"
'
