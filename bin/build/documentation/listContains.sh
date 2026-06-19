#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'listValue - Required. List value to search.\nseparator - Required. Separator string for item values (typically `:`)\nitem ... - Optional. the item to be searched for in the `listValue`\n--help - Flag. Optional. Display this help.\n'
base="list.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Return code 0 IFF all items are found in the list. If any item is not found, returns code 1.\nIf no items are passed in the return value is 0 (true).\nAdd an item to the beginning or end of a text-delimited list\n\n'
descriptionLineCount="4"
file="bin/build/tools/list.sh"
fn="listContains"
fnMarker="listcontains"
foundNames=([0]="summary" [1]="return_code" [2]="argument")
line="80"
rawComment=$'Summary: Does a character-delimited list contain item(s)?\nReturn code 0 IFF all items are found in the list. If any item is not found, returns code 1.\nReturn code: 0 - All items are found in the `listValue`\nReturn code: 1 - One or more items were NOT found in the `listValue`\nIf no items are passed in the return value is 0 (true).\nArgument: listValue - Required. List value to search.\nArgument: separator - Required. Separator string for item values (typically `:`)\nArgument: item ... - Optional. the item to be searched for in the `listValue`\nArgument: --help - Flag. Optional. Display this help.\nAdd an item to the beginning or end of a text-delimited list\n\n'
return_code=$'0 - All items are found in the `listValue`\n1 - One or more items were NOT found in the `listValue`\n'
sourceFile="bin/build/tools/list.sh"
sourceHash="1179b5a538eb132a6b38a5c32bf461f3f9ad5f78"
sourceLine="80"
summary="Does a character-delimited list contain item(s)?"
summaryComputed=""
usage="listContains listValue separator [ item ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistContains'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlistValue'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mseparator'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ item ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mlistValue  '$'\e''[[(value)]mRequired. List value to search.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mseparator  '$'\e''[[(value)]mRequired. Separator string for item values (typically '$'\e''[[(code)]m:'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mitem ...   '$'\e''[[(value)]mOptional. the item to be searched for in the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Return code 0 IFF all items are found in the list. If any item is not found, returns code 1.'$'\n''If no items are passed in the return value is 0 (true).'$'\n''Add an item to the beginning or end of a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All items are found in the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more items were NOT found in the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'
# shellcheck disable=SC2016
helpPlain='Usage: listContains listValue separator [ item ... ] [ --help ]'$'\n'''$'\n''    listValue  Required. List value to search.'$'\n''    separator  Required. Separator string for item values (typically :)'$'\n''    item ...   Optional. the item to be searched for in the listValue'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Return code 0 IFF all items are found in the list. If any item is not found, returns code 1.'$'\n''If no items are passed in the return value is 0 (true).'$'\n''Add an item to the beginning or end of a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- 0 - All items are found in the listValue'$'\n''- 1 - One or more items were NOT found in the listValue'
documentationPath="documentation/source/tools/list.md"
