#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="variableName - String. Required. Get this variable value."$'\n'"--prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Gets a list of the variable values from a bash function comment"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=([0]="argument" [1]="stdin")
rawComment="Gets a list of the variable values from a bash function comment"$'\n'"Argument: variableName - String. Required. Get this variable value."$'\n'"stdin: Comment source (\`# \` removed)"$'\n'"Argument: --prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
stdin="Comment source (\`# \` removed)"$'\n'""
summary="Gets a list of the variable values from a bash"
usage="bashCommentVariable variableName [ --prefix ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashCommentVariable'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mvariableName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mvariableName  '$'\e''[[(value)]mString. Required. Get this variable value.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--prefix      '$'\e''[[(value)]mflag. Optional. Find variables with the prefix '$'\e''[[(code)]mvariableName'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Comment source ('$'\e''[[(code)]m# '$'\e''[[(reset)]m removed)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mbashCommentVariable [[(magenta)]mvariableName [[(blue)]m[ --prefix ] [[(blue)]m[ --help ]'$'\n'''$'\n''    variableName  [[(value)]mString. Required. Get this variable value.'$'\n''    [[(blue)]m--prefix      [[(value)]mflag. Optional. Find variables with the prefix variableName'$'\n''    [[(blue)]m--help        [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Gets a list of the variable values from a bash function comment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Comment source (#  removed)'$'\n'''
# elapsed 2.835
