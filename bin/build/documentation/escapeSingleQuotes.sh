#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="text - Text to quote"$'\n'""
base="quote.sh"
description="Quote strings for inclusion in shell quoted strings"$'\n'"Without arguments, displays help."$'\n'""
example="    escapeSingleQuotes \"Now I can't not include this in a bash string.\""$'\n'""
file="bin/build/tools/quote.sh"
fn="escapeSingleQuotes"
foundNames=([0]="argument" [1]="output" [2]="example")
line="106"
lowerFn="escapesinglequotes"
output="Single quotes are prefixed with a backslash"$'\n'""
rawComment="Quote strings for inclusion in shell quoted strings"$'\n'"Without arguments, displays help."$'\n'"Argument: text - Text to quote"$'\n'"Output: Single quotes are prefixed with a backslash"$'\n'"Example:     {fn} \"Now I can't not include this in a bash string.\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/quote.sh"
sourceHash="ea3a27e64582997f04005c71fc71250ff1ba01c0"
sourceLine="106"
summary="Quote strings for inclusion in shell quoted strings"
summaryComputed="true"
usage="escapeSingleQuotes [ text ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mescapeSingleQuotes'$'\e''[0m '$'\e''[[(blue)]m[ text ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtext  '$'\e''[[(value)]mText to quote'$'\e''[[(reset)]m'$'\n'''$'\n''Quote strings for inclusion in shell quoted strings'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    escapeSingleQuotes "Now I can'\''t not include this in a bash string."'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: escapeSingleQuotes [ text ]'$'\n'''$'\n''    text  Text to quote'$'\n'''$'\n''Quote strings for inclusion in shell quoted strings'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    escapeSingleQuotes "Now I can'\''t not include this in a bash string."'$'\n'''
documentationPath="documentation/source/tools/quote.md"
