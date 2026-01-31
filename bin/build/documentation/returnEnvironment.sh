#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="message ... - String. Optional. Message to output."$'\n'""
base="_sugar.sh"
description="Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`."$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
rawComment="Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`."$'\n'"Argument: message ... - String. Optional. Message to output."$'\n'"Return Code: 1"$'\n'"Requires: returnMessage"$'\n'""$'\n'""
requires="returnMessage"$'\n'""
return_code="1"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="4bce6d8a22071b1c44a64aadb33672fc47a840f1"
summary="Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`."
summaryComputed="true"
usage="returnEnvironment [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mString. Optional. Message to output.'$'\e''[[(reset)]m'$'\n'''$'\n''Return '$'\e''[[(code)]menvironment'$'\e''[[(reset)]m error code. Outputs '$'\e''[[(code)]mmessage ...'$'\e''[[(reset)]m to '$'\e''[[(code)]mstderr'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- 1'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: returnEnvironment [ message ... ]'$'\n'''$'\n''    message ...  String. Optional. Message to output.'$'\n'''$'\n''Return environment error code. Outputs message ... to stderr.'$'\n'''$'\n''Return codes:'$'\n''- 1'$'\n'''
