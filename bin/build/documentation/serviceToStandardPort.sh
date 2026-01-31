#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="platform.sh"
description="Hard-coded services for:"$'\n'"- \`ssh\` -> 22"$'\n'"- \`http\`-> 80"$'\n'"- \`https\`-> 80"$'\n'"- \`postgres\`-> 5432"$'\n'"- \`mariadb\`-> 3306"$'\n'"- \`mysql\`-> 3306"$'\n'"Backup when \`/etc/services\` does not exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: service ... - String. Optional. A unix service typically found in \`/etc/services\`"$'\n'"Output: Port number of associated service (integer) one per line"$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'"See: serviceToPort"$'\n'""
file="bin/build/tools/platform.sh"
foundNames=()
rawComment="Hard-coded services for:"$'\n'"- \`ssh\` -> 22"$'\n'"- \`http\`-> 80"$'\n'"- \`https\`-> 80"$'\n'"- \`postgres\`-> 5432"$'\n'"- \`mariadb\`-> 3306"$'\n'"- \`mysql\`-> 3306"$'\n'"Backup when \`/etc/services\` does not exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: service ... - String. Optional. A unix service typically found in \`/etc/services\`"$'\n'"Output: Port number of associated service (integer) one per line"$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'"See: serviceToPort"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="a1e5b60c969c8edace1146de6c1a3e07b2d6a084"
summary="Hard-coded services for:"
usage="serviceToStandardPort"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mserviceToStandardPort'$'\e''[0m'$'\n'''$'\n''Hard-coded services for:'$'\n''- '$'\e''[[(code)]mssh'$'\e''[[(reset)]m -> 22'$'\n''- '$'\e''[[(code)]mhttp'$'\e''[[(reset)]m-> 80'$'\n''- '$'\e''[[(code)]mhttps'$'\e''[[(reset)]m-> 80'$'\n''- '$'\e''[[(code)]mpostgres'$'\e''[[(reset)]m-> 5432'$'\n''- '$'\e''[[(code)]mmariadb'$'\e''[[(reset)]m-> 3306'$'\n''- '$'\e''[[(code)]mmysql'$'\e''[[(reset)]m-> 3306'$'\n''Backup when '$'\e''[[(code)]m/etc/services'$'\e''[[(reset)]m does not exist.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: service ... - String. Optional. A unix service typically found in '$'\e''[[(code)]m/etc/services'$'\e''[[(reset)]m'$'\n''Output: Port number of associated service (integer) one per line'$'\n''Return Code: 1 - service not found'$'\n''Return Code: 0 - service found and output is an integer'$'\n''See: serviceToPort'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: serviceToStandardPort'$'\n'''$'\n''Hard-coded services for:'$'\n''- ssh -> 22'$'\n''- http-> 80'$'\n''- https-> 80'$'\n''- postgres-> 5432'$'\n''- mariadb-> 3306'$'\n''- mysql-> 3306'$'\n''Backup when /etc/services does not exist.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: service ... - String. Optional. A unix service typically found in /etc/services'$'\n''Output: Port number of associated service (integer) one per line'$'\n''Return Code: 1 - service not found'$'\n''Return Code: 0 - service found and output is an integer'$'\n''See: serviceToPort'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.464
