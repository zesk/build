#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="character - Required. Single character to test."$'\n'"class ... - String. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any)."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does this character match one or more character classes?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/character.sh"
fn="isCharacterClasses"
fnMarker="ischaracterclasses"
foundNames=([0]="argument")
line="84"
rawComment="Does this character match one or more character classes?"$'\n'"Argument: character - Required. Single character to test."$'\n'"Argument: class ... - String. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any)."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceHash="5a2e05ecbe74faca818a547fd009b4342c8f9e78"
sourceLine="84"
summary="Does this character match one or more character classes?"
summaryComputed="true"
usage="isCharacterClasses character [ class ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misCharacterClasses'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcharacter'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ class ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcharacter  '$'\e''[[(value)]mRequired. Single character to test.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mclass ...  '$'\e''[[(value)]mString. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Does this character match one or more character classes?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: isCharacterClasses character [ class ... ] [ --help ]'$'\n'''$'\n''    character  Required. Single character to test.'$'\n''    class ...  String. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Does this character match one or more character classes?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/character.md"
