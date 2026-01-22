#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="--days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it."$'\n'"timestamp ... - Date. Timestamp to update."$'\n'""
base="date.sh"
description="Add or subtract days from a text date"$'\n'""$'\n'""
example="    newYearsEve=\$(dateAdd --days -1 \"2025-01-01\")"$'\n'""
file="bin/build/tools/date.sh"
fn="dateAdd"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceModified="1769056043"
stdout="Date with days added to it"$'\n'""
summary="Add or subtract days from a text date"
usage="dateAdd [ --days delta ] [ timestamp ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdateAdd[0m [94m[ --days delta ][0m [94m[ timestamp ... ][0m

    [94m--days delta   [1;97mSignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps [36mafter[0m it.[0m
    [94mtimestamp ...  [1;97mDate. Timestamp to update.[0m

Add or subtract days from a text date

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Date with days added to it

Example:
    newYearsEve=$(dateAdd --days -1 "2025-01-01")
'
# shellcheck disable=SC2016
helpPlain='Usage: dateAdd [ --days delta ] [ timestamp ... ]

    --days delta   SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps after it.
    timestamp ...  Date. Timestamp to update.

Add or subtract days from a text date

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
Date with days added to it

Example:
    newYearsEve=$(dateAdd --days -1 "2025-01-01")
'
