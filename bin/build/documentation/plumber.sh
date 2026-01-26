#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="command ... - Callable. Command to run"$'\n'"--temporary tempPath - Directory. Optional. Use this for the temporary path."$'\n'"--leak envName ... - EnvironmentVariable. Variable name which is OK to leak."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="debug.sh"
build_debug="plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'""
description="Run command and detect any global or local leaks"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="requires" [1]="argument" [2]="build_debug")
rawComment="Run command and detect any global or local leaks"$'\n'"Requires: declare diff grep"$'\n'"Requires: throwArgument decorate usageArgumentString isCallable"$'\n'"Requires: fileTemporaryName removeFields"$'\n'"Argument: command ... - Callable. Command to run"$'\n'"Argument: --temporary tempPath - Directory. Optional. Use this for the temporary path."$'\n'"Argument: --leak envName ... - EnvironmentVariable. Variable name which is OK to leak."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"BUILD_DEBUG: plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'""$'\n'""
requires="declare diff grep"$'\n'"throwArgument decorate usageArgumentString isCallable"$'\n'"fileTemporaryName removeFields"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769208503"
summary="Run command and detect any global or local leaks"
usage="plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mplumber'$'\e''[0m '$'\e''[[(blue)]m[ command ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --temporary tempPath ]'$'\e''[0m '$'\e''[[(blue)]m[ --leak envName ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcommand ...           '$'\e''[[(value)]mCallable. Command to run'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--temporary tempPath  '$'\e''[[(value)]mDirectory. Optional. Use this for the temporary path.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--leak envName ...    '$'\e''[[(value)]mEnvironmentVariable. Variable name which is OK to leak.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose             '$'\e''[[(value)]mFlag. Optional. Be verbose.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Run command and detect any global or local leaks'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n'''$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m settings:'$'\n''- '$'\e''[[(code)]mplumber-verbose'$'\e''[[(reset)]m - The plumber outputs the exact variable captures before and after'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]'$'\n'''$'\n''    command ...           Callable. Command to run'$'\n''    --temporary tempPath  Directory. Optional. Use this for the temporary path.'$'\n''    --leak envName ...    EnvironmentVariable. Variable name which is OK to leak.'$'\n''    --verbose             Flag. Optional. Be verbose.'$'\n''    --help                Flag. Optional. Display this help.'$'\n'''$'\n''Run command and detect any global or local leaks'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''BUILD_DEBUG settings:'$'\n''- plumber-verbose - The plumber outputs the exact variable captures before and after'$'\n'''
# elapsed 0.908
