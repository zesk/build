#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'... - Arguments. Required. printf arguments.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Pipes all input to output, if any input exists behaves like `cat`. If input is empty then runs and outputs the `printf` statement result.\nWithout arguments, displays help.\n\n'
descriptionLineCount="3"
example=$'    cat "$failedFunctions" | decorate wrap -- "- " | printfOutputEmpty "%s\\n" "No functions failed."\n'
file="bin/build/tools/text.sh"
fn="printfOutputEmpty"
fnMarker="printfoutputempty"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="stdout" [4]="example")
line="1148"
rawComment=$'Summary: printf when output is blank\nPipes all input to output, if any input exists behaves like `cat`. If input is empty then runs and outputs the `printf` statement result.\nArgument: ... - Arguments. Required. printf arguments.\nWithout arguments, displays help.\nstdin: text (Optional)\nstdout: printf output and then the stdin text IFF stdin text is blank\nExample:     cat "$failedFunctions" | decorate wrap -- "- " | {fn} "%s\\n" "No functions failed."\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="1148"
stdin=$'text (Optional)\n'
stdout=$'printf output and then the stdin text IFF stdin text is blank\n'
summary="printf when output is blank"
summaryComputed=""
usage="printfOutputEmpty ..."
