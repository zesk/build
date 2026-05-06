#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="separator - String. Required. List separator character."$'\n'"listText - String. Required. List to clean duplicates."$'\n'"--removed - Flag. Optional. Show removed items instead of the new list."$'\n'"--test testFunction - Function. Optional. Run this function on each item in the list and if the return code is non-zero, then remove it from the list."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Removes duplicates from a list and maintains ordering."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/list.sh"
fn="listCleanDuplicates"
fnMarker="listcleanduplicates"
foundNames=([0]="argument")
line="169"
rawComment="Removes duplicates from a list and maintains ordering."$'\n'"Argument: separator - String. Required. List separator character."$'\n'"Argument: listText - String. Required. List to clean duplicates."$'\n'"Argument: --removed - Flag. Optional. Show removed items instead of the new list."$'\n'"Argument: --test testFunction - Function. Optional. Run this function on each item in the list and if the return code is non-zero, then remove it from the list."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="3f580df9b039d92b40c8f1a751e6a2027746278d"
sourceLine="169"
summary="Removes duplicates from a list and maintains ordering."
summaryComputed="true"
usage="listCleanDuplicates separator listText [ --removed ] [ --test testFunction ] [ --help ]"
