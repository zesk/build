#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="characterWidth - Characters to align right"$'\n'"text ... - Text to align right"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
description="Format text and align it right using spaces."$'\n'""
example="    printf \"%s: %s\\n\" \"\$(textAlignRight 20 Name)\" \"\$name\""$'\n'"    printf \"%s: %s\\n\" \"\$(textAlignRight 20 Profession)\" \"\$occupation\""$'\n'"                Name: Juanita"$'\n'"          Profession: Engineer"$'\n'""
file="bin/build/tools/text.sh"
fn="textAlignRight"
foundNames=([0]="summary" [1]="argument" [2]="example")
rawComment="Format text and align it right using spaces."$'\n'"Summary: align text right"$'\n'"Argument: characterWidth - Characters to align right"$'\n'"Argument: text ... - Text to align right"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignRight 20 Name)\" \"\$name\""$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignRight 20 Profession)\" \"\$occupation\""$'\n'"Example:                 Name: Juanita"$'\n'"Example:           Profession: Engineer"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="7f4afd0db4aa281d91724f7bdc480865ea6088e9"
summary="align text right"$'\n'""
usage="textAlignRight [ characterWidth ] [ text ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextAlignRight'$'\e''[0m '$'\e''[[(blue)]m[ characterWidth ]'$'\e''[0m '$'\e''[[(blue)]m[ text ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcharacterWidth  '$'\e''[[(value)]mCharacters to align right'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext ...        '$'\e''[[(value)]mText to align right'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Format text and align it right using spaces.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    printf "%s: %s\n" "$(textAlignRight 20 Name)" "$name"'$'\n''    printf "%s: %s\n" "$(textAlignRight 20 Profession)" "$occupation"'$'\n''                Name: Juanita'$'\n''          Profession: Engineer'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: textAlignRight [ characterWidth ] [ text ... ] [ --help ]'$'\n'''$'\n''    characterWidth  Characters to align right'$'\n''    text ...        Text to align right'$'\n''    --help          Flag. Optional. Display this help.'$'\n'''$'\n''Format text and align it right using spaces.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    printf "%s: %s\n" "$(textAlignRight 20 Name)" "$name"'$'\n''    printf "%s: %s\n" "$(textAlignRight 20 Profession)" "$occupation"'$'\n''                Name: Juanita'$'\n''          Profession: Engineer'$'\n'''
