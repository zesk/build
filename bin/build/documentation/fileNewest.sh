#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-01
# shellcheck disable=SC2034
argument=$'file ... - File. Required. One or more files to examine\n--help - Flag. Optional. Display this help.\n--ignore - Flag. Optional. Ignore files which do not exist.\n'
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output the newest file in the list\n\n'
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="fileNewest"
fnMarker="filenewest"
foundNames=([0]="argument")
line="378"
rawComment=$'Output the newest file in the list\nArgument: file ... - File. Required. One or more files to examine\nArgument: --help - Flag. Optional. Display this help.\nArgument: --ignore - Flag. Optional. Ignore files which do not exist.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/file.sh"
sourceHash="1ddfd7452bcc3ae87f5e31f996487d77938a316d"
sourceLine="378"
summary="Output the newest file in the list"
summaryComputed="true"
usage="fileNewest file ... [ --help ] [ --ignore ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileNewest'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --ignore ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfile ...  '$'\e''[[(value)]mFile. Required. One or more files to examine'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--ignore  '$'\e''[[(value)]mFlag. Optional. Ignore files which do not exist.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the newest file in the list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: fileNewest file ... [ --help ] [ --ignore ]'$'\n'''$'\n''    file ...  File. Required. One or more files to examine'$'\n''    --help    Flag. Optional. Display this help.'$'\n''    --ignore  Flag. Optional. Ignore files which do not exist.'$'\n'''$'\n''Output the newest file in the list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/file.md"
