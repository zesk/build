#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output the number of columns in the terminal. Default is 60 if not able to be determined from `TERM`.\n\n`COLUMNS` and `LINES` environment variables may be modified by calling this function.\n\n'
descriptionLineCount="4"
environment=$'COLUMNS LINES\n'
example=$'    tail -n $(consoleRows) "$file"\n'
file="bin/build/tools/colors.sh"
fn="consoleRows"
fnMarker="consolerows"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="example" [4]="environment")
line="443"
rawComment=$'Summary: Row count in current console\nOutput the number of columns in the terminal. Default is 60 if not able to be determined from `TERM`.\nArgument: --help - Flag. Optional. Display this help.\nSee: stty\nExample:     tail -n $(consoleRows) "$file"\n`COLUMNS` and `LINES` environment variables may be modified by calling this function.\nEnvironment: COLUMNS LINES\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'stty\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="c9d95fe989d5ed804848a3a372521fbf3bd72ba9"
sourceLine="443"
summary="Row count in current console"
summaryComputed=""
usage="consoleRows [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleRows'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the number of columns in the terminal. Default is 60 if not able to be determined from '$'\e''[[(code)]mTERM'$'\e''[[(reset)]m.'$'\n'''$'\n'''$'\e''[[(code)]mCOLUMNS'$'\e''[[(reset)]m and '$'\e''[[(code)]mLINES'$'\e''[[(reset)]m environment variables may be modified by calling this function.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- COLUMNS LINES'$'\n'''$'\n''Example:'$'\n''    tail -n $(consoleRows) "$file"'
# shellcheck disable=SC2016
helpPlain='Usage: consoleRows [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Output the number of columns in the terminal. Default is 60 if not able to be determined from TERM.'$'\n'''$'\n''COLUMNS and LINES environment variables may be modified by calling this function.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- COLUMNS LINES'$'\n'''$'\n''Example:'$'\n''    tail -n $(consoleRows) "$file"'
documentationPath="documentation/source/tools/console.md"
