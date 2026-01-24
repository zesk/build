#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/character.sh"
argument="--class - Flag. Optional. Show class and then characters in that class."$'\n'"--char - Flag. Optional. Show characters and then class for that character."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
description="Write a report of the character classes"$'\n'""
exitCode="0"
file="bin/build/tools/character.sh"
foundNames=([0]="argument")
rawComment="Write a report of the character classes"$'\n'"Argument: --class - Flag. Optional. Show class and then characters in that class."$'\n'"Argument: --char - Flag. Optional. Show characters and then class for that character."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="Write a report of the character classes"
usage="characterClassReport [ --class ] [ --char ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mcharacterClassReport'$'\e''[0m '$'\e''[[blue]m[ --class ]'$'\e''[0m '$'\e''[[blue]m[ --char ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--class  '$'\e''[[value]mFlag. Optional. Show class and then characters in that class.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--char   '$'\e''[[value]mFlag. Optional. Show characters and then class for that character.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help   '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Write a report of the character classes'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: characterClassReport [ --class ] [ --char ] [ --help ]'$'\n'''$'\n''    --class  Flag. Optional. Show class and then characters in that class.'$'\n''    --char   Flag. Optional. Show characters and then class for that character.'$'\n''    --help   Flag. Optional. Display this help.'$'\n'''$'\n''Write a report of the character classes'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
