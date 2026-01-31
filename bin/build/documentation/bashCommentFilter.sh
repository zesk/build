#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
description="Filter comments from a bash stream"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)"$'\n'"Argument: file - File. Optional. File(s) to filter."$'\n'"stdin: a bash file"$'\n'"stdout: bash file without line-comments \`#\`"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=()
rawComment="Filter comments from a bash stream"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)"$'\n'"Argument: file - File. Optional. File(s) to filter."$'\n'"stdin: a bash file"$'\n'"stdout: bash file without line-comments \`#\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="Filter comments from a bash stream"
usage="bashCommentFilter"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashCommentFilter'$'\e''[0m'$'\n'''$'\n''Filter comments from a bash stream'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)'$'\n''Argument: file - File. Optional. File(s) to filter.'$'\n''stdin: a bash file'$'\n''stdout: bash file without line-comments '$'\e''[[(code)]m#'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashCommentFilter'$'\n'''$'\n''Filter comments from a bash stream'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)'$'\n''Argument: file - File. Optional. File(s) to filter.'$'\n''stdin: a bash file'$'\n''stdout: bash file without line-comments #'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.47
