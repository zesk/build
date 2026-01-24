#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/quote.sh"
argument="text - Text to quote"$'\n'""
base="quote.sh"
description="Quote strings for inclusion in shell quoted strings"$'\n'"Without arguments, displays help."$'\n'""
example="    escapeSingleQuotes \"Now I can't not include this in a bash string.\""$'\n'""
exitCode="0"
file="bin/build/tools/quote.sh"
foundNames=([0]="argument" [1]="output" [2]="example")
output="Single quotes are prefixed with a backslash"$'\n'""
rawComment="Quote strings for inclusion in shell quoted strings"$'\n'"Without arguments, displays help."$'\n'"Argument: text - Text to quote"$'\n'"Output: Single quotes are prefixed with a backslash"$'\n'"Example:     {fn} \"Now I can't not include this in a bash string.\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceModified="1769063211"
summary="Quote strings for inclusion in shell quoted strings"
usage="escapeSingleQuotes [ text ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mescapeSingleQuotes'$'\e''[0m '$'\e''[[blue]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mtext  '$'\e''[[value]mText to quote'$'\e''[[reset]m'$'\n'''$'\n''Quote strings for inclusion in shell quoted strings'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Example:'$'\n''    escapeSingleQuotes "Now I can'\''t not include this in a bash string."'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: escapeSingleQuotes [ text ]'$'\n'''$'\n''    text  Text to quote'$'\n'''$'\n''Quote strings for inclusion in shell quoted strings'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    escapeSingleQuotes "Now I can'\''t not include this in a bash string."'$'\n'''
