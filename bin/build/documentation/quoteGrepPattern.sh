#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="text - EmptyString. Required. Text to quote."$'\n'""
base="quote.sh"
description="Quote grep -e patterns for shell use"$'\n'""$'\n'"Without arguments, displays help."$'\n'""
example="    grep -e \"\$(quoteGrepPattern \"\$pattern\")\" < \"\$filterFile\""$'\n'""
file="bin/build/tools/quote.sh"
fn="quoteGrepPattern"
foundNames=""
output="string quoted and appropriate to insert in a grep search or replacement phrase"$'\n'""
quotes="\" . [ ] | \\n with a backslash"$'\n'""
requires="printf sed"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceModified="1769063211"
summary="Quote grep -e patterns for shell use"
usage="quoteGrepPattern text"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mquoteGrepPattern[0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m

    [31mtext  [1;97mEmptyString. Required. Text to quote.[0m

Quote grep -e patterns for shell use

Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"
'
# shellcheck disable=SC2016
helpPlain='Usage: quoteGrepPattern text

    text  EmptyString. Required. Text to quote.

Quote grep -e patterns for shell use

Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"
'
