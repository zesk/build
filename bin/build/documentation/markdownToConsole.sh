#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/colors.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
description="Converts backticks, bold and italic to console colors."$'\n'""
file="bin/build/tools/colors.sh"
foundNames=([0]="summary" [1]="stdin" [2]="stdout" [3]="argument")
rawComment="Summary: Converts backticks, bold and italic to console colors."$'\n'"stdin: Markdown"$'\n'"stdout: decorated console output"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceModified="1769211509"
stdin="Markdown"$'\n'""
stdout="decorated console output"$'\n'""
summary="Converts backticks, bold and italic to console colors."$'\n'""
usage="markdownToConsole [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmarkdownToConsole'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Converts backticks, bold and italic to console colors.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Markdown'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''decorated console output'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: markdownToConsole [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Converts backticks, bold and italic to console colors.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Markdown'$'\n'''$'\n''Writes to stdout:'$'\n''decorated console output'$'\n'''
# elapsed 0.455
