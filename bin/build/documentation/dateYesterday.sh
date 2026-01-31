#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--local - Flag. Optional. Local yesterday"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
description="Returns yesterday's date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'""
example="    rotated=\"\$log.\$(dateYesterday --local)\""$'\n'""
file="bin/build/tools/date.sh"
foundNames=([0]="summary" [1]="argument" [2]="example")
rawComment="Returns yesterday's date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'"Summary: Yesterday's date (UTC time)"$'\n'"Argument: --local - Flag. Optional. Local yesterday"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     rotated=\"\$log.\$({fn} --local)\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
rotated=""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
summary="Yesterday's date (UTC time)"$'\n'""
usage="dateYesterday [ --local ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateYesterday'$'\e''[0m '$'\e''[[(blue)]m[ --local ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--local  '$'\e''[[(value)]mFlag. Optional. Local yesterday'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Returns yesterday'\''s date, in YYYY-MM-DD format. (same as '$'\e''[[(code)]m%F'$'\e''[[(reset)]m)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    rotated="$log.$(dateYesterday --local)"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dateYesterday [ --local ] [ --help ]'$'\n'''$'\n''    --local  Flag. Optional. Local yesterday'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Returns yesterday'\''s date, in YYYY-MM-DD format. (same as %F)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    rotated="$log.$(dateYesterday --local)"'$'\n'''
