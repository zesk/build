#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="source - File. Required. File where the function is defined."$'\n'"functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashFunctionComment"
fnMarker="bashfunctioncomment"
foundNames=([0]="argument" [1]="requires")
line="619"
rawComment="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'"Argument: source - File. Required. File where the function is defined."$'\n'"Argument: functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: grep cut fileReverseLines helpArgument"$'\n'"Requires: bashDocumentation"$'\n'""$'\n'""
requires="grep cut fileReverseLines helpArgument"$'\n'"bashDocumentation"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="619"
summary="Extract a bash comment from a file. Excludes lines containing"
summaryComputed="true"
usage="bashFunctionComment source functionName [ --help ]"
