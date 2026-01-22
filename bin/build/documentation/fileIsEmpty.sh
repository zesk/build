#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="file - File. Optional. One or more files, all of which must be empty."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Is this an empty (zero-sized) file?"$'\n'"Return Code: 0 - if all files passed in are empty files"$'\n'"Return Code: 1 - if any files passed in are non-empty files"$'\n'""
file="bin/build/tools/file.sh"
fn="fileIsEmpty"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1769063211"
summary="Is this an empty (zero-sized) file?"
usage="fileIsEmpty [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileIsEmpty[0m [94m[ file ][0m [94m[ --help ][0m

    [94mfile    [1;97mFile. Optional. One or more files, all of which must be empty.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Is this an empty (zero-sized) file?
Return Code: 0 - if all files passed in are empty files
Return Code: 1 - if any files passed in are non-empty files

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileIsEmpty [ file ] [ --help ]

    file    File. Optional. One or more files, all of which must be empty.
    --help  Flag. Optional. Display this help.

Is this an empty (zero-sized) file?
Return Code: 0 - if all files passed in are empty files
Return Code: 1 - if any files passed in are non-empty files

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
