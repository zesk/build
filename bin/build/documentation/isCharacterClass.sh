#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="character.sh"
description="Poor-man's bash character class matching"$'\n'"Returns true if all \`characters\` are of \`className\`"$'\n'"\`className\` can be one of:"$'\n'"    alnum   alpha   ascii   blank   cntrl   digit   graph   lower"$'\n'"    print   punct   space   upper   word    xdigit"$'\n'"Argument: className - String. Required. Class to check."$'\n'"Argument: character ... - String. Optional. Characters to test."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/character.sh"
foundNames=()
rawComment="Poor-man's bash character class matching"$'\n'"Returns true if all \`characters\` are of \`className\`"$'\n'"\`className\` can be one of:"$'\n'"    alnum   alpha   ascii   blank   cntrl   digit   graph   lower"$'\n'"    print   punct   space   upper   word    xdigit"$'\n'"Argument: className - String. Required. Class to check."$'\n'"Argument: character ... - String. Optional. Characters to test."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceHash="1b66edc2c7cdf0829aec0d3302d3e6078f8b2de4"
summary="Poor-man's bash character class matching"
usage="isCharacterClass"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misCharacterClass'$'\e''[0m'$'\n'''$'\n''Poor-man'\''s bash character class matching'$'\n''Returns true if all '$'\e''[[(code)]mcharacters'$'\e''[[(reset)]m are of '$'\e''[[(code)]mclassName'$'\e''[[(reset)]m'$'\n'''$'\e''[[(code)]mclassName'$'\e''[[(reset)]m can be one of:'$'\n''    alnum   alpha   ascii   blank   cntrl   digit   graph   lower'$'\n''    print   punct   space   upper   word    xdigit'$'\n''Argument: className - String. Required. Class to check.'$'\n''Argument: character ... - String. Optional. Characters to test.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isCharacterClass'$'\n'''$'\n''Poor-man'\''s bash character class matching'$'\n''Returns true if all characters are of className'$'\n''className can be one of:'$'\n''    alnum   alpha   ascii   blank   cntrl   digit   graph   lower'$'\n''    print   punct   space   upper   word    xdigit'$'\n''Argument: className - String. Required. Class to check.'$'\n''Argument: character ... - String. Optional. Characters to test.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.452
