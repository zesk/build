#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
description="Removes any blank lines from the beginning of a stream"$'\n'""
file="bin/build/tools/text.sh"
fn="trimHead"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Removes any blank lines from the beginning of a stream"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Reads lines from stdin until EOF"$'\n'"stdout: Outputs modified lines"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="313b9bb00d69a2ae5d20033ba8bcb6de4d68d74e"
stdin="Reads lines from stdin until EOF"$'\n'""
stdout="Outputs modified lines"$'\n'""
summary="Removes any blank lines from the beginning of a stream"
summaryComputed="true"
usage="trimHead [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtrimHead'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Removes any blank lines from the beginning of a stream'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Outputs modified lines'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: trimHead [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Removes any blank lines from the beginning of a stream'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Reads lines from stdin until EOF'$'\n'''$'\n''Writes to stdout:'$'\n''Outputs modified lines'$'\n'''
