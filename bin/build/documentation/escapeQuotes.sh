#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'text - Text to quote\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Quote strings for inclusion in shell quoted strings\nWithout arguments, displays help.\n\n'
descriptionLineCount="3"
example=$'    escapeQuotes "Now I can\'t not include this in a bash string."\n'
file="bin/build/tools/text.sh"
fn="escapeQuotes"
fnMarker="escapequotes"
foundNames=([0]="argument" [1]="output" [2]="example" [3]="stdout")
line="199"
output=$'Single quotes are prefixed with a backslash\n'
rawComment=$'Quote strings for inclusion in shell quoted strings\nArgument: text - Text to quote\nOutput: Single quotes are prefixed with a backslash\nExample:     {fn} "Now I can\'t not include this in a bash string."\nWithout arguments, displays help.\nstdout: The input text properly quoted\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="199"
stdout=$'The input text properly quoted\n'
summary="Quote strings for inclusion in shell quoted strings"
summaryComputed="true"
usage="escapeQuotes [ text ]"
