#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'separator - String. Required. List separator character.\nlistText - String. Required. List to clean duplicates.\n--removed - Flag. Optional. Show removed items instead of the new list.\n--test testFunction - Function. Optional. Run this function on each item in the list and if the return code is non-zero, then remove it from the list.\n--help - Flag. Optional. Display this help.\n'
base="list.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Removes duplicates from a list and maintains ordering.\n\n'
descriptionLineCount="2"
file="bin/build/tools/list.sh"
fn="listCleanDuplicates"
fnMarker="listcleanduplicates"
foundNames=([0]="argument")
line="171"
rawComment=$'Removes duplicates from a list and maintains ordering.\nArgument: separator - String. Required. List separator character.\nArgument: listText - String. Required. List to clean duplicates.\nArgument: --removed - Flag. Optional. Show removed items instead of the new list.\nArgument: --test testFunction - Function. Optional. Run this function on each item in the list and if the return code is non-zero, then remove it from the list.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/list.sh"
sourceHash="1179b5a538eb132a6b38a5c32bf461f3f9ad5f78"
sourceLine="171"
summary="Removes duplicates from a list and maintains ordering."
summaryComputed="true"
usage="listCleanDuplicates separator listText [ --removed ] [ --test testFunction ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistCleanDuplicates'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mseparator'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlistText'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --removed ]'$'\e''[0m '$'\e''[[(blue)]m[ --test testFunction ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mseparator            '$'\e''[[(value)]mString. Required. List separator character.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mlistText             '$'\e''[[(value)]mString. Required. List to clean duplicates.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--removed            '$'\e''[[(value)]mFlag. Optional. Show removed items instead of the new list.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--test testFunction  '$'\e''[[(value)]mFunction. Optional. Run this function on each item in the list and if the return code is non-zero, then remove it from the list.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help               '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Removes duplicates from a list and maintains ordering.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: listCleanDuplicates separator listText [ --removed ] [ --test testFunction ] [ --help ]'$'\n'''$'\n''    separator            String. Required. List separator character.'$'\n''    listText             String. Required. List to clean duplicates.'$'\n''    --removed            Flag. Optional. Show removed items instead of the new list.'$'\n''    --test testFunction  Function. Optional. Run this function on each item in the list and if the return code is non-zero, then remove it from the list.'$'\n''    --help               Flag. Optional. Display this help.'$'\n'''$'\n''Removes duplicates from a list and maintains ordering.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/list.md"
