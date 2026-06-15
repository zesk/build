#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument="command ... - Callable. Command to run"$'\n'"--temporary tempPath - Directory. Optional. Use this for the temporary path."$'\n'"--leak envName ... - EnvironmentVariable. Variable name which is OK to leak."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="debug.sh"
build_debug="plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'"plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run command and detect any global or local leaks"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/debug.sh"
fn="plumber"
fnMarker="plumber"
foundNames=([0]="requires" [1]="argument" [2]="build_debug" [3]="return_code")
line="320"
rawComment="Run command and detect any global or local leaks"$'\n'"Requires: declare diff grep"$'\n'"Requires: throwArgument decorate validate isCallable"$'\n'"Requires: fileTemporaryName textRemoveFields"$'\n'"Argument: command ... - Callable. Command to run"$'\n'"Argument: --temporary tempPath - Directory. Optional. Use this for the temporary path."$'\n'"Argument: --leak envName ... - EnvironmentVariable. Variable name which is OK to leak."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"BUILD_DEBUG: plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'"Return Code: 0 - No leaks detected in the command"$'\n'"Return Code: 108 - A leak was detected in the command"$'\n'"Return Code: 1 - Argument error, {fn} was called incorrectly."$'\n'"BUILD_DEBUG: plumber-verbose - The plumber outputs the exact variable captures before and after"$'\n'""$'\n'""
requires="declare diff grep"$'\n'"throwArgument decorate validate isCallable"$'\n'"fileTemporaryName textRemoveFields"$'\n'""
return_code="0 - No leaks detected in the command"$'\n'"108 - A leak was detected in the command"$'\n'"1 - Argument error, plumber was called incorrectly."$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="31fe892c1ce36e9aab313274a8fe87aa1c2ff9a6"
sourceLine="320"
summary="Run command and detect any global or local leaks"
summaryComputed="true"
usage="plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mplumber'$'\e''[0m '$'\e''[[(blue)]m[ command ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --temporary tempPath ]'$'\e''[0m '$'\e''[[(blue)]m[ --leak envName ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcommand ...           '$'\e''[[(value)]mCallable. Command to run'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--temporary tempPath  '$'\e''[[(value)]mDirectory. Optional. Use this for the temporary path.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--leak envName ...    '$'\e''[[(value)]mEnvironmentVariable. Variable name which is OK to leak.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose             '$'\e''[[(value)]mFlag. Optional. Be verbose.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Run command and detect any global or local leaks'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - No leaks detected in the command'$'\n''- '$'\e''[[(code)]m108'$'\e''[[(reset)]m - A leak was detected in the command'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Argument error, plumber was called incorrectly.'$'\n'''$'\n'''$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m settings:'$'\n''- '$'\e''[[(code)]mplumber-verbose'$'\e''[[(reset)]m - The plumber outputs the exact variable captures before and after'$'\n''- '$'\e''[[(code)]mplumber-verbose'$'\e''[[(reset)]m - The plumber outputs the exact variable captures before and after'
# shellcheck disable=SC2016
helpPlain='Usage: plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]'$'\n'''$'\n''    command ...           Callable. Command to run'$'\n''    --temporary tempPath  Directory. Optional. Use this for the temporary path.'$'\n''    --leak envName ...    EnvironmentVariable. Variable name which is OK to leak.'$'\n''    --verbose             Flag. Optional. Be verbose.'$'\n''    --help                Flag. Optional. Display this help.'$'\n'''$'\n''Run command and detect any global or local leaks'$'\n'''$'\n''Return codes:'$'\n''- 0 - No leaks detected in the command'$'\n''- 108 - A leak was detected in the command'$'\n''- 1 - Argument error, plumber was called incorrectly.'$'\n'''$'\n''BUILD_DEBUG settings:'$'\n''- plumber-verbose - The plumber outputs the exact variable captures before and after'$'\n''- plumber-verbose - The plumber outputs the exact variable captures before and after'
documentationPath="documentation/source/tools/debug.md"
