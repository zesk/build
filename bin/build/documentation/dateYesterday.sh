#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="date.sh"
description="Returns yesterday's date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'"Summary: Yesterday's date (UTC time)"$'\n'"Argument: --local - Flag. Optional. Local yesterday"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     rotated=\"\$log.\$({fn} --local)\""$'\n'""
file="bin/build/tools/date.sh"
foundNames=()
rawComment="Returns yesterday's date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'"Summary: Yesterday's date (UTC time)"$'\n'"Argument: --local - Flag. Optional. Local yesterday"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     rotated=\"\$log.\$({fn} --local)\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
summary="Returns yesterday's date, in YYYY-MM-DD format. (same as \`%F\`)"
usage="dateYesterday"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateYesterday'$'\e''[0m'$'\n'''$'\n''Returns yesterday'\''s date, in YYYY-MM-DD format. (same as '$'\e''[[(code)]m%F'$'\e''[[(reset)]m)'$'\n''Summary: Yesterday'\''s date (UTC time)'$'\n''Argument: --local - Flag. Optional. Local yesterday'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     rotated="$log.$(dateYesterday --local)"'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dateYesterday'$'\n'''$'\n''Returns yesterday'\''s date, in YYYY-MM-DD format. (same as %F)'$'\n''Summary: Yesterday'\''s date (UTC time)'$'\n''Argument: --local - Flag. Optional. Local yesterday'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     rotated="$log.$(dateYesterday --local)"'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.452
