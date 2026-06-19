#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--dry-run - Flag. Optional. Do not change anything.\n--cull cullCount - UnsignedInteger. Optional. Delete log file indexes which exist beyond the `count`. Default is `0`.\nlogPath - Directory. Required. Path where log files exist. Looks for files which match `*.log`.\ncount - PositiveInteger. Required. Integer of log files to maintain.\n'
base="log.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'For all log files in logPath with extension `.log`, rotate them safely.\n\n'
descriptionLineCount="2"
file="bin/build/tools/log.sh"
fn="logDirectoryRotate"
fnMarker="logdirectoryrotate"
foundNames=([0]="summary" [1]="see" [2]="argument")
line="108"
rawComment=$'Summary: Rotate log files\nFor all log files in logPath with extension `.log`, rotate them safely.\nSee: logRotate\nArgument: --help - Flag. Optional. Display this help.\nArgument: --dry-run - Flag. Optional. Do not change anything.\nArgument: --cull cullCount - UnsignedInteger. Optional. Delete log file indexes which exist beyond the `count`. Default is `0`.\nArgument: logPath - Directory. Required. Path where log files exist. Looks for files which match `*.log`.\nArgument: count - PositiveInteger. Required. Integer of log files to maintain.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'logRotate\n'
sourceFile="bin/build/tools/log.sh"
sourceHash="df34ff456c3d92e3ce92c7f61c3e01e6610d2c01"
sourceLine="108"
summary="Rotate log files"
summaryComputed=""
usage="logDirectoryRotate [ --help ] [ --dry-run ] [ --cull cullCount ] logPath count"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlogDirectoryRotate'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --dry-run ]'$'\e''[0m '$'\e''[[(blue)]m[ --cull cullCount ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlogPath'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcount'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help            '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--dry-run         '$'\e''[[(value)]mFlag. Optional. Do not change anything.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--cull cullCount  '$'\e''[[(value)]mUnsignedInteger. Optional. Delete log file indexes which exist beyond the '$'\e''[[(code)]mcount'$'\e''[[(reset)]m. Default is '$'\e''[[(code)]m0'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mlogPath           '$'\e''[[(value)]mDirectory. Required. Path where log files exist. Looks for files which match '$'\e''[[(code)]m'$'\e''[[(cyan)]m.log'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcount             '$'\e''[[(value)]mPositiveInteger. Required. Integer of log files to maintain.'$'\e''[[(reset)]m'$'\n'''$'\n''For all log files in logPath with extension '$'\e''[[(code)]m.log'$'\e''[[(reset)]m, rotate them safely.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: logDirectoryRotate [ --help ] [ --dry-run ] [ --cull cullCount ] logPath count'$'\n'''$'\n''    --help            Flag. Optional. Display this help.'$'\n''    --dry-run         Flag. Optional. Do not change anything.'$'\n''    --cull cullCount  UnsignedInteger. Optional. Delete log file indexes which exist beyond the count. Default is 0.'$'\n''    logPath           Directory. Required. Path where log files exist. Looks for files which match .log.'$'\n''    count             PositiveInteger. Required. Integer of log files to maintain.'$'\n'''$'\n''For all log files in logPath with extension .log, rotate them safely.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/log.md"
