#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/character.sh"
argument="character - Required. Single character to test."$'\n'"class ... - String. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any)."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
description="Does this character match one or more character classes?"$'\n'""$'\n'""
file="bin/build/tools/character.sh"
fn="isCharacterClasses"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceModified="1769063211"
summary="Does this character match one or more character classes?"
usage="isCharacterClasses character [ class ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misCharacterClasses[0m [38;2;255;255;0m[35;48;2;0;0;0mcharacter[0m[0m [94m[ class ... ][0m [94m[ --help ][0m

    [31mcharacter  [1;97mRequired. Single character to test.[0m
    [94mclass ...  [1;97mString. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Does this character match one or more character classes?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isCharacterClasses character [ class ... ] [ --help ]

    character  Required. Single character to test.
    class ...  String. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).
    --help     Flag. Optional. Display this help.

Does this character match one or more character classes?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
