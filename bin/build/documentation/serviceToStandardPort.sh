#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"service ... - String. Optional. A unix service typically found in \`/etc/services\`"$'\n'""
base="platform.sh"
description="Hard-coded services for:"$'\n'"- \`ssh\` -> 22"$'\n'"- \`http\`-> 80"$'\n'"- \`https\`-> 80"$'\n'"- \`postgres\`-> 5432"$'\n'"- \`mariadb\`-> 3306"$'\n'"- \`mysql\`-> 3306"$'\n'"Backup when \`/etc/services\` does not exist."$'\n'""
file="bin/build/tools/platform.sh"
foundNames=([0]="argument" [1]="output" [2]="return_code" [3]="see")
output="Port number of associated service (integer) one per line"$'\n'""
rawComment="Hard-coded services for:"$'\n'"- \`ssh\` -> 22"$'\n'"- \`http\`-> 80"$'\n'"- \`https\`-> 80"$'\n'"- \`postgres\`-> 5432"$'\n'"- \`mariadb\`-> 3306"$'\n'"- \`mysql\`-> 3306"$'\n'"Backup when \`/etc/services\` does not exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: service ... - String. Optional. A unix service typically found in \`/etc/services\`"$'\n'"Output: Port number of associated service (integer) one per line"$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'"See: serviceToPort"$'\n'""$'\n'""
return_code="1 - service not found"$'\n'"0 - service found and output is an integer"$'\n'""
see="serviceToPort"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="a1e5b60c969c8edace1146de6c1a3e07b2d6a084"
summary="Hard-coded services for:"
summaryComputed="true"
usage="serviceToStandardPort [ --help ] [ service ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mserviceToStandardPort'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ service ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mservice ...  '$'\e''[[(value)]mString. Optional. A unix service typically found in '$'\e''[[(code)]m/etc/services'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Hard-coded services for:'$'\n''- '$'\e''[[(code)]mssh'$'\e''[[(reset)]m -> 22'$'\n''- '$'\e''[[(code)]mhttp'$'\e''[[(reset)]m-> 80'$'\n''- '$'\e''[[(code)]mhttps'$'\e''[[(reset)]m-> 80'$'\n''- '$'\e''[[(code)]mpostgres'$'\e''[[(reset)]m-> 5432'$'\n''- '$'\e''[[(code)]mmariadb'$'\e''[[(reset)]m-> 3306'$'\n''- '$'\e''[[(code)]mmysql'$'\e''[[(reset)]m-> 3306'$'\n''Backup when '$'\e''[[(code)]m/etc/services'$'\e''[[(reset)]m does not exist.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - service not found'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - service found and output is an integer'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: serviceToStandardPort [[(blue)]m[ --help ] [[(blue)]m[ service ... ]'$'\n'''$'\n''    [[(blue)]m--help       Flag. Optional. Display this help.'$'\n''    [[(blue)]mservice ...  String. Optional. A unix service typically found in /etc/services'$'\n'''$'\n''Hard-coded services for:'$'\n''- ssh -> 22'$'\n''- http-> 80'$'\n''- https-> 80'$'\n''- postgres-> 5432'$'\n''- mariadb-> 3306'$'\n''- mysql-> 3306'$'\n''Backup when /etc/services does not exist.'$'\n'''$'\n''Return codes:'$'\n''- 1 - service not found'$'\n''- 0 - service found and output is an integer'$'\n'''
