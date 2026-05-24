#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'... - Arguments. Required. printf arguments.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Pipe to output some text before any output, otherwise, nothing is output.\nWithout arguments, displays help.\n\n'
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="printfOutputPrefix"
fnMarker="printfoutputprefix"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="1164"
rawComment=$'Pipe to output some text before any output, otherwise, nothing is output.\nArgument: ... - Arguments. Required. printf arguments.\nWithout arguments, displays help.\nstdin: text (Optional)\nstdout: printf output and then the stdin text IFF stdin text is non-blank\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="1164"
stdin=$'text (Optional)\n'
stdout=$'printf output and then the stdin text IFF stdin text is non-blank\n'
summary="Pipe to output some text before any output, otherwise, nothing"
summaryComputed="true"
usage="printfOutputPrefix ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mprintfOutputPrefix'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]m...  '$'\e''[[(value)]mArguments. Required. printf arguments.'$'\e''[[(reset)]m'$'\n'''$'\n''Pipe to output some text before any output, otherwise, nothing is output.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text (Optional)'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''printf output and then the stdin text IFF stdin text is non-blank'
# shellcheck disable=SC2016
helpPlain='Usage: printfOutputPrefix ...'$'\n'''$'\n''    ...  Arguments. Required. printf arguments.'$'\n'''$'\n''Pipe to output some text before any output, otherwise, nothing is output.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text (Optional)'$'\n'''$'\n''Writes to stdout:'$'\n''printf output and then the stdin text IFF stdin text is non-blank'
documentationPath="documentation/source/tools/text.md"
