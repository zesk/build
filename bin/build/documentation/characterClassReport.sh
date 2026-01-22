#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/character.sh"
argument="--class - Flag. Optional. Show class and then characters in that class."$'\n'"--char - Flag. Optional. Show characters and then class for that character."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
description="Write a report of the character classes"$'\n'""
file="bin/build/tools/character.sh"
fn="characterClassReport"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceModified="1768721469"
summary="Write a report of the character classes"
usage="characterClassReport [ --class ] [ --char ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mcharacterClassReport[0m [94m[ --class ][0m [94m[ --char ][0m [94m[ --help ][0m

    [94m--class  [1;97mFlag. Optional. Show class and then characters in that class.[0m
    [94m--char   [1;97mFlag. Optional. Show characters and then class for that character.[0m
    [94m--help   [1;97mFlag. Optional. Display this help.[0m

Write a report of the character classes

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: characterClassReport [ --class ] [ --char ] [ --help ]

    --class  Flag. Optional. Show class and then characters in that class.
    --char   Flag. Optional. Show characters and then class for that character.
    --help   Flag. Optional. Display this help.

Write a report of the character classes

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
