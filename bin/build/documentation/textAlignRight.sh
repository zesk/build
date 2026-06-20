#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'characterWidth - Characters to align right\ntext ... - Text to align right\n--help - Flag. Optional. Display this help.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Format text and align it right using spaces.\n\n'
descriptionLineCount="2"
example=$'    printf "%s: %s\\n" "$(textAlignRight 20 Name)" "$name"\n    printf "%s: %s\\n" "$(textAlignRight 20 Profession)" "$occupation"\n                Name: Juanita\n          Profession: Engineer\n'
file="bin/build/tools/text.sh"
fn="textAlignRight"
fnMarker="textalignright"
foundNames=([0]="summary" [1]="argument" [2]="example")
line="1257"
original="textAlignRight"
rawComment=$'Format text and align it right using spaces.\nSummary: align text right\nArgument: characterWidth - Characters to align right\nArgument: text ... - Text to align right\nArgument: --help - Flag. Optional. Display this help.\nExample:     printf "%s: %s\\n" "$(textAlignRight 20 Name)" "$name"\nExample:     printf "%s: %s\\n" "$(textAlignRight 20 Profession)" "$occupation"\nExample:                 Name: Juanita\nExample:           Profession: Engineer\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="6d769d6727070a6dc8632961d7250fe1f73eea0f"
sourceLine="1257"
summary="align text right"
summaryComputed=""
usage="textAlignRight [ characterWidth ] [ text ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextAlignRight'$'\e''[0m '$'\e''[[(blue)]m[ characterWidth ]'$'\e''[0m '$'\e''[[(blue)]m[ text ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcharacterWidth  '$'\e''[[(value)]mCharacters to align right'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext ...        '$'\e''[[(value)]mText to align right'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Format text and align it right using spaces.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    printf "%s: %s\n" "$(textAlignRight 20 Name)" "$name"'$'\n''    printf "%s: %s\n" "$(textAlignRight 20 Profession)" "$occupation"'$'\n''                Name: Juanita'$'\n''          Profession: Engineer'
# shellcheck disable=SC2016
helpPlain='Usage: textAlignRight [ characterWidth ] [ text ... ] [ --help ]'$'\n'''$'\n''    characterWidth  Characters to align right'$'\n''    text ...        Text to align right'$'\n''    --help          Flag. Optional. Display this help.'$'\n'''$'\n''Format text and align it right using spaces.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    printf "%s: %s\n" "$(textAlignRight 20 Name)" "$name"'$'\n''    printf "%s: %s\n" "$(textAlignRight 20 Profession)" "$occupation"'$'\n''                Name: Juanita'$'\n''          Profession: Engineer'
documentationPath="documentation/source/tools/decoration.md"
