#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/character.sh"
argument="className - String. Required. Class to check."$'\n'"character ... - String. Optional. Characters to test."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
description="Poor-man's bash character class matching"$'\n'"Returns true if all \`characters\` are of \`className\`"$'\n'"\`className\` can be one of:"$'\n'"    alnum   alpha   ascii   blank   cntrl   digit   graph   lower"$'\n'"    print   punct   space   upper   word    xdigit"$'\n'""
file="bin/build/tools/character.sh"
foundNames=([0]="argument")
rawComment="Poor-man's bash character class matching"$'\n'"Returns true if all \`characters\` are of \`className\`"$'\n'"\`className\` can be one of:"$'\n'"    alnum   alpha   ascii   blank   cntrl   digit   graph   lower"$'\n'"    print   punct   space   upper   word    xdigit"$'\n'"Argument: className - String. Required. Class to check."$'\n'"Argument: character ... - String. Optional. Characters to test."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceModified="1769063211"
summary="Poor-man's bash character class matching"
usage="isCharacterClass className [ character ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misCharacterClass'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mclassName'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ character ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mclassName      '$'\e''[[(value)]mString. Required. Class to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mcharacter ...  '$'\e''[[(value)]mString. Optional. Characters to test.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Poor-man'\''s bash character class matching'$'\n''Returns true if all '$'\e''[[(code)]mcharacters'$'\e''[[(reset)]m are of '$'\e''[[(code)]mclassName'$'\e''[[(reset)]m'$'\n'''$'\e''[[(code)]mclassName'$'\e''[[(reset)]m can be one of:'$'\n''    alnum   alpha   ascii   blank   cntrl   digit   graph   lower'$'\n''    print   punct   space   upper   word    xdigit'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isCharacterClass className [ character ... ] [ --help ]'$'\n'''$'\n''    className      String. Required. Class to check.'$'\n''    character ...  String. Optional. Characters to test.'$'\n''    --help         Flag. Optional. Display this help.'$'\n'''$'\n''Poor-man'\''s bash character class matching'$'\n''Returns true if all characters are of className'$'\n''className can be one of:'$'\n''    alnum   alpha   ascii   blank   cntrl   digit   graph   lower'$'\n''    print   punct   space   upper   word    xdigit'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.458
