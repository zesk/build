#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="file - File to get the owner for"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
description="Get the file owner name"$'\n'"Outputs the file owner for each file passed on the command line"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Unable to access file"$'\n'""
file="bin/build/tools/file.sh"
fn="fileOwner"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1768775696"
summary="Get the file owner name"
usage="fileOwner [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileOwner[0m [94m[ file ][0m [94m[ --help ][0m

    [94mfile    [1;97mFile to get the owner for[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Get the file owner name
Outputs the file owner for each file passed on the command line
Return Code: 0 - Success
Return Code: 1 - Unable to access file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileOwner [ file ] [ --help ]

    file    File to get the owner for
    --help  Flag. Optional. Display this help.

Get the file owner name
Outputs the file owner for each file passed on the command line
Return Code: 0 - Success
Return Code: 1 - Unable to access file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
