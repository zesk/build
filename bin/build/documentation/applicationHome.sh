#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/application.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"directory - Directory. Optional. Set the application home to this directory."$'\n'"--go - Flag. Optional. Change to the current saved application home directory."$'\n'""
base="application.sh"
description="Set, or cd to current application home directory."$'\n'""$'\n'""
file="bin/build/tools/application.sh"
fn="applicationHome"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/application.sh"
sourceModified="1768721469"
summary="Set, or cd to current application home directory."
usage="applicationHome [ --help ] [ directory ] [ --go ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mapplicationHome[0m [94m[ --help ][0m [94m[ directory ][0m [94m[ --go ][0m

    [94m--help     [1;97mFlag. Optional. Display this help.[0m
    [94mdirectory  [1;97mDirectory. Optional. Set the application home to this directory.[0m
    [94m--go       [1;97mFlag. Optional. Change to the current saved application home directory.[0m

Set, or cd to current application home directory.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: applicationHome [ --help ] [ directory ] [ --go ]

    --help     Flag. Optional. Display this help.
    directory  Directory. Optional. Set the application home to this directory.
    --go       Flag. Optional. Change to the current saved application home directory.

Set, or cd to current application home directory.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
