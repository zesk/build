#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="file ... - File. Required. One or more files to examine"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Prints days (integer) since modified"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Can not get modification time"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModifiedDays"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1769063211"
summary="Prints days (integer) since modified"
usage="fileModifiedDays file ... [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileModifiedDays[0m [38;2;255;255;0m[35;48;2;0;0;0mfile ...[0m[0m [94m[ --help ][0m

    [31mfile ...  [1;97mFile. Required. One or more files to examine[0m
    [94m--help    [1;97mFlag. Optional. Display this help.[0m

Prints days (integer) since modified
Return Code: 0 - Success
Return Code: 2 - Can not get modification time

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileModifiedDays file ... [ --help ]

    file ...  File. Required. One or more files to examine
    --help    Flag. Optional. Display this help.

Prints days (integer) since modified
Return Code: 0 - Success
Return Code: 2 - Can not get modification time

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
