#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--local - Flag. Optional. Local today."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
date=""
description="Returns the current date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'""
environment="Compatible with BSD and GNU date."$'\n'""
example="    date=\"\$(dateToday)\""$'\n'""
file="bin/build/tools/date.sh"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="example")
rawComment="Summary: Today's date in UTC"$'\n'"Returns the current date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'"Argument: --local - Flag. Optional. Local today."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: Compatible with BSD and GNU date."$'\n'"Example:     date=\"\$({fn})\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
summary="Today's date in UTC"$'\n'""
usage="dateToday [ --local ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateToday'$'\e''[0m '$'\e''[[(blue)]m[ --local ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--local  '$'\e''[[(value)]mFlag. Optional. Local today.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Returns the current date, in YYYY-MM-DD format. (same as '$'\e''[[(code)]m%F'$'\e''[[(reset)]m)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- Compatible with BSD and GNU date.'$'\n'''$'\n''Example:'$'\n''    date="$(dateToday)"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mdateToday [ --local ] [ --help ]'$'\n'''$'\n''    --local  Flag. Optional. Local today.'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Returns the current date, in YYYY-MM-DD format. (same as %F)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- Compatible with BSD and GNU date.'$'\n'''$'\n''Example:'$'\n''    date="$(dateToday)"'$'\n'''
