#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'date - String. Required. String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)\nformat - String. Optional. Format string for the `date` command (e.g. `%s`)\n'
base="date.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Converts a date (`YYYY-MM-DD`) to another format.\n\nCompatible with BSD and GNU date.\n\n'
descriptionLineCount="4"
example=$'    dateToFormat 2023-04-20 %s 1681948800\n    timestamp=$(dateToFormat \'2023-10-15\' %s)\n'
file="bin/build/tools/date.sh"
fn="dateToFormat"
fnMarker="datetoformat"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="return_code")
line="22"
rawComment=$'Converts a date (`YYYY-MM-DD`) to another format.\nSummary: Platform agnostic date conversion\nCompatible with BSD and GNU date.\nArgument: date - String. Required. String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)\nArgument: format - String. Optional. Format string for the `date` command (e.g. `%s`)\nExample:     dateToFormat 2023-04-20 %s 1681948800\nExample:     timestamp=$(dateToFormat \'2023-10-15\' %s)\nReturn Code: 1 - if parsing fails\nReturn Code: 0 - if parsing succeeds\n\n'
return_code=$'1 - if parsing fails\n0 - if parsing succeeds\n'
sourceFile="bin/build/tools/date.sh"
sourceHash="f805c1fba776a6a463c0d2a3bcdd87e48790701e"
sourceLine="22"
summary="Platform agnostic date conversion"
summaryComputed=""
timestamp=""
usage="dateToFormat date [ format ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateToFormat'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdate'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ format ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdate    '$'\e''[[(value)]mString. Required. String in the form '$'\e''[[(code)]mYYYY-MM-DD'$'\e''[[(reset)]m (e.g. '$'\e''[[(code)]m2023-10-15'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mformat  '$'\e''[[(value)]mString. Optional. Format string for the '$'\e''[[(code)]mdate'$'\e''[[(reset)]m command (e.g. '$'\e''[[(code)]m%s'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n'''$'\n''Converts a date ('$'\e''[[(code)]mYYYY-MM-DD'$'\e''[[(reset)]m) to another format.'$'\n'''$'\n''Compatible with BSD and GNU date.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if parsing fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if parsing succeeds'$'\n'''$'\n''Example:'$'\n''    dateToFormat 2023-04-20 %s 1681948800'$'\n''    timestamp=$(dateToFormat '\''2023-10-15'\'' %s)'
# shellcheck disable=SC2016
helpPlain='Usage: dateToFormat date [ format ]'$'\n'''$'\n''    date    String. Required. String in the form YYYY-MM-DD (e.g. 2023-10-15)'$'\n''    format  String. Optional. Format string for the date command (e.g. %s)'$'\n'''$'\n''Converts a date (YYYY-MM-DD) to another format.'$'\n'''$'\n''Compatible with BSD and GNU date.'$'\n'''$'\n''Return codes:'$'\n''- 1 - if parsing fails'$'\n''- 0 - if parsing succeeds'$'\n'''$'\n''Example:'$'\n''    dateToFormat 2023-04-20 %s 1681948800'$'\n''    timestamp=$(dateToFormat '\''2023-10-15'\'' %s)'
documentationPath="documentation/source/tools/date.md"
