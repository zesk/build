#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="usage.sh"
description="Output a simple error message for a function"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: source - File. Required. File where documentation exists."$'\n'"Argument: function - String. Required. Function to document."$'\n'"Argument: returnCode - UnsignedInteger. Required. Exit code to return."$'\n'"Argument: message ... - String. Optional. Message to display to the user."$'\n'"Requires: bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached"$'\n'""
file="bin/build/tools/usage.sh"
foundNames=()
rawComment="Output a simple error message for a function"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: source - File. Required. File where documentation exists."$'\n'"Argument: function - String. Required. Function to document."$'\n'"Argument: returnCode - UnsignedInteger. Required. Exit code to return."$'\n'"Argument: message ... - String. Optional. Message to display to the user."$'\n'"Requires: bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="ac3427c7ff1c70c560bb4ac0c164fb1f45f71bc5"
summary="Output a simple error message for a function"
usage="usageDocumentSimple"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]musageDocumentSimple'$'\e''[0m'$'\n'''$'\n''Output a simple error message for a function'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: source - File. Required. File where documentation exists.'$'\n''Argument: function - String. Required. Function to document.'$'\n''Argument: returnCode - UnsignedInteger. Required. Exit code to return.'$'\n''Argument: message ... - String. Optional. Message to display to the user.'$'\n''Requires: bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: usageDocumentSimple'$'\n'''$'\n''Output a simple error message for a function'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: source - File. Required. File where documentation exists.'$'\n''Argument: function - String. Required. Function to document.'$'\n''Argument: returnCode - UnsignedInteger. Required. Exit code to return.'$'\n''Argument: message ... - String. Optional. Message to display to the user.'$'\n''Requires: bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.442
