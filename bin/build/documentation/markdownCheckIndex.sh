#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'indexFile ... - File. Required. One or more index files to check.\n--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n'
base="markdown.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Displays any markdown files next to the given index file which are not found within the index file as links.\n\n'
descriptionLineCount="2"
file="bin/build/tools/markdown.sh"
fn="markdownCheckIndex"
fnMarker="markdowncheckindex"
foundNames=([0]="argument")
line="177"
original="markdownCheckIndex"
rawComment=$'Argument: indexFile ... - File. Required. One or more index files to check.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nDisplays any markdown files next to the given index file which are not found within the index file as links.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/markdown.sh"
sourceHash="bb04291467a2d67a3035f0306a41d12cbd803a7a"
sourceLine="177"
summary="Displays any markdown files next to the given index file"
summaryComputed="true"
usage="markdownCheckIndex indexFile ... [ --help ] [ --handler handler ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmarkdownCheckIndex'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mindexFile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mindexFile ...      '$'\e''[[(value)]mFile. Required. One or more index files to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n'''$'\n''Displays any markdown files next to the given index file which are not found within the index file as links.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: markdownCheckIndex indexFile ... [ --help ] [ --handler handler ]'$'\n'''$'\n''    indexFile ...      File. Required. One or more index files to check.'$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n'''$'\n''Displays any markdown files next to the given index file which are not found within the index file as links.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/markdown.md"
