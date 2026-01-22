#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"characterWidth - Characters to align left"$'\n'"text ... - Text to align left"$'\n'""
base="decoration.sh"
description="Format text and align it left using spaces."$'\n'""$'\n'""$'\n'""
example="    printf \"%s: %s\\n\" \"\$(alignLeft 14 Name)\" \"\$name\""$'\n'"    printf \"%s: %s\\n\" \"\$(alignLeft 14 Profession)\" \"\$occupation\""$'\n'"    Name          : Tyrone"$'\n'"    Profession    : Engineer"$'\n'""
file="bin/build/tools/decoration.sh"
fn="alignLeft"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decoration.sh"
sourceModified="1768721469"
summary="align text left"$'\n'""
usage="alignLeft [ --help ] [ characterWidth ] [ text ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255malignLeft[0m [94m[ --help ][0m [94m[ characterWidth ][0m [94m[ text ... ][0m

    [94m--help          [1;97mFlag. Optional. Display this help.[0m
    [94mcharacterWidth  [1;97mCharacters to align left[0m
    [94mtext ...        [1;97mText to align left[0m

Format text and align it left using spaces.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    printf "%s: %s\n" "$(alignLeft 14 Name)" "$name"
    printf "%s: %s\n" "$(alignLeft 14 Profession)" "$occupation"
    Name          : Tyrone
    Profession    : Engineer
'
# shellcheck disable=SC2016
helpPlain='Usage: alignLeft [ --help ] [ characterWidth ] [ text ... ]

    --help          Flag. Optional. Display this help.
    characterWidth  Characters to align left
    text ...        Text to align left

Format text and align it left using spaces.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    printf "%s: %s\n" "$(alignLeft 14 Name)" "$name"
    printf "%s: %s\n" "$(alignLeft 14 Profession)" "$occupation"
    Name          : Tyrone
    Profession    : Engineer
'
