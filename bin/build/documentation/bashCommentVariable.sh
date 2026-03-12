#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="variableName - String. Required. Get this variable value."$'\n'"--prefix - Flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"--insensitive | -i - Flag. Optional. Match case insensitive."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Gets a list of the variable values from a bash function comment"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashCommentVariable"
foundNames=([0]="argument" [1]="stdin")
rawComment="Gets a list of the variable values from a bash function comment"$'\n'"Argument: variableName - String. Required. Get this variable value."$'\n'"stdin: Comment source (\`# \` removed)"$'\n'"Argument: --prefix - Flag. Optional. Find variables with the prefix \`variableName\`"$'\n'"Argument: --insensitive | -i - Flag. Optional. Match case insensitive."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
stdin="Comment source (\`# \` removed)"$'\n'""
summary="Gets a list of the variable values from a bash"
summaryComputed="true"
usage="bashCommentVariable variableName [ --prefix ] [ --insensitive | -i ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
