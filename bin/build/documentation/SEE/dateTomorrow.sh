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
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateTomorrow'$'\e''[0m '$'\e''[[(blue)]m[ --local ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--local  '$'\e''[[(value)]mFlag. Optional. Local tomorrow'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Returns tomorrow'\''s date (UTC time), in '$'\e''[[(code)]mYYYY-MM-DD'$'\e''[[(reset)]m format. (same as '$'\e''[[(code)]m%F'$'\e''[[(reset)]m)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    rotated="$log.$(dateTomorrow)"'
# shellcheck disable=SC2016
helpPlain='Usage: dateTomorrow [ --local ] [ --help ]'$'\n'''$'\n''    --local  Flag. Optional. Local tomorrow'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Returns tomorrow'\''s date (UTC time), in YYYY-MM-DD format. (same as %F)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    rotated="$log.$(dateTomorrow)"'
documentationPath="documentation/source/tools/date.md"
