#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sed.sh"
argument="searchPattern - String. Required. The string to search for."$'\n'"replacePattern - String. Required. The replacement to replace with."$'\n'""
base="sed.sh"
description="Quote a sed command for search and replace"$'\n'"Without arguments, displays help."$'\n'""
exitCode="0"
file="bin/build/tools/sed.sh"
foundNames=([0]="argument")
rawComment="Quote a sed command for search and replace"$'\n'"Argument: searchPattern - String. Required. The string to search for."$'\n'"Argument: replacePattern - String. Required. The replacement to replace with."$'\n'"Without arguments, displays help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sed.sh"
sourceModified="1769063211"
summary="Quote a sed command for search and replace"
usage="sedReplacePattern searchPattern replacePattern"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]msedReplacePattern'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]msearchPattern'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mreplacePattern'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]msearchPattern   '$'\e''[[value]mString. Required. The string to search for.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mreplacePattern  '$'\e''[[value]mString. Required. The replacement to replace with.'$'\e''[[reset]m'$'\n'''$'\n''Quote a sed command for search and replace'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: sedReplacePattern searchPattern replacePattern'$'\n'''$'\n''    searchPattern   String. Required. The string to search for.'$'\n''    replacePattern  String. Required. The replacement to replace with.'$'\n'''$'\n''Quote a sed command for search and replace'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
