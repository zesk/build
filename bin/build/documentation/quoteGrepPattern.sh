#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="text - EmptyString. Required. Text to quote."$'\n'""
base="quote.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Quote grep -e patterns for shell use"$'\n'""$'\n'"Without arguments, displays help."$'\n'""$'\n'""
descriptionLineCount="4"
example="    grep -e \"\$(quoteGrepPattern \"\$pattern\")\" < \"\$filterFile\""$'\n'""
file="bin/build/tools/quote.sh"
fn="quoteGrepPattern"
fnMarker="quotegreppattern"
foundNames=([0]="quotes" [1]="argument" [2]="output" [3]="example" [4]="requires")
line="34"
output="string quoted and appropriate to insert in a grep search or replacement phrase"$'\n'""
quotes="\" . [ ] | \\n with a backslash"$'\n'""
rawComment="Quote grep -e patterns for shell use"$'\n'"Quotes: \" . [ ] | \\n with a backslash"$'\n'"Argument: text - EmptyString. Required. Text to quote."$'\n'"Output: string quoted and appropriate to insert in a grep search or replacement phrase"$'\n'"Example:     grep -e \"\$(quoteGrepPattern \"\$pattern\")\" < \"\$filterFile\""$'\n'"Requires: printf sed"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
requires="printf sed"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceHash="3c095cfee529b43ebd935ef3549c279a5af1427c"
sourceLine="34"
summary="Quote grep -e patterns for shell use"
summaryComputed="true"
usage="quoteGrepPattern text"
