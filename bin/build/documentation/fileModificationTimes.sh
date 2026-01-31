#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="file.sh"
description="Lists files in a directory recursively along with their modification time in seconds."$'\n'"Output is unsorted."$'\n'"Argument: directory - Directory. Required. Must exists - directory to list."$'\n'"Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'"Example: {fn} \$myDir ! -path \"*/.*/*\""$'\n'"Output: 1705347087 bin/build/tools.sh"$'\n'"Output: 1704312758 bin/build/deprecated.sh"$'\n'"Output: 1705442647 bin/build/build.json"$'\n'""
file="bin/build/tools/file.sh"
foundNames=()
rawComment="Lists files in a directory recursively along with their modification time in seconds."$'\n'"Output is unsorted."$'\n'"Argument: directory - Directory. Required. Must exists - directory to list."$'\n'"Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'"Example: {fn} \$myDir ! -path \"*/.*/*\""$'\n'"Output: 1705347087 bin/build/tools.sh"$'\n'"Output: 1704312758 bin/build/deprecated.sh"$'\n'"Output: 1705442647 bin/build/build.json"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Lists files in a directory recursively along with their modification"
usage="fileModificationTimes"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModificationTimes'$'\e''[0m'$'\n'''$'\n''Lists files in a directory recursively along with their modification time in seconds.'$'\n''Output is unsorted.'$'\n''Argument: directory - Directory. Required. Must exists - directory to list.'$'\n''Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query'$'\n''Example: fileModificationTimes $myDir ! -path "'$'\e''[[(cyan)]m/.'$'\e''[[(reset)]m/'$'\e''[[(cyan)]m"'$'\e''[[(reset)]m'$'\n''Output: 1705347087 bin/build/tools.sh'$'\n''Output: 1704312758 bin/build/deprecated.sh'$'\n''Output: 1705442647 bin/build/build.json'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileModificationTimes'$'\n'''$'\n''Lists files in a directory recursively along with their modification time in seconds.'$'\n''Output is unsorted.'$'\n''Argument: directory - Directory. Required. Must exists - directory to list.'$'\n''Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query'$'\n''Example: fileModificationTimes $myDir ! -path "/./"'$'\n''Output: 1705347087 bin/build/tools.sh'$'\n''Output: 1704312758 bin/build/deprecated.sh'$'\n''Output: 1705442647 bin/build/build.json'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.481
