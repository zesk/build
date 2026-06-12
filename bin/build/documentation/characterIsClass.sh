#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-12
# shellcheck disable=SC2034
argument="character - Required. Single character to test."$'\n'"class ... - String. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any)."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does this character match one or more character classes?"$'\n'"See:"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/character.sh"
fn="characterIsClass"
fnMarker="characterisclass"
foundNames=([0]="summary" [1]="argument")
line="56"
rawComment="Summary: Check a character matches any character class"$'\n'"Does this character match one or more character classes?"$'\n'"See:"$'\n'"Argument: character - Required. Single character to test."$'\n'"Argument: class ... - String. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any)."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceHash="79294e27750fb832d5811293e7b59bef672c64a7"
sourceLine="56"
summary="Check a character matches any character class"
summaryComputed=""
usage="characterIsClass character [ class ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcharacterIsClass'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcharacter'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ class ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcharacter  '$'\e''[[(value)]mRequired. Single character to test.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mclass ...  '$'\e''[[(value)]mString. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Does this character match one or more character classes?'$'\n''See:'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: characterIsClass character [ class ... ] [ --help ]'$'\n'''$'\n''    character  Required. Single character to test.'$'\n''    class ...  String. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Does this character match one or more character classes?'$'\n''See:'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/character.md"
