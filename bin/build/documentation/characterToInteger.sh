#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/character.sh"
argument="character - String. Optional. One or more characters to convert to their ASCII equivalent."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
description="Convert one or more characters from their ascii representation to an integer value."$'\n'"Requires a single character to be passed"$'\n'""
file="bin/build/tools/character.sh"
fn="characterToInteger"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceModified="1769063211"
summary="Convert a character to the corresponding ASCII code"$'\n'""
usage="characterToInteger [ character ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcharacterToInteger[0m [94m[ character ][0m [94m[ --help ][0m

    [94mcharacter  [1;97mString. Optional. One or more characters to convert to their ASCII equivalent.[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Convert one or more characters from their ascii representation to an integer value.
Requires a single character to be passed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: characterToInteger [ character ] [ --help ]

    character  String. Optional. One or more characters to convert to their ASCII equivalent.
    --help     Flag. Optional. Display this help.

Convert one or more characters from their ascii representation to an integer value.
Requires a single character to be passed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
