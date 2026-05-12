#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.\n--help - Flag. Optional. Display this help.\ntext - EmptyString. Required. Text to convert to stringLowercase\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Convert text to stringLowercase\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="stringLowercase"
fnMarker="stringlowercase"
foundNames=([0]="argument" [1]="stdout" [2]="requires")
line="868"
rawComment=$'Convert text to stringLowercase\nArgument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.\nArgument: --help - Flag. Optional. Display this help.\nArgument: text - EmptyString. Required. Text to convert to stringLowercase\nstdout: `String`. The stringLowercase version of the `text`.\nRequires: tr\n\n'
requires=$'tr\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="868"
stdout=$'`String`. The stringLowercase version of the `text`.\n'
summary="Convert text to stringLowercase"
summaryComputed="true"
usage="stringLowercase [ -- ] [ --help ] text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringLowercase'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--      '$'\e''[[(value)]mFlag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtext    '$'\e''[[(value)]mEmptyString. Required. Text to convert to stringLowercase'$'\e''[[(reset)]m'$'\n'''$'\n''Convert text to stringLowercase'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n'''$'\e''[[(code)]mString'$'\e''[[(reset)]m. The stringLowercase version of the '$'\e''[[(code)]mtext'$'\e''[[(reset)]m.'
# shellcheck disable=SC2016
helpPlain='Usage: stringLowercase [ -- ] [ --help ] text'$'\n'''$'\n''    --      Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\n''    --help  Flag. Optional. Display this help.'$'\n''    text    EmptyString. Required. Text to convert to stringLowercase'$'\n'''$'\n''Convert text to stringLowercase'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''String. The stringLowercase version of the text.'
documentationPath="documentation/source/tools/text.md"
