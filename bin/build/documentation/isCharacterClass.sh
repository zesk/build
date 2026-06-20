#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'className - String. Required. Class to check.\ncharacter ... - String. Optional. Characters to test.\n--help - Flag. Optional. Display this help.\n'
base="character.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Poor-man\'s bash character class matching\n\nReturns true if all `characters` are of `className`\n\n`className` can be one of:\n    alnum   alpha   ascii   blank   cntrl   digit   graph   lower\n    print   punct   space   upper   word    xdigit\n\n'
descriptionLineCount="8"
file="bin/build/tools/character.sh"
fn="isCharacterClass"
fnMarker="ischaracterclass"
foundNames=([0]="argument")
line="172"
original="isCharacterClass"
rawComment=$'Poor-man\'s bash character class matching\nReturns true if all `characters` are of `className`\n`className` can be one of:\n    alnum   alpha   ascii   blank   cntrl   digit   graph   lower\n    print   punct   space   upper   word    xdigit\nArgument: className - String. Required. Class to check.\nArgument: character ... - String. Optional. Characters to test.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/character.sh"
sourceHash="859d1cafed674e6fde294a1f7fca6b467b276cf8"
sourceLine="172"
summary="Poor-man's bash character class matching"
summaryComputed="true"
usage="isCharacterClass className [ character ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misCharacterClass'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mclassName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ character ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mclassName      '$'\e''[[(value)]mString. Required. Class to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mcharacter ...  '$'\e''[[(value)]mString. Optional. Characters to test.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Poor-man'\''s bash character class matching'$'\n'''$'\n''Returns true if all '$'\e''[[(code)]mcharacters'$'\e''[[(reset)]m are of '$'\e''[[(code)]mclassName'$'\e''[[(reset)]m'$'\n'''$'\n'''$'\e''[[(code)]mclassName'$'\e''[[(reset)]m can be one of:'$'\n''    alnum   alpha   ascii   blank   cntrl   digit   graph   lower'$'\n''    print   punct   space   upper   word    xdigit'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: isCharacterClass className [ character ... ] [ --help ]'$'\n'''$'\n''    className      String. Required. Class to check.'$'\n''    character ...  String. Optional. Characters to test.'$'\n''    --help         Flag. Optional. Display this help.'$'\n'''$'\n''Poor-man'\''s bash character class matching'$'\n'''$'\n''Returns true if all characters are of className'$'\n'''$'\n''className can be one of:'$'\n''    alnum   alpha   ascii   blank   cntrl   digit   graph   lower'$'\n''    print   punct   space   upper   word    xdigit'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/character.md"
