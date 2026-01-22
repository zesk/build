#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sed.sh"
argument="text - EmptyString. Required. Text to quote"$'\n'""
base="sed.sh"
description="Quote a string to be used in a sed pattern on the command line."$'\n'""
example="    sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedPattern \"\$2\")/g\""$'\n'"    needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'""
file="bin/build/tools/sed.sh"
fn="quoteSedPattern"
foundNames=""
needSlash=""
output="string quoted and appropriate to insert in a sed search or replacement phrase"$'\n'""
requires="printf sed usageDocument __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sed.sh"
sourceModified="1768683999"
summary="Quote sed search strings for shell use"$'\n'""
usage="quoteSedPattern text"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mquoteSedPattern[0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m

    [31mtext  [1;97mEmptyString. Required. Text to quote[0m

Quote a string to be used in a sed pattern on the command line.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
    needSlash=$(quoteSedPattern '\''$.[36m/[\]^'\'')[0m
'
# shellcheck disable=SC2016
helpPlain='Usage: quoteSedPattern text

    text  EmptyString. Required. Text to quote

Quote a string to be used in a sed pattern on the command line.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
    needSlash=$(quoteSedPattern '\''$./[\]^'\'')
'
