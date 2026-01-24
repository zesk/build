#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="--days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it."$'\n'"timestamp ... - Date. Timestamp to update."$'\n'""
base="date.sh"
description="Add or subtract days from a text date"$'\n'""
example="    newYearsEve=\$(dateAdd --days -1 \"2025-01-01\")"$'\n'""
exitCode="0"
file="bin/build/tools/date.sh"
foundNames=([0]="argument" [1]="stdout" [2]="example")
newYearsEve=""
rawComment="Add or subtract days from a text date"$'\n'"Argument: --days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it."$'\n'"Argument: timestamp ... - Date. Timestamp to update."$'\n'"stdout: Date with days added to it"$'\n'"Example:     newYearsEve=\$(dateAdd --days -1 \"2025-01-01\")"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769184556"
stdout="Date with days added to it"$'\n'""
summary="Add or subtract days from a text date"
usage="dateAdd [ --days delta ] [ timestamp ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdateAdd'$'\e''[0m '$'\e''[[blue]m[ --days delta ]'$'\e''[0m '$'\e''[[blue]m[ timestamp ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--days delta   '$'\e''[[value]mSignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps '$'\e''[[cyan]mafter'$'\e''[[reset]m it.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mtimestamp ...  '$'\e''[[value]mDate. Timestamp to update.'$'\e''[[reset]m'$'\n'''$'\n''Add or subtract days from a text date'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''Date with days added to it'$'\n'''$'\n''Example:'$'\n''    newYearsEve=$(dateAdd --days -1 "2025-01-01")'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dateAdd [ --days delta ] [ timestamp ... ]'$'\n'''$'\n''    --days delta   SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps after it.'$'\n''    timestamp ...  Date. Timestamp to update.'$'\n'''$'\n''Add or subtract days from a text date'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''Date with days added to it'$'\n'''$'\n''Example:'$'\n''    newYearsEve=$(dateAdd --days -1 "2025-01-01")'$'\n'''
