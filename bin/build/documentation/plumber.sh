#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="command ... - Callable. Command to run"$'\n'"--temporary tempPath - Directory. Optional. Use this for the temporary path."$'\n'"--leak envName ... - EnvironmentVariable. Variable name which is OK to leak."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="debug.sh"
build_debug="plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'""
description="Run command and detect any global or local leaks"$'\n'""
file="bin/build/tools/debug.sh"
fn="plumber"
foundNames=""
requires="declare diff grep"$'\n'"throwArgument decorate usageArgumentString isCallable"$'\n'"fileTemporaryName removeFields"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769063211"
summary="Run command and detect any global or local leaks"
usage="plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mplumber[0m [94m[ command ... ][0m [94m[ --temporary tempPath ][0m [94m[ --leak envName ... ][0m [94m[ --verbose ][0m [94m[ --help ][0m

    [94mcommand ...           [1;97mCallable. Command to run[0m
    [94m--temporary tempPath  [1;97mDirectory. Optional. Use this for the temporary path.[0m
    [94m--leak envName ...    [1;97mEnvironmentVariable. Variable name which is OK to leak.[0m
    [94m--verbose             [1;97mFlag. Optional. Be verbose.[0m
    [94m--help                [1;97mFlag. Optional. Display this help.[0m

Run command and detect any global or local leaks

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- plumber-verbose - The plumber outputs the exact variable captures before and after
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]

    command ...           Callable. Command to run
    --temporary tempPath  Directory. Optional. Use this for the temporary path.
    --leak envName ...    EnvironmentVariable. Variable name which is OK to leak.
    --verbose             Flag. Optional. Be verbose.
    --help                Flag. Optional. Display this help.

Run command and detect any global or local leaks

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

BUILD_DEBUG settings:
- plumber-verbose - The plumber outputs the exact variable captures before and after
- 
'
