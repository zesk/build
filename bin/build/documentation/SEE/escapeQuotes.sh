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
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mescapeQuotes'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtext  '$'\e''[[(value)]mText to quote'$'\e''[[(reset)]m'$'\n'''$'\n''Quote strings for inclusion in shell quoted strings'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''The input text properly quoted'$'\n'''$'\n''Example:'$'\n''    escapeQuotes "Now I can'\''t not include this in a bash string."'
# shellcheck disable=SC2016
helpPlain='Usage: escapeQuotes [ text ]'$'\n'''$'\n''    text  Text to quote'$'\n'''$'\n''Quote strings for inclusion in shell quoted strings'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''The input text properly quoted'$'\n'''$'\n''Example:'$'\n''    escapeQuotes "Now I can'\''t not include this in a bash string."'
documentationPath="documentation/source/tools/quote.md"
