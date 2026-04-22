#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)"$'\n'"file - File. Optional. File(s) to filter."$'\n'""
base="bash.sh"
description="Filter comments from a bash stream"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashCommentFilter"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="519"
lowerFn="bashcommentfilter"
rawComment="Filter comments from a bash stream"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)"$'\n'"Argument: file - File. Optional. File(s) to filter."$'\n'"stdin: a bash file"$'\n'"stdout: bash file without line-comments \`#\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="ce103c0a855c85ae7ea74c3b00899b56536cfe79"
sourceLine="519"
stdin="a bash file"$'\n'""
stdout="bash file without line-comments \`#\`"$'\n'""
summary="Filter comments from a bash stream"
summaryComputed="true"
usage="bashCommentFilter [ --help ] [ --only ] [ file ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashCommentFilter'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --only ]'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--only  '$'\e''[[(value)]mFlag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile. Optional. File(s) to filter.'$'\e''[[(reset)]m'$'\n'''$'\n''Filter comments from a bash stream'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''a bash file'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''bash file without line-comments '$'\e''[[(code)]m#'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashCommentFilter [ --help ] [ --only ] [ file ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    --only  Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)'$'\n''    file    File. Optional. File(s) to filter.'$'\n'''$'\n''Filter comments from a bash stream'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''a bash file'$'\n'''$'\n''Writes to stdout:'$'\n''bash file without line-comments #'$'\n'''
documentationPath="documentation/source/tools/bash.md"
