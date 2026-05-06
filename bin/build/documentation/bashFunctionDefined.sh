#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="functionName - String. Required. Name of function to check."$'\n'"file ... - File. Required. One or more files to check if a function is defined within."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is a function defined in a bash source file?"
descriptionLineCount=""
file="bin/build/tools/bash.sh"
fn="bashFunctionDefined"
fnMarker="bashfunctiondefined"
foundNames=([0]="summary" [1]="argument")
line="257"
rawComment="Summary: Is a function defined in a bash source file?"$'\n'"Argument: functionName - String. Required. Name of function to check."$'\n'"Argument: file ... - File. Required. One or more files to check if a function is defined within."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="257"
summary="Is a function defined in a bash source file?"
summaryComputed=""
usage="bashFunctionDefined functionName file ... [ --help ]"
