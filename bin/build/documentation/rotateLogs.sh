#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--dry-run - Flag. Optional. Do not change anything."$'\n'"logPath - Required. Path where log files exist."$'\n'"count - Required. Integer of log files to maintain."$'\n'""
base="log.sh"
description="For all log files in logPath with extension \`.log\`, rotate them safely"$'\n'""
file="bin/build/tools/log.sh"
foundNames=([0]="summary" [1]="argument")
rawComment="Summary: Rotate log files"$'\n'"For all log files in logPath with extension \`.log\`, rotate them safely"$'\n'"Argument: --dry-run - Flag. Optional. Do not change anything."$'\n'"Argument: logPath - Required. Path where log files exist."$'\n'"Argument: count - Required. Integer of log files to maintain."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/log.sh"
sourceHash="3606f540cf533f62d3096ca88ba8fc584e5ac93c"
summary="Rotate log files"$'\n'""
usage="rotateLogs [ --dry-run ] logPath count"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mrotateLogs'$'\e''[0m '$'\e''[[(blue)]m[ --dry-run ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlogPath'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcount'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--dry-run  '$'\e''[[(value)]mFlag. Optional. Do not change anything.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mlogPath    '$'\e''[[(value)]mRequired. Path where log files exist.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcount      '$'\e''[[(value)]mRequired. Integer of log files to maintain.'$'\e''[[(reset)]m'$'\n'''$'\n''For all log files in logPath with extension '$'\e''[[(code)]m.log'$'\e''[[(reset)]m, rotate them safely'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: rotateLogs [ --dry-run ] logPath count'$'\n'''$'\n''    --dry-run  Flag. Optional. Do not change anything.'$'\n''    logPath    Required. Path where log files exist.'$'\n''    count      Required. Integer of log files to maintain.'$'\n'''$'\n''For all log files in logPath with extension .log, rotate them safely'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 4.383
