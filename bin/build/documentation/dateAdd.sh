#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="date.sh"
description="Add or subtract days from a text date"$'\n'"Argument: --days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it."$'\n'"Argument: timestamp ... - Date. Timestamp to update."$'\n'"stdout: Date with days added to it"$'\n'"Example:     newYearsEve=\$(dateAdd --days -1 \"2025-01-01\")"$'\n'""
file="bin/build/tools/date.sh"
foundNames=()
rawComment="Add or subtract days from a text date"$'\n'"Argument: --days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it."$'\n'"Argument: timestamp ... - Date. Timestamp to update."$'\n'"stdout: Date with days added to it"$'\n'"Example:     newYearsEve=\$(dateAdd --days -1 \"2025-01-01\")"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
summary="Add or subtract days from a text date"
usage="dateAdd"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateAdd'$'\e''[0m'$'\n'''$'\n''Add or subtract days from a text date'$'\n''Argument: --days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps '$'\e''[[(cyan)]mafter'$'\e''[[(reset)]m it.'$'\n''Argument: timestamp ... - Date. Timestamp to update.'$'\n''stdout: Date with days added to it'$'\n''Example:     newYearsEve=$(dateAdd --days -1 "2025-01-01")'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dateAdd'$'\n'''$'\n''Add or subtract days from a text date'$'\n''Argument: --days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps after it.'$'\n''Argument: timestamp ... - Date. Timestamp to update.'$'\n''stdout: Date with days added to it'$'\n''Example:     newYearsEve=$(dateAdd --days -1 "2025-01-01")'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.455
