#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'directory - Directory. Required. Test if file directory exists (file does not have to exist)\n'
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Does the file\'s directory exist?\n\n'
descriptionLineCount="2"
file="bin/build/tools/directory.sh"
fn="fileDirectoryExists"
fnMarker="filedirectoryexists"
foundNames=([0]="argument")
line="158"
rawComment=$'Does the file\'s directory exist?\nArgument: directory - Directory. Required. Test if file directory exists (file does not have to exist)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/directory.sh"
sourceHash="56e2e47efbd4d48b0fa152ed5f06ec8d0ff20d9e"
sourceLine="158"
summary="Does the file's directory exist?"
summaryComputed="true"
usage="fileDirectoryExists directory"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileDirectoryExists'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mdirectory  '$'\e''[[(value)]mDirectory. Required. Test if file directory exists (file does not have to exist)'$'\e''[[(reset)]m'$'\n'''$'\n''Does the file'\''s directory exist?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: fileDirectoryExists directory'$'\n'''$'\n''    directory  Directory. Required. Test if file directory exists (file does not have to exist)'$'\n'''$'\n''Does the file'\''s directory exist?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/file.md"
