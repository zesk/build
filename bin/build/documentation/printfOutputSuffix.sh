#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'... - Arguments. Required. printf arguments.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Pipe to output some text after any output, otherwise, nothing is output.\nWithout arguments, displays help.\n\n'
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="printfOutputSuffix"
fnMarker="printfoutputsuffix"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="1185"
rawComment=$'Pipe to output some text after any output, otherwise, nothing is output.\nArgument: ... - Arguments. Required. printf arguments.\nWithout arguments, displays help.\nstdin: text (Optional)\nstdout: stdin text and then printf output IFF stdin text is non-blank\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="6d769d6727070a6dc8632961d7250fe1f73eea0f"
sourceLine="1185"
stdin=$'text (Optional)\n'
stdout=$'stdin text and then printf output IFF stdin text is non-blank\n'
summary="Pipe to output some text after any output, otherwise, nothing"
summaryComputed="true"
usage="printfOutputSuffix ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mprintfOutputSuffix'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]m...  '$'\e''[[(value)]mArguments. Required. printf arguments.'$'\e''[[(reset)]m'$'\n'''$'\n''Pipe to output some text after any output, otherwise, nothing is output.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text (Optional)'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''stdin text and then printf output IFF stdin text is non-blank'
# shellcheck disable=SC2016
helpPlain='Usage: printfOutputSuffix ...'$'\n'''$'\n''    ...  Arguments. Required. printf arguments.'$'\n'''$'\n''Pipe to output some text after any output, otherwise, nothing is output.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text (Optional)'$'\n'''$'\n''Writes to stdout:'$'\n''stdin text and then printf output IFF stdin text is non-blank'
documentationPath="documentation/source/tools/text.md"
