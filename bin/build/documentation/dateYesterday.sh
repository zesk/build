#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--local - Flag. Optional. Local yesterday\n--help - Flag. Optional. Display this help.\n'
base="date.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Returns yesterday\'s date, in `YYYY-MM-DD` format. (same as `%F`)\n\n'
descriptionLineCount="2"
example=$'    rotated="$log.$(dateYesterday --local)"\n'
file="bin/build/tools/date.sh"
fn="dateYesterday"
fnMarker="dateyesterday"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
line="119"
original="dateYesterday"
rawComment=$'Returns yesterday\'s date, in `YYYY-MM-DD` format. (same as `%F`)\nSummary: Yesterday\'s date (UTC time)\nArgument: --local - Flag. Optional. Local yesterday\nArgument: --help - Flag. Optional. Display this help.\nExample:     rotated="$log.$({fn} --local)"\nRequires: throwArgument date convertValue dateFromTimestamp bashDocumentation\n\n'
requires=$'throwArgument date convertValue dateFromTimestamp bashDocumentation\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
rotated=""
sourceFile="bin/build/tools/date.sh"
sourceHash="f805c1fba776a6a463c0d2a3bcdd87e48790701e"
sourceLine="119"
summary="Yesterday's date (UTC time)"
summaryComputed=""
usage="dateYesterday [ --local ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateYesterday'$'\e''[0m '$'\e''[[(blue)]m[ --local ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--local  '$'\e''[[(value)]mFlag. Optional. Local yesterday'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Returns yesterday'\''s date, in '$'\e''[[(code)]mYYYY-MM-DD'$'\e''[[(reset)]m format. (same as '$'\e''[[(code)]m%F'$'\e''[[(reset)]m)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    rotated="$log.$(dateYesterday --local)"'
# shellcheck disable=SC2016
helpPlain='Usage: dateYesterday [ --local ] [ --help ]'$'\n'''$'\n''    --local  Flag. Optional. Local yesterday'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Returns yesterday'\''s date, in YYYY-MM-DD format. (same as %F)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    rotated="$log.$(dateYesterday --local)"'
documentationPath="documentation/source/tools/date.md"
