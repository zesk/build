#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--dry-run - Flag. Optional. Do not change anything."$'\n'"logFile - Required. A log file which exists."$'\n'"count - Required. Integer of log files to maintain."$'\n'""
base="log.sh"
description="Rotate a log file"$'\n'"Backs up files as:"$'\n'"    logFile"$'\n'"    logFile.1"$'\n'"    logFile.2"$'\n'"    logFile.3"$'\n'"But maintains file descriptors for \`logFile\`."$'\n'""
file="bin/build/tools/log.sh"
fn="logRotate"
foundNames=([0]="argument")
rawComment="Argument: --dry-run - Flag. Optional. Do not change anything."$'\n'"Argument: logFile - Required. A log file which exists."$'\n'"Argument: count - Required. Integer of log files to maintain."$'\n'"Rotate a log file"$'\n'"Backs up files as:"$'\n'"    logFile"$'\n'"    logFile.1"$'\n'"    logFile.2"$'\n'"    logFile.3"$'\n'"But maintains file descriptors for \`logFile\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/log.sh"
sourceHash="16ac355e760e19b7d727d407d116b070e44e4ac3"
summary="Rotate a log file"
summaryComputed="true"
usage="logRotate [ --dry-run ] logFile count"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlogRotate'$'\e''[0m '$'\e''[[(blue)]m[ --dry-run ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlogFile'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcount'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--dry-run  '$'\e''[[(value)]mFlag. Optional. Do not change anything.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mlogFile    '$'\e''[[(value)]mRequired. A log file which exists.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcount      '$'\e''[[(value)]mRequired. Integer of log files to maintain.'$'\e''[[(reset)]m'$'\n'''$'\n''Rotate a log file'$'\n''Backs up files as:'$'\n''    logFile'$'\n''    logFile.1'$'\n''    logFile.2'$'\n''    logFile.3'$'\n''But maintains file descriptors for '$'\e''[[(code)]mlogFile'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: logRotate [ --dry-run ] logFile count'$'\n'''$'\n''    --dry-run  Flag. Optional. Do not change anything.'$'\n''    logFile    Required. A log file which exists.'$'\n''    count      Required. Integer of log files to maintain.'$'\n'''$'\n''Rotate a log file'$'\n''Backs up files as:'$'\n''    logFile'$'\n''    logFile.1'$'\n''    logFile.2'$'\n''    logFile.3'$'\n''But maintains file descriptors for logFile.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
