#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"path - Directory. Required. The documentation path to examine."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Generate a list of files which have unresolved \`SEE:\` tokens in the documentation path."$'\n'"Searches Markdown (\`.md\`) files a single level deep."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/documentation.sh"
fn="documentationFunctionsListSeeUnfinished"
fnMarker="documentationfunctionslistseeunfinished"
foundNames=([0]="summary" [1]="argument" [2]="stdout")
line="954"
rawComment="Summary: List files with unresolved \`SEE:\` tokens in documentation path"$'\n'"Generate a list of files which have unresolved \`SEE:\` tokens in the documentation path."$'\n'"Searches Markdown (\`.md\`) files a single level deep."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: path - Directory. Required. The documentation path to examine."$'\n'"stdout: File"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="7c3d196118740ec8c3cc1fc6f190e82d99a768c2"
sourceLine="954"
stdout="File"$'\n'""
summary="List files with unresolved \`SEE:\` tokens in documentation path"
summaryComputed=""
usage="documentationFunctionsListSeeUnfinished [ --help ] path"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationFunctionsListSeeUnfinished'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpath'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpath    '$'\e''[[(value)]mDirectory. Required. The documentation path to examine.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate a list of files which have unresolved '$'\e''[[(code)]mSEE:'$'\e''[[(reset)]m tokens in the documentation path.'$'\n''Searches Markdown ('$'\e''[[(code)]m.md'$'\e''[[(reset)]m) files a single level deep.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''File'
# shellcheck disable=SC2016
helpPlain='Usage: documentationFunctionsListSeeUnfinished [ --help ] path'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    path    Directory. Required. The documentation path to examine.'$'\n'''$'\n''Generate a list of files which have unresolved SEE: tokens in the documentation path.'$'\n''Searches Markdown (.md) files a single level deep.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''File'
documentationPath="documentation/source/tools/documentation.md"
