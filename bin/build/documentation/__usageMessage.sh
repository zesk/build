#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="returnCode - UnsignedInteger. Optional. Exit code to possibly display with message."$'\n'"message ... - String. Optional. Display this message which describes why \`exitCode\` occurred."$'\n'""
base="usage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output the message for usage consistently"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/usage.sh"
fn="__usageMessage"
fnMarker="__usagemessage"
foundNames=([0]="argument" [1]="requires")
line="94"
rawComment="Output the message for usage consistently"$'\n'"Argument: returnCode - UnsignedInteger. Optional. Exit code to possibly display with message."$'\n'"Argument: message ... - String. Optional. Display this message which describes why \`exitCode\` occurred."$'\n'"Requires: decorate returnCodeString"$'\n'""$'\n'""
requires="decorate returnCodeString"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="01b6c3e63321ac7c7af6eceb919864c8294945e5"
sourceLine="94"
summary="Output the message for usage consistently"
summaryComputed="true"
usage="__usageMessage [ returnCode ] [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__usageMessage'$'\e''[0m '$'\e''[[(blue)]m[ returnCode ]'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mreturnCode   '$'\e''[[(value)]mUnsignedInteger. Optional. Exit code to possibly display with message.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mString. Optional. Display this message which describes why '$'\e''[[(code)]mexitCode'$'\e''[[(reset)]m occurred.'$'\e''[[(reset)]m'$'\n'''$'\n''Output the message for usage consistently'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __usageMessage [ returnCode ] [ message ... ]'$'\n'''$'\n''    returnCode   UnsignedInteger. Optional. Exit code to possibly display with message.'$'\n''    message ...  String. Optional. Display this message which describes why exitCode occurred.'$'\n'''$'\n''Output the message for usage consistently'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/internal.md"
