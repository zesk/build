#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)"$'\n'"file - File. Optional. File(s) to filter."$'\n'""
base="bash.sh"
description="Filter comments from a bash stream"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Filter comments from a bash stream"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)"$'\n'"Argument: file - File. Optional. File(s) to filter."$'\n'"stdin: a bash file"$'\n'"stdout: bash file without line-comments \`#\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
stdin="a bash file"$'\n'""
stdout="bash file without line-comments \`#\`"$'\n'""
summary="Filter comments from a bash stream"
usage="bashCommentFilter [ --help ] [ --only ] [ file ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashCommentFilter'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --only ]'$'\e''[0m '$'\e''[[(blue)]m[ file ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--only  '$'\e''[[(value)]mFlag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfile    '$'\e''[[(value)]mFile. Optional. File(s) to filter.'$'\e''[[(reset)]m'$'\n'''$'\n''Filter comments from a bash stream'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''a bash file'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''bash file without line-comments '$'\e''[[(code)]m#'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mbashCommentFilter [[(blue)]m[ --help ] [[(blue)]m[ --only ] [[(blue)]m[ file ]'$'\n'''$'\n''    [[(blue)]m--help  [[(value)]mFlag. Optional. Display this help.[[(reset)]m'$'\n''    [[(blue)]m--only  [[(value)]mFlag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)[[(reset)]m'$'\n''    [[(blue)]mfile    [[(value)]mFile. Optional. File(s) to filter.[[(reset)]m'$'\n'''$'\n''Filter comments from a bash stream'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''$'\n''Reads from [[(code)]mstdin[[(reset)]m:'$'\n''a bash file'$'\n'''$'\n''Writes to [[(code)]mstdout[[(reset)]m:'$'\n''bash file without line-comments [[(code)]m#[[(reset)]m'$'\n'''
# elapsed 2.837
