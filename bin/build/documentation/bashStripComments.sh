#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Removes literally any line which begins with zero or more whitespace characters and then a \`#\`."$'\n'""
exitCode="0"
file="bin/build/tools/bash.sh"
foundNames=([0]="summary" [1]="argument")
rawComment="Summary: Pipe to strip comments from a bash file"$'\n'"Removes literally any line which begins with zero or more whitespace characters and then a \`#\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1769208503"
summary="Pipe to strip comments from a bash file"$'\n'""
usage="bashStripComments [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mbashStripComments'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Removes literally any line which begins with zero or more whitespace characters and then a '$'\e''[[code]m#'$'\e''[[reset]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashStripComments [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Removes literally any line which begins with zero or more whitespace characters and then a #.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
