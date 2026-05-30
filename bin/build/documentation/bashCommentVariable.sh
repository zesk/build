#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-27
# shellcheck disable=SC2034
argument=$'variableName - String. Required. Get this variable value.\n--prefix - Flag. Optional. Find variables with the prefix `variableName`\n--insensitive | -i - Flag. Optional. Match case insensitive.\n--help - Flag. Optional. Display this help.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Gets a list of the variable values from a bash function comment\n\n'
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashCommentVariable"
fnMarker="bashcommentvariable"
foundNames=([0]="argument" [1]="stdin")
line="449"
rawComment=$'Gets a list of the variable values from a bash function comment\nArgument: variableName - String. Required. Get this variable value.\nstdin: Comment source (`# ` removed)\nArgument: --prefix - Flag. Optional. Find variables with the prefix `variableName`\nArgument: --insensitive | -i - Flag. Optional. Match case insensitive.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="8b11e89328e79950a2b4734a035cc38305d5a61e"
sourceLine="449"
stdin=$'Comment source (`# ` removed)\n'
summary="Gets a list of the variable values from a bash"
summaryComputed="true"
usage="bashCommentVariable variableName [ --prefix ] [ --insensitive | -i ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashCommentVariable'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvariableName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ --insensitive | -i ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvariableName        '$'\e''[[(value)]mString. Required. Get this variable value.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--prefix            '$'\e''[[(value)]mFlag. Optional. Find variables with the prefix '$'\e''[[(code)]mvariableName'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--insensitive | -i  '$'\e''[[(value)]mFlag. Optional. Match case insensitive.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help              '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Comment source ('$'\e''[[(code)]m# '$'\e''[[(reset)]m removed)'
# shellcheck disable=SC2016
helpPlain='Usage: bashCommentVariable variableName [ --prefix ] [ --insensitive | -i ] [ --help ]'$'\n'''$'\n''    variableName        String. Required. Get this variable value.'$'\n''    --prefix            Flag. Optional. Find variables with the prefix variableName'$'\n''    --insensitive | -i  Flag. Optional. Match case insensitive.'$'\n''    --help              Flag. Optional. Display this help.'$'\n'''$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Comment source (#  removed)'
documentationPath="documentation/source/tools/bash.md"
