#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="directory - Directory. Required. Must exists - directory to list."$'\n'"findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'""
base="file.sh"
description="Lists files in a directory recursively along with their modification time in seconds."$'\n'"Output is unsorted."$'\n'""
example="fileModificationTimes \$myDir ! -path \"*/.*/*\""$'\n'""
file="bin/build/tools/file.sh"
foundNames=([0]="argument" [1]="example" [2]="output")
output="1705347087 bin/build/tools.sh"$'\n'"1704312758 bin/build/deprecated.sh"$'\n'"1705442647 bin/build/build.json"$'\n'""
rawComment="Lists files in a directory recursively along with their modification time in seconds."$'\n'"Output is unsorted."$'\n'"Argument: directory - Directory. Required. Must exists - directory to list."$'\n'"Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'"Example: {fn} \$myDir ! -path \"*/.*/*\""$'\n'"Output: 1705347087 bin/build/tools.sh"$'\n'"Output: 1704312758 bin/build/deprecated.sh"$'\n'"Output: 1705442647 bin/build/build.json"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="Lists files in a directory recursively along with their modification"
summaryComputed="true"
usage="fileModificationTimes directory [ findArgs ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModificationTimes'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ findArgs ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. Must exists - directory to list.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfindArgs   '$'\e''[[(value)]mArguments. Optional. Optional additional arguments to modify the find query'$'\e''[[(reset)]m'$'\n'''$'\n''Lists files in a directory recursively along with their modification time in seconds.'$'\n''Output is unsorted.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''fileModificationTimes $myDir ! -path "'$'\e''[[(cyan)]m/.'$'\e''[[(reset)]m/'$'\e''[[(cyan)]m"'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mfileModificationTimes [[(bold)]m[[(magenta)]mdirectory [[(blue)]m[ findArgs ]'$'\n'''$'\n''    [[(red)]mdirectory  [[(value)]mDirectory. Required. Must exists - directory to list.[[(reset)]m'$'\n''    [[(blue)]mfindArgs   [[(value)]mArguments. Optional. Optional additional arguments to modify the find query[[(reset)]m'$'\n'''$'\n''Lists files in a directory recursively along with their modification time in seconds.'$'\n''Output is unsorted.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''fileModificationTimes $myDir ! -path "[[(cyan)]m/.[[(reset)]m/[[(cyan)]m"[[(reset)]m'$'\n'''
# elapsed 3.653
