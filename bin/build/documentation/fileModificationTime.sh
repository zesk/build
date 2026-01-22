#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="filename ... - File to fetch modification time"$'\n'""
base="file.sh"
description="Fetch the modification time of a file as a timestamp"$'\n'""$'\n'"Return Code: 2 - If file does not exist"$'\n'"Return Code: 0 - If file exists and modification times are output, one per line"$'\n'""
example="    fileModificationTime ~/.bash_profile"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModificationTime"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1769063211"
summary="Fetch the modification time of a file as a timestamp"
usage="fileModificationTime [ filename ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileModificationTime[0m [94m[ filename ... ][0m

    [94mfilename ...  [1;97mFile to fetch modification time[0m

Fetch the modification time of a file as a timestamp

Return Code: 2 - If file does not exist
Return Code: 0 - If file exists and modification times are output, one per line

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    fileModificationTime ~/.bash_profile
'
# shellcheck disable=SC2016
helpPlain='Usage: fileModificationTime [ filename ... ]

    filename ...  File to fetch modification time

Fetch the modification time of a file as a timestamp

Return Code: 2 - If file does not exist
Return Code: 0 - If file exists and modification times are output, one per line

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    fileModificationTime ~/.bash_profile
'
