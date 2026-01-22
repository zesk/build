#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="string - String. Optional. String to convert to a bash-compatible string."$'\n'""
base="quote.sh"
description="Converts strings to shell escaped strings"$'\n'""
file="bin/build/tools/quote.sh"
fn="escapeBash"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceModified="1769059755"
stdin="text - Optional."$'\n'""
stdout="bash-compatible string"$'\n'""
summary="Converts strings to shell escaped strings"
usage="escapeBash [ string ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mescapeBash[0m [94m[ string ][0m

    [94mstring  [1;97mString. Optional. String to convert to a bash-compatible string.[0m

Converts strings to shell escaped strings

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
text - Optional.

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
bash-compatible string
'
# shellcheck disable=SC2016
helpPlain='Usage: escapeBash [ string ]

    string  String. Optional. String to convert to a bash-compatible string.

Converts strings to shell escaped strings

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
text - Optional.

Writes to stdout:
bash-compatible string
'
