#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="--ignore grepPattern - String. Directory. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"--path path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"callable - Callable. Optional. Program to run and watch directory before and after."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="debug.sh"
description="Run a command and ensure files are not modified"$'\n'""
file="bin/build/tools/debug.sh"
fn="housekeeper"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769063211"
summary="Run a command and ensure files are not modified"
usage="housekeeper [ --ignore grepPattern ] [ --path path ] [ path ] [ callable ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mhousekeeper[0m [94m[ --ignore grepPattern ][0m [94m[ --path path ][0m [94m[ path ][0m [94m[ callable ][0m [94m[ --help ][0m

    [94m--ignore grepPattern  [1;97mString. Directory. One or more directories to watch. If no directories are supplied uses current working directory.[0m
    [94m--path path           [1;97mDirectory. Optional. One or more directories to watch. If no directories are supplied uses current working directory.[0m
    [94mpath                  [1;97mDirectory. Optional. One or more directories to watch. If no directories are supplied uses current working directory.[0m
    [94mcallable              [1;97mCallable. Optional. Program to run and watch directory before and after.[0m
    [94m--help                [1;97mFlag. Optional. Display this help.[0m

Run a command and ensure files are not modified

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: housekeeper [ --ignore grepPattern ] [ --path path ] [ path ] [ callable ] [ --help ]

    --ignore grepPattern  String. Directory. One or more directories to watch. If no directories are supplied uses current working directory.
    --path path           Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory.
    path                  Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory.
    callable              Callable. Optional. Program to run and watch directory before and after.
    --help                Flag. Optional. Display this help.

Run a command and ensure files are not modified

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
