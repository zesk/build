#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it."$'\n'"timestamp ... - Date. Timestamp to update."$'\n'""
base="date.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add or subtract days from a text date"$'\n'""$'\n'""
descriptionLineCount="2"
example="    newYearsEve=\$(dateAdd --days -1 \"2025-01-01\")"$'\n'""
file="bin/build/tools/date.sh"
fn="dateAdd"
fnMarker="dateadd"
foundNames=([0]="argument" [1]="stdout" [2]="example")
line="219"
newYearsEve=""
rawComment="Add or subtract days from a text date"$'\n'"Argument: --days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it."$'\n'"Argument: timestamp ... - Date. Timestamp to update."$'\n'"stdout: Date with days added to it"$'\n'"Example:     newYearsEve=\$(dateAdd --days -1 \"2025-01-01\")"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="8b6a5808143207c1b2329179a4d73d95ea46d8cc"
sourceLine="219"
stdout="Date with days added to it"$'\n'""
summary="Add or subtract days from a text date"
summaryComputed="true"
usage="dateAdd [ --days delta ] [ timestamp ... ]"
