#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="--days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it."$'\n'"timestamp ... - Date. Timestamp to update."$'\n'""
base="date.sh"
description="Add or subtract days from a text date"$'\n'""$'\n'""
example="    newYearsEve=\$(dateAdd --days -1 \"2025-01-01\")"$'\n'""
file="bin/build/tools/date.sh"
fn="dateAdd"
foundNames=([0]="argument" [1]="stdout" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/date.sh"
sourceModified="1768683751"
stdout="Date with days added to it"$'\n'""
summary="Add or subtract days from a text date"
usage="dateAdd [ --days delta ] [ timestamp ... ]"
