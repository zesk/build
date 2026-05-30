#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-27
# shellcheck disable=SC2034
argument=$'handler - Function. Required. Function to call on failure. Function Type: returnMessage\n--help - Flag. Optional. Display this help.\n... - Arguments. Optional. Any additional arguments are passed through.\n'
base="file.sh"
build_debug=$'temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Wrapper for `mktemp`. Generate a temporary file name, and fail using a function\n\n'
descriptionLineCount="2"
environment=$'BUILD_DEBUG\n'
file="bin/build/tools/file.sh"
fn="fileTemporaryName"
fnMarker="filetemporaryname"
foundNames=([0]="argument" [1]="requires" [2]="build_debug" [3]="environment")
line="916"
rawComment=$'Wrapper for `mktemp`. Generate a temporary file name, and fail using a function\nArgument: handler - Function. Required. Function to call on failure. Function Type: returnMessage\nArgument: --help - Flag. Optional. Display this help.\nArgument: ... - Arguments. Optional. Any additional arguments are passed through.\nRequires: mktemp helpArgument catchEnvironment bashDocumentation\nBUILD_DEBUG: temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks\nEnvironment: BUILD_DEBUG\n\n'
requires=$'mktemp helpArgument catchEnvironment bashDocumentation\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="bbae84ac54a20b3ed2a0936cd425f12f62a59d01"
sourceLine="916"
summary="Wrapper for \`mktemp\`. Generate a temporary file name, and fail"
summaryComputed="true"
usage="fileTemporaryName handler [ --help ] [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileTemporaryName'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mhandler  '$'\e''[[(value)]mFunction. Required. Function to call on failure. Function Type: returnMessage'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...      '$'\e''[[(value)]mArguments. Optional. Any additional arguments are passed through.'$'\e''[[(reset)]m'$'\n'''$'\n''Wrapper for '$'\e''[[(code)]mmktemp'$'\e''[[(reset)]m. Generate a temporary file name, and fail using a function'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG'$'\n'''$'\n'''$'\e''[[(code)]mBUILD_DEBUG'$'\e''[[(reset)]m settings:'$'\n''- '$'\e''[[(code)]mtemp'$'\e''[[(reset)]m - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks'
# shellcheck disable=SC2016
helpPlain='Usage: fileTemporaryName handler [ --help ] [ ... ]'$'\n'''$'\n''    handler  Function. Required. Function to call on failure. Function Type: returnMessage'$'\n''    --help   Flag. Optional. Display this help.'$'\n''    ...      Arguments. Optional. Any additional arguments are passed through.'$'\n'''$'\n''Wrapper for mktemp. Generate a temporary file name, and fail using a function'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_DEBUG'$'\n'''$'\n''BUILD_DEBUG settings:'$'\n''- temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks'
documentationPath="documentation/source/tools/file.md"
