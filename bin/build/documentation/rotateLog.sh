#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="log.sh"
description="Argument: --dry-run - Flag. Optional. Do not change anything."$'\n'"Argument: logFile - Required. A log file which exists."$'\n'"Argument: count - Required. Integer of log files to maintain."$'\n'"Rotate a log file"$'\n'"Backs up files as:"$'\n'"    logFile"$'\n'"    logFile.1"$'\n'"    logFile.2"$'\n'"    logFile.3"$'\n'"But maintains file descriptors for \`logFile\`."$'\n'""
file="bin/build/tools/log.sh"
foundNames=()
rawComment="Argument: --dry-run - Flag. Optional. Do not change anything."$'\n'"Argument: logFile - Required. A log file which exists."$'\n'"Argument: count - Required. Integer of log files to maintain."$'\n'"Rotate a log file"$'\n'"Backs up files as:"$'\n'"    logFile"$'\n'"    logFile.1"$'\n'"    logFile.2"$'\n'"    logFile.3"$'\n'"But maintains file descriptors for \`logFile\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/log.sh"
sourceHash="3606f540cf533f62d3096ca88ba8fc584e5ac93c"
summary="Argument: --dry-run - Flag. Optional. Do not change anything."
usage="rotateLog"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mrotateLog'$'\e''[0m'$'\n'''$'\n''Argument: --dry-run - Flag. Optional. Do not change anything.'$'\n''Argument: logFile - Required. A log file which exists.'$'\n''Argument: count - Required. Integer of log files to maintain.'$'\n''Rotate a log file'$'\n''Backs up files as:'$'\n''    logFile'$'\n''    logFile.1'$'\n''    logFile.2'$'\n''    logFile.3'$'\n''But maintains file descriptors for '$'\e''[[(code)]mlogFile'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: rotateLog'$'\n'''$'\n''Argument: --dry-run - Flag. Optional. Do not change anything.'$'\n''Argument: logFile - Required. A log file which exists.'$'\n''Argument: count - Required. Integer of log files to maintain.'$'\n''Rotate a log file'$'\n''Backs up files as:'$'\n''    logFile'$'\n''    logFile.1'$'\n''    logFile.2'$'\n''    logFile.3'$'\n''But maintains file descriptors for logFile.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.516
