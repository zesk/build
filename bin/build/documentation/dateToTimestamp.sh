#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="date - String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="date.sh"
description="Converts a date to an integer timestamp"$'\n'""
environment="Compatible with BSD and GNU date."$'\n'""
example="    timestamp=\$(dateToTimestamp '2023-10-15')"$'\n'""
file="bin/build/tools/date.sh"
foundNames=([0]="argument" [1]="environment" [2]="return_code" [3]="example")
rawComment="Converts a date to an integer timestamp"$'\n'"Argument: date - String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: Compatible with BSD and GNU date."$'\n'"Return Code: 1 - if parsing fails"$'\n'"Return Code: 0 - if parsing succeeds"$'\n'"Example:     timestamp=\$(dateToTimestamp '2023-10-15')"$'\n'""$'\n'""
return_code="1 - if parsing fails"$'\n'"0 - if parsing succeeds"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
summary="Converts a date to an integer timestamp"
summaryComputed="true"
timestamp=""
usage="dateToTimestamp [ date ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateToTimestamp'$'\e''[0m '$'\e''[[(blue)]m[ date ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mdate    '$'\e''[[(value)]mString in the form '$'\e''[[(code)]mYYYY-MM-DD'$'\e''[[(reset)]m (e.g. '$'\e''[[(code)]m2023-10-15'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Converts a date to an integer timestamp'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if parsing fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if parsing succeeds'$'\n'''$'\n''Environment variables:'$'\n''- Compatible with BSD and GNU date.'$'\n'''$'\n''Example:'$'\n''    timestamp=$(dateToTimestamp '\''2023-10-15'\'')'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mdateToTimestamp [ date ] [ --help ]'$'\n'''$'\n''    date    [[(value)]mString in the form [[(code)]mYYYY-MM-DD (e.g. [[(code)]m2023-10-15)'$'\n''    --help  [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Converts a date to an integer timestamp'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m1 - if parsing fails'$'\n''- [[(code)]m0 - if parsing succeeds'$'\n'''$'\n''Environment variables:'$'\n''- Compatible with BSD and GNU date.'$'\n'''$'\n''Example:'$'\n''    timestamp=$(dateToTimestamp '\''2023-10-15'\'')'$'\n'''
# elapsed 3.558
