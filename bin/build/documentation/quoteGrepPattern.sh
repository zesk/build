#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'text - EmptyString. Required. Text to quote.\n'
base="quote.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Quote grep -e patterns for shell use\n\nWithout arguments, displays help.\n\n'
descriptionLineCount="4"
example=$'    grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"\n'
file="bin/build/tools/quote.sh"
fn="quoteGrepPattern"
fnMarker="quotegreppattern"
foundNames=([0]="quotes" [1]="argument" [2]="output" [3]="example" [4]="requires")
line="34"
output=$'string quoted and appropriate to insert in a grep search or replacement phrase\n'
quotes=$'" . [ ] | \\n with a backslash\n'
rawComment=$'Quote grep -e patterns for shell use\nQuotes: " . [ ] | \\n with a backslash\nArgument: text - EmptyString. Required. Text to quote.\nOutput: string quoted and appropriate to insert in a grep search or replacement phrase\nExample:     grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"\nRequires: printf sed\nWithout arguments, displays help.\n\n'
requires=$'printf sed\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/quote.sh"
sourceHash="3c095cfee529b43ebd935ef3549c279a5af1427c"
sourceLine="34"
summary="Quote grep -e patterns for shell use"
summaryComputed="true"
usage="quoteGrepPattern text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mquoteGrepPattern'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtext  '$'\e''[[(value)]mEmptyString. Required. Text to quote.'$'\e''[[(reset)]m'$'\n'''$'\n''Quote grep -e patterns for shell use'$'\n'''$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"'
# shellcheck disable=SC2016
helpPlain='Usage: quoteGrepPattern text'$'\n'''$'\n''    text  EmptyString. Required. Text to quote.'$'\n'''$'\n''Quote grep -e patterns for shell use'$'\n'''$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"'
documentationPath="documentation/source/tools/quote.md"
