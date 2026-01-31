#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it."$'\n'"timestamp ... - Date. Timestamp to update."$'\n'""
base="date.sh"
description="Add or subtract days from a text date"$'\n'""
example="    newYearsEve=\$(dateAdd --days -1 \"2025-01-01\")"$'\n'""
file="bin/build/tools/date.sh"
foundNames=([0]="argument" [1]="stdout" [2]="example")
newYearsEve=""
rawComment="Add or subtract days from a text date"$'\n'"Argument: --days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it."$'\n'"Argument: timestamp ... - Date. Timestamp to update."$'\n'"stdout: Date with days added to it"$'\n'"Example:     newYearsEve=\$(dateAdd --days -1 \"2025-01-01\")"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
stdout="Date with days added to it"$'\n'""
summary="Add or subtract days from a text date"
summaryComputed="true"
usage="dateAdd [ --days delta ] [ timestamp ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateAdd'$'\e''[0m '$'\e''[[(blue)]m[ --days delta ]'$'\e''[0m '$'\e''[[(blue)]m[ timestamp ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--days delta   '$'\e''[[(value)]mSignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps '$'\e''[[(cyan)]mafter'$'\e''[[(reset)]m it.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtimestamp ...  '$'\e''[[(value)]mDate. Timestamp to update.'$'\e''[[(reset)]m'$'\n'''$'\n''Add or subtract days from a text date'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Date with days added to it'$'\n'''$'\n''Example:'$'\n''    newYearsEve=$(dateAdd --days -1 "2025-01-01")'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mdateAdd [ --days delta ] [ timestamp ... ]'$'\n'''$'\n''    --days delta   SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps after it.'$'\n''    timestamp ...  Date. Timestamp to update.'$'\n'''$'\n''Add or subtract days from a text date'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''Date with days added to it'$'\n'''$'\n''Example:'$'\n''    newYearsEve=$(dateAdd --days -1 "2025-01-01")'$'\n'''
# elapsed 3.47
