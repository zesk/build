#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--exclude path - String. Optional. Exclude paths which contain this string"$'\n'"--exec binary - Executable. Optional. For each failed file run this command."$'\n'"directory - Directory. Optional. Where to search for files to check."$'\n'"--list - Flag. Optional. List files which fail. (Default is simply to exit silently.)"$'\n'""
base="lint.sh"
description="Search bash files for assertions which do not terminate a function and are likely an error"$'\n'""
file="bin/build/tools/lint.sh"
fn="findUncaughtAssertions"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceModified="1768759461"
summary="Search bash files for assertions which do not terminate a"
usage="findUncaughtAssertions [ --help ] [ --handler handler ] [ --exclude path ] [ --exec binary ] [ directory ] [ --list ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfindUncaughtAssertions[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --exclude path ][0m [94m[ --exec binary ][0m [94m[ directory ][0m [94m[ --list ][0m

    [94m--help             [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler  [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--exclude path     [1;97mString. Optional. Exclude paths which contain this string[0m
    [94m--exec binary      [1;97mExecutable. Optional. For each failed file run this command.[0m
    [94mdirectory          [1;97mDirectory. Optional. Where to search for files to check.[0m
    [94m--list             [1;97mFlag. Optional. List files which fail. (Default is simply to exit silently.)[0m

Search bash files for assertions which do not terminate a function and are likely an error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: findUncaughtAssertions [ --help ] [ --handler handler ] [ --exclude path ] [ --exec binary ] [ directory ] [ --list ]

    --help             Flag. Optional. Display this help.
    --handler handler  Function. Optional. Use this error handler instead of the default error handler.
    --exclude path     String. Optional. Exclude paths which contain this string
    --exec binary      Executable. Optional. For each failed file run this command.
    directory          Directory. Optional. Where to search for files to check.
    --list             Flag. Optional. List files which fail. (Default is simply to exit silently.)

Search bash files for assertions which do not terminate a function and are likely an error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
