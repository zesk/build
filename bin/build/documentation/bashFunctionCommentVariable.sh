#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="source - File. Required. File where the function is defined."$'\n'"functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"variableName - string. Required. Get this variable value"$'\n'"--prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"--i | --insensitive - Flag. Optional. Case-insensitive match."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Gets a list of the variable values from a bash function comment"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFunctionCommentVariable"
foundNames=([0]="argument")
rawComment="Argument: source - File. Required. File where the function is defined."$'\n'"Argument: functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"Argument: variableName - string. Required. Get this variable value"$'\n'"Argument: --prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"Argument: --i | --insensitive - Flag. Optional. Case-insensitive match."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Gets a list of the variable values from a bash function comment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
summary="Gets a list of the variable values from a bash"
summaryComputed="true"
usage="bashFunctionCommentVariable source functionName variableName [ --prefix ] [ --i | --insensitive ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
