#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="text - EmptyString. Required. Text to quote."$'\n'""
base="quote.sh"
depends="sed"$'\n'""
description="Quote bash strings for inclusion as single-quoted for eval"$'\n'""
example="    name=\"\$(quoteBashString \"\$name\")\""$'\n'""
file="bin/build/tools/quote.sh"
fn="quoteBashString"
foundNames=""
name=""
output="string quoted and appropriate to assign to a value in the shell"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceModified="1769063211"
summary="Quote bash strings for inclusion as single-quoted for eval"
usage="quoteBashString text"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mquoteBashString[0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m

    [31mtext  [1;97mEmptyString. Required. Text to quote.[0m

Quote bash strings for inclusion as single-quoted for eval

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    name="$(quoteBashString "$name")"
'
# shellcheck disable=SC2016
helpPlain='Usage: quoteBashString text

    text  EmptyString. Required. Text to quote.

Quote bash strings for inclusion as single-quoted for eval

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    name="$(quoteBashString "$name")"
'
