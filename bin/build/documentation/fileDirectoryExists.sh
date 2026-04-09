#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="directory - Directory. Required. Test if file directory exists (file does not have to exist)"$'\n'""
base="directory.sh"
description="Does the file's directory exist?"$'\n'""
file="bin/build/tools/directory.sh"
fn="fileDirectoryExists"
foundNames=([0]="argument")
line="154"
lowerFn="filedirectoryexists"
rawComment="Does the file's directory exist?"$'\n'"Argument: directory - Directory. Required. Test if file directory exists (file does not have to exist)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="e3a8c59981053233f360475ab67f48cb580f1f5c"
sourceLine="154"
summary="Does the file's directory exist?"
summaryComputed="true"
usage="fileDirectoryExists directory"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileDirectoryExists'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. Test if file directory exists (file does not have to exist)'$'\e''[[(reset)]m'$'\n'''$'\n''Does the file'\''s directory exist?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileDirectoryExists directory'$'\n'''$'\n''    directory  Directory. Required. Test if file directory exists (file does not have to exist)'$'\n'''$'\n''Does the file'\''s directory exist?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/file.md"
