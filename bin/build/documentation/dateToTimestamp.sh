#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="date - String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Converts a date to an integer timestamp"$'\n'""$'\n'""
descriptionLineCount="2"
environment="Compatible with BSD and GNU date."$'\n'""
example="    timestamp=\$(dateToTimestamp '2023-10-15')"$'\n'""
file="bin/build/tools/date.sh"
fn="dateToTimestamp"
fnMarker="datetotimestamp"
foundNames=([0]="argument" [1]="environment" [2]="return_code" [3]="example")
line="51"
rawComment="Converts a date to an integer timestamp"$'\n'"Argument: date - String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: Compatible with BSD and GNU date."$'\n'"Return Code: 1 - if parsing fails"$'\n'"Return Code: 0 - if parsing succeeds"$'\n'"Example:     timestamp=\$(dateToTimestamp '2023-10-15')"$'\n'""$'\n'""
return_code="1 - if parsing fails"$'\n'"0 - if parsing succeeds"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="8b6a5808143207c1b2329179a4d73d95ea46d8cc"
sourceLine="51"
summary="Converts a date to an integer timestamp"
summaryComputed="true"
timestamp=""
usage="dateToTimestamp [ date ] [ --help ]"
