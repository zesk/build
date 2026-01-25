#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="... - Arguments. Required. printf arguments."$'\n'""
base="text.sh"
description="Pipe to output some text before any output, otherwise, nothing is output."$'\n'"Without arguments, displays help."$'\n'""
exitCode="0"
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Pipe to output some text before any output, otherwise, nothing is output."$'\n'"Argument: ... - Arguments. Required. printf arguments."$'\n'"Without arguments, displays help."$'\n'"stdin: text (Optional)"$'\n'"stdout: printf output and then the stdin text IFF stdin text is non-blank"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1769320918"
stdin="text (Optional)"$'\n'""
stdout="printf output and then the stdin text IFF stdin text is non-blank"$'\n'""
summary="Pipe to output some text before any output, otherwise, nothing"
usage="printfOutputPrefix ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mprintfOutputPrefix'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]m...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]m...  '$'\e''[[value]mArguments. Required. printf arguments.'$'\e''[[reset]m'$'\n'''$'\n''Pipe to output some text before any output, otherwise, nothing is output.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''text (Optional)'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''printf output and then the stdin text IFF stdin text is non-blank'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: printfOutputPrefix ...'$'\n'''$'\n''    ...  Arguments. Required. printf arguments.'$'\n'''$'\n''Pipe to output some text before any output, otherwise, nothing is output.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text (Optional)'$'\n'''$'\n''Writes to stdout:'$'\n''printf output and then the stdin text IFF stdin text is non-blank'$'\n'''
