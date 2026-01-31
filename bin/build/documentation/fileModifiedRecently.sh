#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="directory - Directory. Required. Must exists - directory to list."$'\n'"findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'""
base="file.sh"
description="List the most recently modified file in a directory prefixed with the timestamp"$'\n'""
file="bin/build/tools/file.sh"
rawComment="List the most recently modified file in a directory prefixed with the timestamp"$'\n'"Argument: directory - Directory. Required. Must exists - directory to list."$'\n'"Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="3b2ff8d50f51bb66cfa45739fb7abe9787c417f0"
summary="List the most recently modified file in a directory prefixed"
summaryComputed="true"
usage="fileModifiedRecently directory [ findArgs ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileModifiedRecently'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ findArgs ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. Must exists - directory to list.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfindArgs   '$'\e''[[(value)]mArguments. Optional. Optional additional arguments to modify the find query'$'\e''[[(reset)]m'$'\n'''$'\n''List the most recently modified file in a directory prefixed with the timestamp'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mfileModifiedRecently [[(bold)]m[[(magenta)]mdirectory [[(blue)]m[ findArgs ]'$'\n'''$'\n''    directory  [[(value)]mDirectory. Required. Must exists - directory to list.'$'\n''    [[(blue)]mfindArgs   [[(value)]mArguments. Optional. Optional additional arguments to modify the find query'$'\n'''$'\n''List the most recently modified file in a directory prefixed with the timestamp'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
# elapsed 3.67
