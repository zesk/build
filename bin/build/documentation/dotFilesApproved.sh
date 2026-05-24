#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'listType - String. Optional. One of `all`, `bash`, `git`, `darwin`, or `mysql`\n'
base="prompt-modules.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Lists of dot files which can be added to the dotFilesApprovedFile\nIf none specified, returns `bash` list.\nSpecial value `all` returns all values\n\n'
descriptionLineCount="4"
file="bin/build/tools/prompt-modules.sh"
fn="dotFilesApproved"
fnMarker="dotfilesapproved"
foundNames=([0]="argument")
line="119"
rawComment=$'Lists of dot files which can be added to the dotFilesApprovedFile\nArgument: listType - String. Optional. One of `all`, `bash`, `git`, `darwin`, or `mysql`\nIf none specified, returns `bash` list.\nSpecial value `all` returns all values\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/prompt-modules.sh"
sourceHash="88deb9ee5685724c1450f2249c6ebd6a9df5a223"
sourceLine="119"
summary="Lists of dot files which can be added to the"
summaryComputed="true"
usage="dotFilesApproved [ listType ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdotFilesApproved'$'\e''[0m '$'\e''[[(blue)]m[ listType ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mlistType  '$'\e''[[(value)]mString. Optional. One of '$'\e''[[(code)]mall'$'\e''[[(reset)]m, '$'\e''[[(code)]mbash'$'\e''[[(reset)]m, '$'\e''[[(code)]mgit'$'\e''[[(reset)]m, '$'\e''[[(code)]mdarwin'$'\e''[[(reset)]m, or '$'\e''[[(code)]mmysql'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Lists of dot files which can be added to the dotFilesApprovedFile'$'\n''If none specified, returns '$'\e''[[(code)]mbash'$'\e''[[(reset)]m list.'$'\n''Special value '$'\e''[[(code)]mall'$'\e''[[(reset)]m returns all values'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: dotFilesApproved [ listType ]'$'\n'''$'\n''    listType  String. Optional. One of all, bash, git, darwin, or mysql'$'\n'''$'\n''Lists of dot files which can be added to the dotFilesApprovedFile'$'\n''If none specified, returns bash list.'$'\n''Special value all returns all values'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/prompt.md"
