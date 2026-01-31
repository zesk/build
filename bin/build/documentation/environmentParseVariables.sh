#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Parse variables from an environment variable stream"$'\n'"Extracts lines with \`NAME=value\`"$'\n'"Details:"$'\n'"- Remove \`export \` from lines"$'\n'"- Skip lines containing \`read -r\`"$'\n'"- Anything before a \`=\` is considered a variable name"$'\n'"- Returns a sorted, unique list"$'\n'""
file="bin/build/tools/environment.sh"
foundNames=([0]="stdin" [1]="stdout" [2]="argument")
rawComment="Parse variables from an environment variable stream"$'\n'"Extracts lines with \`NAME=value\`"$'\n'"Details:"$'\n'"- Remove \`export \` from lines"$'\n'"- Skip lines containing \`read -r\`"$'\n'"- Anything before a \`=\` is considered a variable name"$'\n'"- Returns a sorted, unique list"$'\n'"stdin: Environment File"$'\n'"stdout: EnvironmentVariable. One per line."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="4226efba8a29858c837cfce31f7416e4226eaa32"
stdin="Environment File"$'\n'""
stdout="EnvironmentVariable. One per line."$'\n'""
summary="Parse variables from an environment variable stream"
summaryComputed="true"
usage="environmentParseVariables [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentParseVariables'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Parse variables from an environment variable stream'$'\n''Extracts lines with '$'\e''[[(code)]mNAME=value'$'\e''[[(reset)]m'$'\n''Details:'$'\n''- Remove '$'\e''[[(code)]mexport '$'\e''[[(reset)]m from lines'$'\n''- Skip lines containing '$'\e''[[(code)]mread -r'$'\e''[[(reset)]m'$'\n''- Anything before a '$'\e''[[(code)]m='$'\e''[[(reset)]m is considered a variable name'$'\n''- Returns a sorted, unique list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Environment File'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''EnvironmentVariable. One per line.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentParseVariables [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Parse variables from an environment variable stream'$'\n''Extracts lines with NAME=value'$'\n''Details:'$'\n''- Remove export  from lines'$'\n''- Skip lines containing read -r'$'\n''- Anything before a = is considered a variable name'$'\n''- Returns a sorted, unique list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Environment File'$'\n'''$'\n''Writes to stdout:'$'\n''EnvironmentVariable. One per line.'$'\n'''
