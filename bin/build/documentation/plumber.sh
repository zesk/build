#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
description="Run command and detect any global or local leaks"$'\n'"Requires: declare diff grep"$'\n'"Requires: throwArgument decorate usageArgumentString isCallable"$'\n'"Requires: fileTemporaryName removeFields"$'\n'"Argument: command ... - Callable. Command to run"$'\n'"Argument: --temporary tempPath - Directory. Optional. Use this for the temporary path."$'\n'"Argument: --leak envName ... - EnvironmentVariable. Variable name which is OK to leak."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"BUILD_DEBUG: plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=()
rawComment="Run command and detect any global or local leaks"$'\n'"Requires: declare diff grep"$'\n'"Requires: throwArgument decorate usageArgumentString isCallable"$'\n'"Requires: fileTemporaryName removeFields"$'\n'"Argument: command ... - Callable. Command to run"$'\n'"Argument: --temporary tempPath - Directory. Optional. Use this for the temporary path."$'\n'"Argument: --leak envName ... - EnvironmentVariable. Variable name which is OK to leak."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"BUILD_DEBUG: plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="3e4ac7234593313eddb63a76e2aa170841269b82"
summary="Run command and detect any global or local leaks"
usage="plumber"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mplumber'$'\e''[0m'$'\n'''$'\n''Run command and detect any global or local leaks'$'\n''Requires: declare diff grep'$'\n''Requires: throwArgument decorate usageArgumentString isCallable'$'\n''Requires: fileTemporaryName removeFields'$'\n''Argument: command ... - Callable. Command to run'$'\n''Argument: --temporary tempPath - Directory. Optional. Use this for the temporary path.'$'\n''Argument: --leak envName ... - EnvironmentVariable. Variable name which is OK to leak.'$'\n''Argument: --verbose - Flag. Optional. Be verbose.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''BUILD_DEBUG: plumber-verbose - The plumber outputs the exact variable captures before and after'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: plumber'$'\n'''$'\n''Run command and detect any global or local leaks'$'\n''Requires: declare diff grep'$'\n''Requires: throwArgument decorate usageArgumentString isCallable'$'\n''Requires: fileTemporaryName removeFields'$'\n''Argument: command ... - Callable. Command to run'$'\n''Argument: --temporary tempPath - Directory. Optional. Use this for the temporary path.'$'\n''Argument: --leak envName ... - EnvironmentVariable. Variable name which is OK to leak.'$'\n''Argument: --verbose - Flag. Optional. Be verbose.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''BUILD_DEBUG: plumber-verbose - The plumber outputs the exact variable captures before and after'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.476
