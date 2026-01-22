#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/character.sh"
argument="text - Text to validate"$'\n'"class0 ... - One or more character classes that the characters in string should match"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
description="Ensure that every character in a text string passes all character class tests"$'\n'""
file="bin/build/tools/character.sh"
fn="stringValidate"
foundNames=""
note="This is slow."$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceModified="1769063211"
summary="Ensure that every character in a text string passes all"
usage="stringValidate [ text ] [ class0 ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mstringValidate[0m [94m[ text ][0m [94m[ class0 ... ][0m [94m[ --help ][0m

    [94mtext        [1;97mText to validate[0m
    [94mclass0 ...  [1;97mOne or more character classes that the characters in string should match[0m
    [94m--help      [1;97mFlag. Optional. Display this help.[0m

Ensure that every character in a text string passes all character class tests

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: stringValidate [ text ] [ class0 ... ] [ --help ]

    text        Text to validate
    class0 ...  One or more character classes that the characters in string should match
    --help      Flag. Optional. Display this help.

Ensure that every character in a text string passes all character class tests

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
