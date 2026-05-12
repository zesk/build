#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="... - Arguments. Required. printf arguments."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Pipe to output some text before any output, otherwise, nothing is output."$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="printfOutputPrefix"
fnMarker="printfoutputprefix"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="1164"
rawComment="Pipe to output some text before any output, otherwise, nothing is output."$'\n'"Argument: ... - Arguments. Required. printf arguments."$'\n'"Without arguments, displays help."$'\n'"stdin: text (Optional)"$'\n'"stdout: printf output and then the stdin text IFF stdin text is non-blank"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="1164"
stdin="text (Optional)"$'\n'""
stdout="printf output and then the stdin text IFF stdin text is non-blank"$'\n'""
summary="Pipe to output some text before any output, otherwise, nothing"
summaryComputed="true"
usage="printfOutputPrefix ..."
