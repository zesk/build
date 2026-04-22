#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="indexFile ... - File. Required. One or more index files to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="markdown.sh"
description="Displays any markdown files next to the given index file which are not found within the index file as links."$'\n'""
file="bin/build/tools/markdown.sh"
fn="markdownCheckIndex"
foundNames=([0]="argument")
line="142"
lowerFn="markdowncheckindex"
rawComment="Argument: indexFile ... - File. Required. One or more index files to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Displays any markdown files next to the given index file which are not found within the index file as links."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/markdown.sh"
sourceHash="8a7f9b5b9c80b1c26b4598fc0ffed681fb150099"
sourceLine="142"
summary="Displays any markdown files next to the given index file"
summaryComputed="true"
usage="markdownCheckIndex indexFile ... [ --help ] [ --handler handler ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmarkdownCheckIndex'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mindexFile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mindexFile ...      '$'\e''[[(value)]mFile. Required. One or more index files to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler  '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n'''$'\n''Displays any markdown files next to the given index file which are not found within the index file as links.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: markdownCheckIndex indexFile ... [ --help ] [ --handler handler ]'$'\n'''$'\n''    indexFile ...      File. Required. One or more index files to check.'$'\n''    --help             Flag. Optional. Display this help.'$'\n''    --handler handler  Function. Optional. Use this error handler instead of the default error handler.'$'\n'''$'\n''Displays any markdown files next to the given index file which are not found within the index file as links.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/markdown.md"
