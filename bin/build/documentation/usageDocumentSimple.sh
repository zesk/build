#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/usage.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"source - File. Required. File where documentation exists."$'\n'"function - String. Required. Function to document."$'\n'"returnCode - UnsignedInteger. Required. Exit code to return."$'\n'"message ... - String. Optional. Message to display to the user."$'\n'""
base="usage.sh"
description="Output a simple error message for a function"$'\n'""
exitCode="0"
file="bin/build/tools/usage.sh"
foundNames=([0]="argument" [1]="requires")
rawComment="Output a simple error message for a function"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: source - File. Required. File where documentation exists."$'\n'"Argument: function - String. Required. Function to document."$'\n'"Argument: returnCode - UnsignedInteger. Required. Exit code to return."$'\n'"Argument: message ... - String. Optional. Message to display to the user."$'\n'"Requires: bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached"$'\n'""$'\n'""
requires="bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769216318"
summary="Output a simple error message for a function"
usage="usageDocumentSimple [ --help ] source function returnCode [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]musageDocumentSimple'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]msource'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mfunction'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mreturnCode'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help       '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]msource       '$'\e''[[value]mFile. Required. File where documentation exists.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mfunction     '$'\e''[[value]mString. Required. Function to document.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mreturnCode   '$'\e''[[value]mUnsignedInteger. Required. Exit code to return.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mmessage ...  '$'\e''[[value]mString. Optional. Message to display to the user.'$'\e''[[reset]m'$'\n'''$'\n''Output a simple error message for a function'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: usageDocumentSimple [ --help ] source function returnCode [ message ... ]'$'\n'''$'\n''    --help       Flag. Optional. Display this help.'$'\n''    source       File. Required. File where documentation exists.'$'\n''    function     String. Required. Function to document.'$'\n''    returnCode   UnsignedInteger. Required. Exit code to return.'$'\n''    message ...  String. Optional. Message to display to the user.'$'\n'''$'\n''Output a simple error message for a function'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
