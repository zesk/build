#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\ncharacter ... - String. Optional. Output the character classes associated with this character. Uses the first character only. Multiple parameters are output without a delimiter.\n'
base="character.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List the classes allowed in `isCharacterClass`\n\n'
descriptionLineCount="2"
file="bin/build/tools/character.sh"
fn="characterClasses"
fnMarker="characterclasses"
foundNames=([0]="argument")
line="125"
original="characterClasses"
rawComment=$'List the classes allowed in `isCharacterClass`\nArgument: --help - Flag. Optional. Display this help.\nArgument: character ... - String. Optional. Output the character classes associated with this character. Uses the first character only. Multiple parameters are output without a delimiter.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/character.sh"
sourceHash="859d1cafed674e6fde294a1f7fca6b467b276cf8"
sourceLine="125"
summary="List the classes allowed in \`isCharacterClass\`"
summaryComputed="true"
usage="characterClasses [ --help ] [ character ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcharacterClasses'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ character ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mcharacter ...  '$'\e''[[(value)]mString. Optional. Output the character classes associated with this character. Uses the first character only. Multiple parameters are output without a delimiter.'$'\e''[[(reset)]m'$'\n'''$'\n''List the classes allowed in '$'\e''[[(code)]misCharacterClass'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: characterClasses [ --help ] [ character ... ]'$'\n'''$'\n''    --help         Flag. Optional. Display this help.'$'\n''    character ...  String. Optional. Output the character classes associated with this character. Uses the first character only. Multiple parameters are output without a delimiter.'$'\n'''$'\n''List the classes allowed in isCharacterClass'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/character.md"
