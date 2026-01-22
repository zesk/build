#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="handler - Function. Required. Function to call on failure. Function Type: returnMessage"$'\n'"--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Optional. Any additional arguments are passed through."$'\n'""
base="file.sh"
build_debug="temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks"$'\n'""
description="Wrapper for \`mktemp\`. Generate a temporary file name, and fail using a function"$'\n'""
environment="BUILD_DEBUG"$'\n'""
file="bin/build/tools/file.sh"
fn="fileTemporaryName"
requires="mktemp __help catchEnvironment usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1768775696"
summary="Wrapper for \`mktemp\`. Generate a temporary file name, and fail"
usage="fileTemporaryName handler [ --help ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileTemporaryName[0m [38;2;255;255;0m[35;48;2;0;0;0mhandler[0m[0m [94m[ --help ][0m [94m[ ... ][0m

    [31mhandler  [1;97mFunction. Required. Function to call on failure. Function Type: returnMessage[0m
    [94m--help   [1;97mFlag. Optional. Display this help.[0m
    [94m...      [1;97mArguments. Optional. Any additional arguments are passed through.[0m

Wrapper for [38;2;0;255;0;48;2;0;0;0mmktemp[0m. Generate a temporary file name, and fail using a function

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG
- 

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileTemporaryName handler [ --help ] [ ... ]

    handler  Function. Required. Function to call on failure. Function Type: returnMessage
    --help   Flag. Optional. Display this help.
    ...      Arguments. Optional. Any additional arguments are passed through.

Wrapper for mktemp. Generate a temporary file name, and fail using a function

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG
- 

BUILD_DEBUG settings:
- temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks
- 
'
