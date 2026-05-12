#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
sourceHash="8914fcd2d27b7643f86f1ce40b82da6b90c21455"
sourceLine="171"
summary="Removes duplicates from a list and maintains ordering."
summaryComputed="true"
usage="listCleanDuplicates separator listText [ --removed ] [ --test testFunction ] [ --help ]"
