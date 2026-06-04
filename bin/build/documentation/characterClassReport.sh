#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="--class - Flag. Optional. Show class and then characters in that class."$'\n'"--char - Flag. Optional. Show characters and then class for that character."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Write a report of the character classes"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/character.sh"
fn="characterClassReport"
fnMarker="characterclassreport"
foundNames=([0]="todo" [1]="argument")
line="21"
rawComment="Write a report of the character classes"$'\n'"TODO: This is super-slow"$'\n'"Argument: --class - Flag. Optional. Show class and then characters in that class."$'\n'"Argument: --char - Flag. Optional. Show characters and then class for that character."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceHash="5a2e05ecbe74faca818a547fd009b4342c8f9e78"
sourceLine="21"
summary="Write a report of the character classes"
summaryComputed="true"
todo="This is super-slow"$'\n'""
usage="characterClassReport [ --class ] [ --char ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcharacterClassReport'$'\e''[0m '$'\e''[[(blue)]m[ --class ]'$'\e''[0m '$'\e''[[(blue)]m[ --char ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--class  '$'\e''[[(value)]mFlag. Optional. Show class and then characters in that class.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--char   '$'\e''[[(value)]mFlag. Optional. Show characters and then class for that character.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Write a report of the character classes'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: characterClassReport [ --class ] [ --char ] [ --help ]'$'\n'''$'\n''    --class  Flag. Optional. Show class and then characters in that class.'$'\n''    --char   Flag. Optional. Show characters and then class for that character.'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Write a report of the character classes'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/character.md"
