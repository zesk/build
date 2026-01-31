#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Wrapper for \`mktemp\`. Generate a temporary file name, and fail using a function"$'\n'"Argument: handler - Function. Required. Function to call on failure. Function Type: returnMessage"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: ... - Arguments. Optional. Any additional arguments are passed through."$'\n'"Requires: mktemp __help catchEnvironment usageDocument"$'\n'"BUILD_DEBUG: temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks"$'\n'"Environment: BUILD_DEBUG"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Wrapper for \`mktemp\`. Generate a temporary file name, and fail using a function"$'\n'"Argument: handler - Function. Required. Function to call on failure. Function Type: returnMessage"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: ... - Arguments. Optional. Any additional arguments are passed through."$'\n'"Requires: mktemp __help catchEnvironment usageDocument"$'\n'"BUILD_DEBUG: temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks"$'\n'"Environment: BUILD_DEBUG"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Wrapper for \`mktemp\`. Generate a temporary file name, and fail"
usage="fileTemporaryName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileTemporaryName'$'\e''[0m'$'\n'''$'\n''Wrapper for '$'\e''[[(code)]mmktemp'$'\e''[[(reset)]m. Generate a temporary file name, and fail using a function'$'\n''Argument: handler - Function. Required. Function to call on failure. Function Type: returnMessage'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: ... - Arguments. Optional. Any additional arguments are passed through.'$'\n''Requires: mktemp __help catchEnvironment usageDocument'$'\n''BUILD_DEBUG: temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks'$'\n''Environment: BUILD_DEBUG'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileTemporaryName'$'\n'''$'\n''Wrapper for mktemp. Generate a temporary file name, and fail using a function'$'\n''Argument: handler - Function. Required. Function to call on failure. Function Type: returnMessage'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: ... - Arguments. Optional. Any additional arguments are passed through.'$'\n''Requires: mktemp __help catchEnvironment usageDocument'$'\n''BUILD_DEBUG: temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks'$'\n''Environment: BUILD_DEBUG'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.46
