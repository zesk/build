#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/date.sh"
argument="date - String. Required. String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"format - String. Optional. Format string for the \`date\` command (e.g. \`%s\`)"$'\n'""
base="date.sh"
description="Converts a date (\`YYYY-MM-DD\`) to another format."$'\n'"Compatible with BSD and GNU date."$'\n'""
example="    dateToFormat 2023-04-20 %s 1681948800"$'\n'"    timestamp=\$(dateToFormat '2023-10-15' %s)"$'\n'""
file="bin/build/tools/date.sh"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="return_code")
rawComment="Converts a date (\`YYYY-MM-DD\`) to another format."$'\n'"Summary: Platform agnostic date conversion"$'\n'"Compatible with BSD and GNU date."$'\n'"Argument: date - String. Required. String in the form \`YYYY-MM-DD\` (e.g. \`2023-10-15\`)"$'\n'"Argument: format - String. Optional. Format string for the \`date\` command (e.g. \`%s\`)"$'\n'"Example:     dateToFormat 2023-04-20 %s 1681948800"$'\n'"Example:     timestamp=\$(dateToFormat '2023-10-15' %s)"$'\n'"Return Code: 1 - if parsing fails"$'\n'"Return Code: 0 - if parsing succeeds"$'\n'""$'\n'""
return_code="1 - if parsing fails"$'\n'"0 - if parsing succeeds"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceModified="1769184556"
summary="Platform agnostic date conversion"$'\n'""
timestamp=""
usage="dateToFormat date [ format ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateToFormat'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdate'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ format ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdate    '$'\e''[[(value)]mString. Required. String in the form '$'\e''[[(code)]mYYYY-MM-DD'$'\e''[[(reset)]m (e.g. '$'\e''[[(code)]m2023-10-15'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mformat  '$'\e''[[(value)]mString. Optional. Format string for the '$'\e''[[(code)]mdate'$'\e''[[(reset)]m command (e.g. '$'\e''[[(code)]m%s'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n'''$'\n''Converts a date ('$'\e''[[(code)]mYYYY-MM-DD'$'\e''[[(reset)]m) to another format.'$'\n''Compatible with BSD and GNU date.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if parsing fails'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if parsing succeeds'$'\n'''$'\n''Example:'$'\n''    dateToFormat 2023-04-20 %s 1681948800'$'\n''    timestamp=$(dateToFormat '\''2023-10-15'\'' %s)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dateToFormat date [ format ]'$'\n'''$'\n''    date    String. Required. String in the form YYYY-MM-DD (e.g. 2023-10-15)'$'\n''    format  String. Optional. Format string for the date command (e.g. %s)'$'\n'''$'\n''Converts a date (YYYY-MM-DD) to another format.'$'\n''Compatible with BSD and GNU date.'$'\n'''$'\n''Return codes:'$'\n''- 1 - if parsing fails'$'\n''- 0 - if parsing succeeds'$'\n'''$'\n''Example:'$'\n''    dateToFormat 2023-04-20 %s 1681948800'$'\n''    timestamp=$(dateToFormat '\''2023-10-15'\'' %s)'$'\n'''
# elapsed 0.615
