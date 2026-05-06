#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="string - String. Optional. String to convert to a bash-compatible string."$'\n'""
base="quote.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Converts strings to shell escaped strings"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/quote.sh"
fn="escapeBash"
fnMarker="escapebash"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="84"
rawComment="Converts strings to shell escaped strings"$'\n'"Argument: string - String. Optional. String to convert to a bash-compatible string."$'\n'"stdin: text - Optional."$'\n'"stdout: bash-compatible string"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceHash="3c095cfee529b43ebd935ef3549c279a5af1427c"
sourceLine="84"
stdin="text - Optional."$'\n'""
stdout="bash-compatible string"$'\n'""
summary="Converts strings to shell escaped strings"
summaryComputed="true"
usage="escapeBash [ string ]"
