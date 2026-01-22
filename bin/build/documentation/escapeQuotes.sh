#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="text - Text to quote"$'\n'""
base="text.sh"
description="Quote strings for inclusion in shell quoted strings"$'\n'"Without arguments, displays help."$'\n'""
example="    escapeQuotes \"Now I can't not include this in a bash string.\""$'\n'""
file="bin/build/tools/text.sh"
fn="escapeQuotes"
foundNames=""
output="Single quotes are prefixed with a backslash"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdout="The input text properly quoted"$'\n'""
summary="Quote strings for inclusion in shell quoted strings"
usage="escapeQuotes [ text ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mescapeQuotes[0m [94m[ text ][0m

    [94mtext  [1;97mText to quote[0m

Quote strings for inclusion in shell quoted strings
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
The input text properly quoted

Example:
    escapeQuotes "Now I can'\''t not include this in a bash string."
'
# shellcheck disable=SC2016
helpPlain='Usage: escapeQuotes [ text ]

    text  Text to quote

Quote strings for inclusion in shell quoted strings
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
The input text properly quoted

Example:
    escapeQuotes "Now I can'\''t not include this in a bash string."
'
