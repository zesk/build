#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="message ... - String. Optional. Message to output."$'\n'""
base="_sugar.sh"
description="Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`."$'\n'""
file="bin/build/tools/_sugar.sh"
fn="returnArgument"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="256"
lowerFn="returnargument"
rawComment="Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`."$'\n'"Argument: message ... - String. Optional. Message to output."$'\n'"Return Code: 2"$'\n'"Requires: returnMessage"$'\n'""$'\n'""
requires="returnMessage"$'\n'""
return_code="2"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="1cf1ee5794e801d06a483b8f311df83c051c18a0"
sourceLine="256"
summary="Return \`argument\` error code. Outputs \`message ...\` to \`stderr\`."
summaryComputed="true"
usage="returnArgument [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnArgument'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mString. Optional. Message to output.'$'\e''[[(reset)]m'$'\n'''$'\n''Return '$'\e''[[(code)]margument'$'\e''[[(reset)]m error code. Outputs '$'\e''[[(code)]mmessage ...'$'\e''[[(reset)]m to '$'\e''[[(code)]mstderr'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- 2'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: returnArgument [ message ... ]'$'\n'''$'\n''    message ...  String. Optional. Message to output.'$'\n'''$'\n''Return argument error code. Outputs message ... to stderr.'$'\n'''$'\n''Return codes:'$'\n''- 2'$'\n'''
documentationPath="documentation/source/tools/sugar-core.md"
