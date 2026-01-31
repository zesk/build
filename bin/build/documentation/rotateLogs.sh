#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="log.sh"
description="Summary: Rotate log files"$'\n'"For all log files in logPath with extension \`.log\`, rotate them safely"$'\n'"Argument: --dry-run - Flag. Optional. Do not change anything."$'\n'"Argument: logPath - Required. Path where log files exist."$'\n'"Argument: count - Required. Integer of log files to maintain."$'\n'""
file="bin/build/tools/log.sh"
foundNames=()
rawComment="Summary: Rotate log files"$'\n'"For all log files in logPath with extension \`.log\`, rotate them safely"$'\n'"Argument: --dry-run - Flag. Optional. Do not change anything."$'\n'"Argument: logPath - Required. Path where log files exist."$'\n'"Argument: count - Required. Integer of log files to maintain."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/log.sh"
sourceHash="3606f540cf533f62d3096ca88ba8fc584e5ac93c"
summary="Summary: Rotate log files"
usage="rotateLogs"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mrotateLogs'$'\e''[0m'$'\n'''$'\n''Summary: Rotate log files'$'\n''For all log files in logPath with extension '$'\e''[[(code)]m.log'$'\e''[[(reset)]m, rotate them safely'$'\n''Argument: --dry-run - Flag. Optional. Do not change anything.'$'\n''Argument: logPath - Required. Path where log files exist.'$'\n''Argument: count - Required. Integer of log files to maintain.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: rotateLogs'$'\n'''$'\n''Summary: Rotate log files'$'\n''For all log files in logPath with extension .log, rotate them safely'$'\n''Argument: --dry-run - Flag. Optional. Do not change anything.'$'\n''Argument: logPath - Required. Path where log files exist.'$'\n''Argument: count - Required. Integer of log files to maintain.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.513
