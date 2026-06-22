#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'exitCode - UnsignedInteger. Required. Exit code to return. Default is 1.\nmessage ... - String. Optional. Message to output\n'
base="example.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)\n\n'
descriptionLineCount="2"
file="bin/build/tools/example.sh"
fn="returnMessage"
fnMarker="returnmessage"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="143"
original="returnMessage"
rawComment=$'Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)\nArgument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1.\nArgument: message ... - String. Optional. Message to output\nReturn Code: exitCode\nRequires: isUnsignedInteger printf returnMessage\n\n'
requires=$'isUnsignedInteger printf returnMessage\n'
return_code=$'exitCode\n'
sourceFile="bin/build/tools/example.sh"
sourceHash="16c3218a667d992bd2f78932d5d53442205d1e0d"
sourceLine="143"
summary="Return passed in integer return code and output message to"
summaryComputed="true"
usage="returnMessage exitCode [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnMessage'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mexitCode'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mexitCode     '$'\e''[[(value)]mUnsignedInteger. Required. Exit code to return. Default is 1.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mString. Optional. Message to output'$'\e''[[(reset)]m'$'\n'''$'\n''Return passed in integer return code and output message to '$'\e''[[(code)]mstderr'$'\e''[[(reset)]m (non-zero) or '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m (zero)'$'\n'''$'\n''Return codes:'$'\n''- exitCode'
# shellcheck disable=SC2016
helpPlain='Usage: returnMessage exitCode [ message ... ]'$'\n'''$'\n''    exitCode     UnsignedInteger. Required. Exit code to return. Default is 1.'$'\n''    message ...  String. Optional. Message to output'$'\n'''$'\n''Return passed in integer return code and output message to stderr (non-zero) or stdout (zero)'$'\n'''$'\n''Return codes:'$'\n''- exitCode'
documentationPath="documentation/source/tools/sugar-core.md"
