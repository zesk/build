#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="handler - Function. Required. Function to call on failure. Function Type: returnMessage"$'\n'"--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Optional. Any additional arguments are passed through."$'\n'""
base="file.sh"
build_debug="temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks"$'\n'""
description="Wrapper for \`mktemp\`. Generate a temporary file name, and fail using a function"$'\n'""
environment="BUILD_DEBUG"$'\n'""
file="bin/build/tools/file.sh"
fn="fileTemporaryName"
foundNames=([0]="argument" [1]="requires" [2]="build_debug" [3]="environment")
requires="mktemp __help catchEnvironment usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768721469"
summary="Wrapper for \`mktemp\`. Generate a temporary file name, and fail"
usage="fileTemporaryName handler [ --help ] [ ... ]"
