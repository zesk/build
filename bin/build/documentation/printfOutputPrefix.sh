#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
line="1171"
rawComment=$'Pipe to output some text before any output, otherwise, nothing is output.\nArgument: ... - Arguments. Required. printf arguments.\nWithout arguments, displays help.\nstdin: text (Optional)\nstdout: printf output and then the stdin text IFF stdin text is non-blank\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="1171"
stdin=$'text (Optional)\n'
stdout=$'printf output and then the stdin text IFF stdin text is non-blank\n'
summary="Pipe to output some text before any output, otherwise, nothing"
summaryComputed="true"
usage="printfOutputPrefix ..."
