#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--local - Flag. Optional. Local tomorrow"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Returns tomorrow's date (UTC time), in \`YYYY-MM-DD\` format. (same as \`%F\`)"$'\n'""$'\n'""
descriptionLineCount="2"
example="    rotated=\"\$log.\$(dateTomorrow)\""$'\n'""
file="bin/build/tools/date.sh"
fn="dateTomorrow"
fnMarker="datetomorrow"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
line="145"
rawComment="Summary: Tomorrow's date in UTC"$'\n'"Returns tomorrow's date (UTC time), in \`YYYY-MM-DD\` format. (same as \`%F\`)"$'\n'"Argument: --local - Flag. Optional. Local tomorrow"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     rotated=\"\$log.\$({fn})\""$'\n'"Requires: throwArgument date convertValue dateFromTimestamp bashDocumentation"$'\n'""$'\n'""
requires="throwArgument date convertValue dateFromTimestamp bashDocumentation"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
rotated=""
sourceFile="bin/build/tools/date.sh"
sourceHash="8b6a5808143207c1b2329179a4d73d95ea46d8cc"
sourceLine="145"
summary="Tomorrow's date in UTC"
summaryComputed=""
usage="dateTomorrow [ --local ] [ --help ]"
