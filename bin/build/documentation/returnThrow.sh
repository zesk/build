#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="returnCode - Integer. Required. Return code."$'\n'"handler - Function. Required. Error handler."$'\n'"message ... - String. Optional. Error message"$'\n'""
base="_sugar.sh"
description="Run \`handler\` with a passed return code"$'\n'""
file="bin/build/tools/_sugar.sh"
fn="returnThrow"
foundNames=([0]="argument" [1]="requires")
line="273"
lowerFn="returnthrow"
rawComment="Run \`handler\` with a passed return code"$'\n'"Argument: returnCode - Integer. Required. Return code."$'\n'"Argument: handler - Function. Required. Error handler."$'\n'"Argument: message ... - String. Optional. Error message"$'\n'"Requires: returnArgument"$'\n'""$'\n'""
requires="returnArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="1cf1ee5794e801d06a483b8f311df83c051c18a0"
sourceLine="273"
summary="Run \`handler\` with a passed return code"
summaryComputed="true"
usage="returnThrow returnCode handler [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnThrow'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mreturnCode'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mhandler'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mreturnCode   '$'\e''[[(value)]mInteger. Required. Return code.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mhandler      '$'\e''[[(value)]mFunction. Required. Error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mString. Optional. Error message'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m with a passed return code'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: returnThrow returnCode handler [ message ... ]'$'\n'''$'\n''    returnCode   Integer. Required. Return code.'$'\n''    handler      Function. Required. Error handler.'$'\n''    message ...  String. Optional. Error message'$'\n'''$'\n''Run handler with a passed return code'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/sugar-core.md"
