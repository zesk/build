#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
description="Ensures blank lines are singular"$'\n'"Used often to clean up markdown \`.md\` files, but can be used for any line-based configuration file which allows blank lines."$'\n'""
file="bin/build/tools/text.sh"
fn="textSingleBlankLines"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Ensures blank lines are singular"$'\n'"Used often to clean up markdown \`.md\` files, but can be used for any line-based configuration file which allows blank lines."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs modified lines where any blank lines are replaced with a single blank line."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="80ad24738a32b8002bafa685f78fc47389363a7d"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs modified lines where any blank lines are replaced with a single blank line."$'\n'""
summary="Ensures blank lines are singular"
summaryComputed="true"
usage="textSingleBlankLines [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextSingleBlankLines'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Ensures blank lines are singular'$'\n''Used often to clean up markdown '$'\e''[[(code)]m.md'$'\e''[[(reset)]m files, but can be used for any line-based configuration file which allows blank lines.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Outputs modified lines where any blank lines are replaced with a single blank line.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: textSingleBlankLines [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Ensures blank lines are singular'$'\n''Used often to clean up markdown .md files, but can be used for any line-based configuration file which allows blank lines.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to stdout:'$'\n''Outputs modified lines where any blank lines are replaced with a single blank line.'$'\n'''
