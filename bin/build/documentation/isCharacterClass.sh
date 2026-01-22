#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/character.sh"
argument="className - String. Required. Class to check."$'\n'"character ... - String. Optional. Characters to test."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
description="Poor-man's bash character class matching"$'\n'""$'\n'"Returns true if all \`characters\` are of \`className\`"$'\n'""$'\n'"\`className\` can be one of:"$'\n'"    alnum   alpha   ascii   blank   cntrl   digit   graph   lower"$'\n'"    print   punct   space   upper   word    xdigit"$'\n'""$'\n'""
file="bin/build/tools/character.sh"
fn="isCharacterClass"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceModified="1768721469"
summary="Poor-man's bash character class matching"
usage="isCharacterClass className [ character ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255misCharacterClass[0m [38;2;255;255;0m[35;48;2;0;0;0mclassName[0m[0m [94m[ character ... ][0m [94m[ --help ][0m

    [31mclassName      [1;97mString. Required. Class to check.[0m
    [94mcharacter ...  [1;97mString. Optional. Characters to test.[0m
    [94m--help         [1;97mFlag. Optional. Display this help.[0m

Poor-man'\''s bash character class matching

Returns true if all [38;2;0;255;0;48;2;0;0;0mcharacters[0m are of [38;2;0;255;0;48;2;0;0;0mclassName[0m

[38;2;0;255;0;48;2;0;0;0mclassName[0m can be one of:
    alnum   alpha   ascii   blank   cntrl   digit   graph   lower
    print   punct   space   upper   word    xdigit

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: isCharacterClass className [ character ... ] [ --help ]

    className      String. Required. Class to check.
    character ...  String. Optional. Characters to test.
    --help         Flag. Optional. Display this help.

Poor-man'\''s bash character class matching

Returns true if all characters are of className

className can be one of:
    alnum   alpha   ascii   blank   cntrl   digit   graph   lower
    print   punct   space   upper   word    xdigit

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
