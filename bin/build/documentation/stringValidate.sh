#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="text - Text to validate"$'\n'"class0 ... - One or more character classes that the characters in string should match"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
description="Ensure that every character in a text string passes all character class tests"$'\n'""
file="bin/build/tools/character.sh"
foundNames=([0]="argument" [1]="note")
note="This is slow."$'\n'""
rawComment="Ensure that every character in a text string passes all character class tests"$'\n'"Argument: text - Text to validate"$'\n'"Argument: class0 ... - One or more character classes that the characters in string should match"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Note: This is slow."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceHash="1b66edc2c7cdf0829aec0d3302d3e6078f8b2de4"
summary="Ensure that every character in a text string passes all"
summaryComputed="true"
usage="stringValidate [ text ] [ class0 ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringValidate'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m '$'\e''[[(blue)]m[ class0 ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtext        '$'\e''[[(value)]mText to validate'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mclass0 ...  '$'\e''[[(value)]mOne or more character classes that the characters in string should match'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Ensure that every character in a text string passes all character class tests'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mstringValidate [[(blue)]m[ text ] [[(blue)]m[ class0 ... ] [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]mtext        Text to validate'$'\n''    [[(blue)]mclass0 ...  One or more character classes that the characters in string should match'$'\n''    [[(blue)]m--help      Flag. Optional. Display this help.'$'\n'''$'\n''Ensure that every character in a text string passes all character class tests'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 3.644
