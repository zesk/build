#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--local - Flag. Optional. Local today."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
date=""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Returns the current date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'""$'\n'""
descriptionLineCount="2"
environment="Compatible with BSD and GNU date."$'\n'""
example="    date=\"\$(dateToday)\""$'\n'""
file="bin/build/tools/date.sh"
fn="dateToday"
fnMarker="datetoday"
foundNames=([0]="summary" [1]="argument" [2]="environment" [3]="example")
line="170"
rawComment="Summary: Today's date in UTC"$'\n'"Returns the current date, in YYYY-MM-DD format. (same as \`%F\`)"$'\n'"Argument: --local - Flag. Optional. Local today."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: Compatible with BSD and GNU date."$'\n'"Example:     date=\"\$({fn})\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="8b6a5808143207c1b2329179a4d73d95ea46d8cc"
sourceLine="170"
summary="Today's date in UTC"
summaryComputed=""
usage="dateToday [ --local ] [ --help ]"
