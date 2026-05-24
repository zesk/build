#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'code ... - UnsignedInteger. String. Exit code value to output.\n--help - Flag. Optional. Display this help.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output the exit code as a string\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnCodeString"
fnMarker="returncodestring"
foundNames=([0]="argument" [1]="stdout" [2]="see")
line="60"
rawComment=$'Output the exit code as a string\nArgument: code ... - UnsignedInteger. String. Exit code value to output.\nArgument: --help - Flag. Optional. Display this help.\nstdout: exitCodeToken, one per line\nSee: returnCode\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'returnCode\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="60"
stdout=$'exitCodeToken, one per line\n'
summary="Output the exit code as a string"
summaryComputed="true"
usage="returnCodeString [ code ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnCodeString'$'\e''[0m '$'\e''[[(blue)]m[ code ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcode ...  '$'\e''[[(value)]mUnsignedInteger. String. Exit code value to output.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help    '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the exit code as a string'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''exitCodeToken, one per line'
# shellcheck disable=SC2016
helpPlain='Usage: returnCodeString [ code ... ] [ --help ]'$'\n'''$'\n''    code ...  UnsignedInteger. String. Exit code value to output.'$'\n''    --help    Flag. Optional. Display this help.'$'\n'''$'\n''Output the exit code as a string'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''exitCodeToken, one per line'
documentationPath="documentation/source/tools/sugar-core.md"
