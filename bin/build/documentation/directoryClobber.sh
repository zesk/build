#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="source - Directory. Required. target"$'\n'"target - FileDirectory. Required."$'\n'""
base="directory.sh"
description="Copy directory over another sort-of-atomically"$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryClobber"
foundNames=([0]="argument")
rawComment="Argument: source - Directory. Required. target"$'\n'"Argument: target - FileDirectory. Required."$'\n'"Copy directory over another sort-of-atomically"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="e3a8c59981053233f360475ab67f48cb580f1f5c"
summary="Copy directory over another sort-of-atomically"
summaryComputed="true"
usage="directoryClobber source target"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdirectoryClobber'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msource'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtarget'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]msource  '$'\e''[[(value)]mDirectory. Required. target'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtarget  '$'\e''[[(value)]mFileDirectory. Required.'$'\e''[[(reset)]m'$'\n'''$'\n''Copy directory over another sort-of-atomically'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: directoryClobber source target'$'\n'''$'\n''    source  Directory. Required. target'$'\n''    target  FileDirectory. Required.'$'\n'''$'\n''Copy directory over another sort-of-atomically'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
