#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="text - String. Optional. Text to quote"$'\n'""
base="quote.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Quote strings for inclusion in shell quoted strings"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="3"
example="    escapeDoubleQuotes \"Now I can't not include this in a bash string.\""$'\n'""
file="bin/build/tools/quote.sh"
fn="escapeDoubleQuotes"
fnMarker="escapedoublequotes"
foundNames=([0]="argument" [1]="output" [2]="example")
line="66"
output="Single quotes are prefixed with a backslash"$'\n'""
rawComment="Quote strings for inclusion in shell quoted strings"$'\n'"Argument: text - String. Optional. Text to quote"$'\n'"Output: Single quotes are prefixed with a backslash"$'\n'"Example:     {fn} \"Now I can't not include this in a bash string.\""$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceHash="3c095cfee529b43ebd935ef3549c279a5af1427c"
sourceLine="66"
summary="Quote strings for inclusion in shell quoted strings"
summaryComputed="true"
usage="escapeDoubleQuotes [ text ]"
