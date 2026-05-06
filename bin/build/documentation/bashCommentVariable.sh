#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="variableName - String. Required. Get this variable value."$'\n'"--prefix - Flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"--insensitive | -i - Flag. Optional. Match case insensitive."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Gets a list of the variable values from a bash function comment"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashCommentVariable"
fnMarker="bashcommentvariable"
foundNames=([0]="argument" [1]="stdin")
line="449"
rawComment="Gets a list of the variable values from a bash function comment"$'\n'"Argument: variableName - String. Required. Get this variable value."$'\n'"stdin: Comment source (\`# \` removed)"$'\n'"Argument: --prefix - Flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"Argument: --insensitive | -i - Flag. Optional. Match case insensitive."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="449"
stdin="Comment source (\`# \` removed)"$'\n'""
summary="Gets a list of the variable values from a bash"
summaryComputed="true"
usage="bashCommentVariable variableName [ --prefix ] [ --insensitive | -i ] [ --help ]"
