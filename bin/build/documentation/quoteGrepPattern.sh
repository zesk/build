#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="quote.sh"
description="Quote grep -e patterns for shell use"$'\n'"Quotes: \" . [ ] | \\n with a backslash"$'\n'"Argument: text - EmptyString. Required. Text to quote."$'\n'"Output: string quoted and appropriate to insert in a grep search or replacement phrase"$'\n'"Example:     grep -e \"\$(quoteGrepPattern \"\$pattern\")\" < \"\$filterFile\""$'\n'"Requires: printf sed"$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/quote.sh"
foundNames=()
rawComment="Quote grep -e patterns for shell use"$'\n'"Quotes: \" . [ ] | \\n with a backslash"$'\n'"Argument: text - EmptyString. Required. Text to quote."$'\n'"Output: string quoted and appropriate to insert in a grep search or replacement phrase"$'\n'"Example:     grep -e \"\$(quoteGrepPattern \"\$pattern\")\" < \"\$filterFile\""$'\n'"Requires: printf sed"$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceHash="4a4dd20eec875783f639ec3aa86d72a8482d5ab0"
summary="Quote grep -e patterns for shell use"
usage="quoteGrepPattern"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mquoteGrepPattern'$'\e''[0m'$'\n'''$'\n''Quote grep -e patterns for shell use'$'\n''Quotes: " . [ ] | \n with a backslash'$'\n''Argument: text - EmptyString. Required. Text to quote.'$'\n''Output: string quoted and appropriate to insert in a grep search or replacement phrase'$'\n''Example:     grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"'$'\n''Requires: printf sed'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: quoteGrepPattern'$'\n'''$'\n''Quote grep -e patterns for shell use'$'\n''Quotes: " . [ ] | \n with a backslash'$'\n''Argument: text - EmptyString. Required. Text to quote.'$'\n''Output: string quoted and appropriate to insert in a grep search or replacement phrase'$'\n''Example:     grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"'$'\n''Requires: printf sed'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.478
