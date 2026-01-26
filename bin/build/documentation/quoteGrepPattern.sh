#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="text - EmptyString. Required. Text to quote."$'\n'""
base="quote.sh"
description="Quote grep -e patterns for shell use"$'\n'"Without arguments, displays help."$'\n'""
example="    grep -e \"\$(quoteGrepPattern \"\$pattern\")\" < \"\$filterFile\""$'\n'""
file="bin/build/tools/quote.sh"
foundNames=([0]="quotes" [1]="argument" [2]="output" [3]="example" [4]="requires")
output="string quoted and appropriate to insert in a grep search or replacement phrase"$'\n'""
quotes="\" . [ ] | \\n with a backslash"$'\n'""
rawComment="Quote grep -e patterns for shell use"$'\n'"Quotes: \" . [ ] | \\n with a backslash"$'\n'"Argument: text - EmptyString. Required. Text to quote."$'\n'"Output: string quoted and appropriate to insert in a grep search or replacement phrase"$'\n'"Example:     grep -e \"\$(quoteGrepPattern \"\$pattern\")\" < \"\$filterFile\""$'\n'"Requires: printf sed"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
requires="printf sed"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceModified="1769063211"
summary="Quote grep -e patterns for shell use"
usage="quoteGrepPattern text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mquoteGrepPattern'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mtext  '$'\e''[[(value)]mEmptyString. Required. Text to quote.'$'\e''[[(reset)]m'$'\n'''$'\n''Quote grep -e patterns for shell use'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: quoteGrepPattern text'$'\n'''$'\n''    text  EmptyString. Required. Text to quote.'$'\n'''$'\n''Quote grep -e patterns for shell use'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"'$'\n'''
# elapsed 0.576
