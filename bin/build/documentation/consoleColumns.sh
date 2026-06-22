#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.\n\n'
descriptionLineCount="2"
environment=$'- `COLUMNS` - May be defined after calling this\n- `LINES` - May be defined after calling this\n'
example=$'    textRepeat $(consoleColumns)\n'
file="bin/build/tools/colors.sh"
fn="consoleColumns"
fnMarker="consolecolumns"
foundNames=([0]="summary" [1]="stdout" [2]="argument" [3]="see" [4]="example" [5]="environment" [6]="side_effect")
line="384"
original="consoleColumns"
rawComment=$'Summary: Column count in current console\nOutput the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.\nstdout: Integer\nArgument: --help - Flag. Optional. Display this help.\nSee: stty\nExample:     textRepeat $(consoleColumns)\nEnvironment: - `COLUMNS` - May be defined after calling this\nEnvironment: - `LINES` - May be defined after calling this\nSide Effect: MAY define two environment variables\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'stty\n'
side_effect=$'MAY define two environment variables\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="480be5db852b12675144ab1e6476bc78bcb875fa"
sourceLine="384"
stdout=$'Integer\n'
summary="Column count in current console"
summaryComputed=""
usage="consoleColumns [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleColumns'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the number of columns in the terminal. Default is 80 if not able to be determined from '$'\e''[[(code)]mTERM'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mCOLUMNS'$'\e''[[(reset)]m - May be defined after calling this'$'\n''- '$'\e''[[(code)]mLINES'$'\e''[[(reset)]m - May be defined after calling this'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''Integer'$'\n'''$'\n''Example:'$'\n''    textRepeat $(consoleColumns)'
# shellcheck disable=SC2016
helpPlain='Usage: consoleColumns [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Output the number of columns in the terminal. Default is 80 if not able to be determined from TERM.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- COLUMNS - May be defined after calling this'$'\n''- LINES - May be defined after calling this'$'\n'''$'\n''Writes to stdout:'$'\n''Integer'$'\n'''$'\n''Example:'$'\n''    textRepeat $(consoleColumns)'
documentationPath="documentation/source/tools/console.md"
