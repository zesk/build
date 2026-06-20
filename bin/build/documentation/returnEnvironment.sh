#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'message ... - String. Optional. Message to output.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Return `environment` error code. Outputs `message ...` to `stderr`.\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="returnEnvironment"
fnMarker="returnenvironment"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="265"
original="returnEnvironment"
rawComment=$'Return `environment` error code. Outputs `message ...` to `stderr`.\nArgument: message ... - String. Optional. Message to output.\nReturn Code: 1\nRequires: returnMessage\n\n'
requires=$'returnMessage\n'
return_code=$'1\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="8d5ac9aefc03ec2923c4a48ed0d33aed85646581"
sourceLine="265"
summary="Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`."
summaryComputed="true"
usage="returnEnvironment [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mString. Optional. Message to output.'$'\e''[[(reset)]m'$'\n'''$'\n''Return '$'\e''[[(code)]menvironment'$'\e''[[(reset)]m error code. Outputs '$'\e''[[(code)]mmessage ...'$'\e''[[(reset)]m to '$'\e''[[(code)]mstderr'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- 1'
# shellcheck disable=SC2016
helpPlain='Usage: returnEnvironment [ message ... ]'$'\n'''$'\n''    message ...  String. Optional. Message to output.'$'\n'''$'\n''Return environment error code. Outputs message ... to stderr.'$'\n'''$'\n''Return codes:'$'\n''- 1'
documentationPath="documentation/source/tools/sugar-core.md"
