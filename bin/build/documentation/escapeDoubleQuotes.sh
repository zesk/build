#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="text - String. Optional. Text to quote"$'\n'""
base="quote.sh"
description="Quote strings for inclusion in shell quoted strings"$'\n'"Without arguments, displays help."$'\n'""
example="    escapeDoubleQuotes \"Now I can't not include this in a bash string.\""$'\n'""
file="bin/build/tools/quote.sh"
fn="escapeDoubleQuotes"
foundNames=""
output="Single quotes are prefixed with a backslash"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceModified="1769059755"
summary="Quote strings for inclusion in shell quoted strings"
usage="escapeDoubleQuotes [ text ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mescapeDoubleQuotes[0m [94m[ text ][0m

    [94mtext  [1;97mString. Optional. Text to quote[0m

Quote strings for inclusion in shell quoted strings
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    escapeDoubleQuotes "Now I can'\''t not include this in a bash string."
'
# shellcheck disable=SC2016
helpPlain='Usage: escapeDoubleQuotes [ text ]

    text  String. Optional. Text to quote

Quote strings for inclusion in shell quoted strings
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    escapeDoubleQuotes "Now I can'\''t not include this in a bash string."
'
