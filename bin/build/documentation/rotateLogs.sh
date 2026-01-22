#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/log.sh"
argument="--dry-run - Flag. Optional. Do not change anything."$'\n'"logPath - Required. Path where log files exist."$'\n'"count - Required. Integer of log files to maintain."$'\n'""
base="log.sh"
description="For all log files in logPath with extension \`.log\`, rotate them safely"$'\n'""
file="bin/build/tools/log.sh"
fn="rotateLogs"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/log.sh"
sourceModified="1768513812"
summary="Rotate log files"$'\n'""
usage="rotateLogs [ --dry-run ] logPath count"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mrotateLogs[0m [94m[ --dry-run ][0m [38;2;255;255;0m[35;48;2;0;0;0mlogPath[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mcount[0m[0m

    [94m--dry-run  [1;97mFlag. Optional. Do not change anything.[0m
    [31mlogPath    [1;97mRequired. Path where log files exist.[0m
    [31mcount      [1;97mRequired. Integer of log files to maintain.[0m

For all log files in logPath with extension [38;2;0;255;0;48;2;0;0;0m.log[0m, rotate them safely

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: rotateLogs [ --dry-run ] logPath count

    --dry-run  Flag. Optional. Do not change anything.
    logPath    Required. Path where log files exist.
    count      Required. Integer of log files to maintain.

For all log files in logPath with extension .log, rotate them safely

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
