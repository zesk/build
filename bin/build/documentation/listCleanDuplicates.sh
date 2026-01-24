#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/list.sh"
argument="separator - String. Required. List separator character."$'\n'"listText - String. Required. List to clean duplicates."$'\n'"--removed - Flag. Optional. Show removed items instead of the new list."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
description="Removes duplicates from a list and maintains ordering."$'\n'""
exitCode="0"
file="bin/build/tools/list.sh"
foundNames=([0]="argument")
rawComment="Removes duplicates from a list and maintains ordering."$'\n'"Argument: separator - String. Required. List separator character."$'\n'"Argument: listText - String. Required. List to clean duplicates."$'\n'"Argument: --removed - Flag. Optional. Show removed items instead of the new list."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceModified="1769063211"
summary="Removes duplicates from a list and maintains ordering."
usage="listCleanDuplicates separator listText [ --removed ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mlistCleanDuplicates'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mseparator'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mlistText'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ --removed ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mseparator  '$'\e''[[value]mString. Required. List separator character.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mlistText   '$'\e''[[value]mString. Required. List to clean duplicates.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--removed  '$'\e''[[value]mFlag. Optional. Show removed items instead of the new list.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help     '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Removes duplicates from a list and maintains ordering.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: listCleanDuplicates separator listText [ --removed ] [ --help ]'$'\n'''$'\n''    separator  String. Required. List separator character.'$'\n''    listText   String. Required. List to clean duplicates.'$'\n''    --removed  Flag. Optional. Show removed items instead of the new list.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Removes duplicates from a list and maintains ordering.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
