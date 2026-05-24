#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)\nfile - File. Optional. File(s) to filter.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Filter comments from a bash stream\n\n'
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashCommentFilter"
fnMarker="bashcommentfilter"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="519"
rawComment=$'Filter comments from a bash stream\nArgument: --help - Flag. Optional. Display this help.\nArgument: --only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)\nArgument: file - File. Optional. File(s) to filter.\nstdin: a bash file\nstdout: bash file without line-comments `#`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="519"
stdin=$'a bash file\n'
stdout=$'bash file without line-comments `#`\n'
summary="Filter comments from a bash stream"
summaryComputed="true"
usage="bashCommentFilter [ --help ] [ --only ] [ file ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashCommentFilter'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --only ]'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--only  '$'\e''[[(value)]mFlag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile. Optional. File(s) to filter.'$'\e''[[(reset)]m'$'\n'''$'\n''Filter comments from a bash stream'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''a bash file'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''bash file without line-comments '$'\e''[[(code)]m#'$'\e''[[(reset)]m'
# shellcheck disable=SC2016
helpPlain='Usage: bashCommentFilter [ --help ] [ --only ] [ file ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    --only  Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)'$'\n''    file    File. Optional. File(s) to filter.'$'\n'''$'\n''Filter comments from a bash stream'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''a bash file'$'\n'''$'\n''Writes to stdout:'$'\n''bash file without line-comments #'
documentationPath="documentation/source/tools/bash.md"
