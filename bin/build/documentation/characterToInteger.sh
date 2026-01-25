#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/character.sh"
argument="character - String. Optional. One or more characters to convert to their ASCII equivalent."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
description="Convert one or more characters from their ascii representation to an integer value."$'\n'"Requires a single character to be passed"$'\n'""
exitCode="0"
file="bin/build/tools/character.sh"
foundNames=([0]="summary" [1]="argument")
rawComment="Summary: Convert a character to the corresponding ASCII code"$'\n'"Argument: character - String. Optional. One or more characters to convert to their ASCII equivalent."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Convert one or more characters from their ascii representation to an integer value."$'\n'"Requires a single character to be passed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="Convert a character to the corresponding ASCII code"$'\n'""
usage="characterToInteger [ character ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mcharacterToInteger'$'\e''[0m '$'\e''[[blue]m[ character ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mcharacter  '$'\e''[[value]mString. Optional. One or more characters to convert to their ASCII equivalent.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help     '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Convert one or more characters from their ascii representation to an integer value.'$'\n''Requires a single character to be passed'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: characterToInteger [ character ] [ --help ]'$'\n'''$'\n''    character  String. Optional. One or more characters to convert to their ASCII equivalent.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Convert one or more characters from their ascii representation to an integer value.'$'\n''Requires a single character to be passed'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
