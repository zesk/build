#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="source - File. Required. File where the function is defined."$'\n'"functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"variableName - string. Required. Get this variable value"$'\n'"--prefix - flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Gets a list of the variable values from a bash function comment"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFunctionCommentVariable"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1768776883"
summary="Gets a list of the variable values from a bash"
usage="bashFunctionCommentVariable source functionName variableName [ --prefix ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashFunctionCommentVariable[0m [38;2;255;255;0m[35;48;2;0;0;0msource[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfunctionName[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mvariableName[0m[0m [94m[ --prefix ][0m [94m[ --help ][0m

    [31msource        [1;97mFile. Required. File where the function is defined.[0m
    [31mfunctionName  [1;97mString. Required. The name of the bash function to extract the documentation for.[0m
    [31mvariableName  [1;97mstring. Required. Get this variable value[0m
    [94m--prefix      [1;97mflag. Optional. Find variables with the prefix [38;2;0;255;0;48;2;0;0;0mvariableName[0m[0m
    [94m--help        [1;97mFlag. Optional. Display this help.[0m

Gets a list of the variable values from a bash function comment

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashFunctionCommentVariable source functionName variableName [ --prefix ] [ --help ]

    source        File. Required. File where the function is defined.
    functionName  String. Required. The name of the bash function to extract the documentation for.
    variableName  string. Required. Get this variable value
    --prefix      flag. Optional. Find variables with the prefix variableName
    --help        Flag. Optional. Display this help.

Gets a list of the variable values from a bash function comment

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
