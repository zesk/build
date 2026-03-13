#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-13
# shellcheck disable=SC2034
argument="-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"--help - Flag. Optional. Display this help."$'\n'"text - EmptyString. Required. Text to convert to stringLowercase"$'\n'""
base="text.sh"
description="Convert text to stringLowercase"$'\n'""
file="bin/build/tools/text.sh"
fn="stringLowercase"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
rawComment="Convert text to stringLowercase"$'\n'"Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: text - EmptyString. Required. Text to convert to stringLowercase"$'\n'"stdout: \`String\`. The stringLowercase version of the \`text\`."$'\n'"Requires: tr"$'\n'""$'\n'""
requires="tr"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="f0c5212f3e402f51e272ac32015e5e0be9f2581c"
stdout="\`String\`. The stringLowercase version of the \`text\`."$'\n'""
summary="Convert text to stringLowercase"
summaryComputed="true"
usage="stringLowercase [ -- ] [ --help ] text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringLowercase'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--      '$'\e''[[(value)]mFlag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtext    '$'\e''[[(value)]mEmptyString. Required. Text to convert to stringLowercase'$'\e''[[(reset)]m'$'\n'''$'\n''Convert text to stringLowercase'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n'''$'\e''[[(code)]mString'$'\e''[[(reset)]m. The stringLowercase version of the '$'\e''[[(code)]mtext'$'\e''[[(reset)]m.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: stringLowercase [ -- ] [ --help ] text'$'\n'''$'\n''    --      Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\n''    --help  Flag. Optional. Display this help.'$'\n''    text    EmptyString. Required. Text to convert to stringLowercase'$'\n'''$'\n''Convert text to stringLowercase'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String. The stringLowercase version of the text.'$'\n'''
