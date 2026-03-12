#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="handler - Function. Required. Function to call on failure. Function Type: returnMessage"$'\n'"--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Optional. Any additional arguments are passed through."$'\n'""
base="file.sh"
build_debug="temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks"$'\n'""
description="Wrapper for \`mktemp\`. Generate a temporary file name, and fail using a function"$'\n'""
environment="BUILD_DEBUG"$'\n'""
file="bin/build/tools/file.sh"
fn="fileTemporaryName"
foundNames=([0]="argument" [1]="requires" [2]="build_debug" [3]="environment")
rawComment="Wrapper for \`mktemp\`. Generate a temporary file name, and fail using a function"$'\n'"Argument: handler - Function. Required. Function to call on failure. Function Type: returnMessage"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: ... - Arguments. Optional. Any additional arguments are passed through."$'\n'"Requires: mktemp __help catchEnvironment usageDocument"$'\n'"BUILD_DEBUG: temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks"$'\n'"Environment: BUILD_DEBUG"$'\n'""$'\n'""
requires="mktemp __help catchEnvironment usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="91d537b691b9a05e675b0b8e8fc9b5d80f144523"
summary="Wrapper for \`mktemp\`. Generate a temporary file name, and fail"
summaryComputed="true"
usage="fileTemporaryName handler [ --help ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileTemporaryName'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhandler  '$'\e''[[(value)]mFunction. Required. Function to call on failure. Function Type: returnMessage'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...      '$'\e''[[(value)]mArguments. Optional. Any additional arguments are passed through.'$'\e''[[(reset)]m'$'\n'''$'\n''Wrapper for '$'\e''[[(code)]mmktemp'$'\e''[[(reset)]m. Generate a temporary file name, and fail using a function'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG'$'\n'''$'\n'''$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m settings:'$'\n''- '$'\e''[[(code)]mtemp'$'\e''[[(reset)]m - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileTemporaryName handler [ --help ] [ ... ]'$'\n'''$'\n''    handler  Function. Required. Function to call on failure. Function Type: returnMessage'$'\n''    --help   Flag. Optional. Display this help.'$'\n''    ...      Arguments. Optional. Any additional arguments are passed through.'$'\n'''$'\n''Wrapper for mktemp. Generate a temporary file name, and fail using a function'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG'$'\n'''$'\n''BUILD_DEBUG settings:'$'\n''- temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks'$'\n'''
