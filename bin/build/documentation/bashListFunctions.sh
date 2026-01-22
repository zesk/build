#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"file - File. Optional. File(s) to list bash functions defined within."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="List functions in a given shell file"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashListFunctions"
foundNames=""
requires="__bashListFunctions throwArgument decorate usageArgumentFile"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1768776883"
summary="List functions in a given shell file"
usage="bashListFunctions [ --help ] [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashListFunctions[0m [94m[ --help ][0m [94m[ file ][0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94mfile    [1;97mFile. Optional. File(s) to list bash functions defined within.[0m
    [94m--help  [1;97mFlag. Optional. Display this help.[0m

List functions in a given shell file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashListFunctions [ --help ] [ file ] [ --help ]

    --help  Flag. Optional. Display this help.
    file    File. Optional. File(s) to list bash functions defined within.
    --help  Flag. Optional. Display this help.

List functions in a given shell file

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
