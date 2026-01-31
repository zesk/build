#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="list.sh"
description="Removes duplicates from a list and maintains ordering."$'\n'"Argument: separator - String. Required. List separator character."$'\n'"Argument: listText - String. Required. List to clean duplicates."$'\n'"Argument: --removed - Flag. Optional. Show removed items instead of the new list."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/list.sh"
foundNames=()
rawComment="Removes duplicates from a list and maintains ordering."$'\n'"Argument: separator - String. Required. List separator character."$'\n'"Argument: listText - String. Required. List to clean duplicates."$'\n'"Argument: --removed - Flag. Optional. Show removed items instead of the new list."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="d039b4726ef8e08c7e4f11ceb46d9ee4af719992"
summary="Removes duplicates from a list and maintains ordering."
usage="listCleanDuplicates"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistCleanDuplicates'$'\e''[0m'$'\n'''$'\n''Removes duplicates from a list and maintains ordering.'$'\n''Argument: separator - String. Required. List separator character.'$'\n''Argument: listText - String. Required. List to clean duplicates.'$'\n''Argument: --removed - Flag. Optional. Show removed items instead of the new list.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: listCleanDuplicates'$'\n'''$'\n''Removes duplicates from a list and maintains ordering.'$'\n''Argument: separator - String. Required. List separator character.'$'\n''Argument: listText - String. Required. List to clean duplicates.'$'\n''Argument: --removed - Flag. Optional. Show removed items instead of the new list.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.467
