#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/log.sh"
argument="--dry-run - Flag. Optional. Do not change anything."$'\n'"logFile - Required. A log file which exists."$'\n'"count - Required. Integer of log files to maintain."$'\n'""
base="log.sh"
description="Rotate a log file"$'\n'""$'\n'"Backs up files as:"$'\n'""$'\n'"    logFile"$'\n'"    logFile.1"$'\n'"    logFile.2"$'\n'"    logFile.3"$'\n'""$'\n'"But maintains file descriptors for \`logFile\`."$'\n'""
file="bin/build/tools/log.sh"
fn="rotateLog"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/log.sh"
sourceModified="1768513812"
summary="Rotate a log file"
usage="rotateLog [ --dry-run ] logFile count"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mrotateLog[0m [94m[ --dry-run ][0m [38;2;255;255;0m[35;48;2;0;0;0mlogFile[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mcount[0m[0m

    [94m--dry-run  [1;97mFlag. Optional. Do not change anything.[0m
    [31mlogFile    [1;97mRequired. A log file which exists.[0m
    [31mcount      [1;97mRequired. Integer of log files to maintain.[0m

Rotate a log file

Backs up files as:

    logFile
    logFile.1
    logFile.2
    logFile.3

But maintains file descriptors for [38;2;0;255;0;48;2;0;0;0mlogFile[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: rotateLog [ --dry-run ] logFile count

    --dry-run  Flag. Optional. Do not change anything.
    logFile    Required. A log file which exists.
    count      Required. Integer of log files to maintain.

Rotate a log file

Backs up files as:

    logFile
    logFile.1
    logFile.2
    logFile.3

But maintains file descriptors for logFile.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
