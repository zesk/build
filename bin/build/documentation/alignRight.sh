#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="characterWidth - Characters to align right"$'\n'"text ... - Text to align right"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="decoration.sh"
description="Format text and align it right using spaces."$'\n'""$'\n'""
example="    printf \"%s: %s\\n\" \"\$(alignRight 20 Name)\" \"\$name\""$'\n'"    printf \"%s: %s\\n\" \"\$(alignRight 20 Profession)\" \"\$occupation\""$'\n'"                Name: Juanita"$'\n'"          Profession: Engineer"$'\n'""
file="bin/build/tools/decoration.sh"
fn="alignRight"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decoration.sh"
sourceModified="1769063211"
summary="align text right"$'\n'""
usage="alignRight [ characterWidth ] [ text ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255malignRight[0m [94m[ characterWidth ][0m [94m[ text ... ][0m [94m[ --help ][0m

    [94mcharacterWidth  [1;97mCharacters to align right[0m
    [94mtext ...        [1;97mText to align right[0m
    [94m--help          [1;97mFlag. Optional. Display this help.[0m

Format text and align it right using spaces.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    printf "%s: %s\n" "$(alignRight 20 Name)" "$name"
    printf "%s: %s\n" "$(alignRight 20 Profession)" "$occupation"
                Name: Juanita
          Profession: Engineer
'
# shellcheck disable=SC2016
helpPlain='Usage: alignRight [ characterWidth ] [ text ... ] [ --help ]

    characterWidth  Characters to align right
    text ...        Text to align right
    --help          Flag. Optional. Display this help.

Format text and align it right using spaces.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    printf "%s: %s\n" "$(alignRight 20 Name)" "$name"
    printf "%s: %s\n" "$(alignRight 20 Profession)" "$occupation"
                Name: Juanita
          Profession: Engineer
'
