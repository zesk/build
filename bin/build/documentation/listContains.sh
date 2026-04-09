#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="listValue - Required. List value to search."$'\n'"separator - Required. Separator string for item values (typically \`:\`)"$'\n'"item ... - Optional. the item to be searched for in the \`listValue\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
description="Return code 0 IFF all items are found in the list. If any item is not found, returns code 1."$'\n'"If no items are passed in the return value is 0 (true)."$'\n'"Add an item to the beginning or end of a text-delimited list"$'\n'""
file="bin/build/tools/list.sh"
fn="listContains"
foundNames=([0]="summary" [1]="return_code" [2]="argument")
line="78"
lowerFn="listcontains"
rawComment="Summary: Does a character-delimited list contain item(s)?"$'\n'"Return code 0 IFF all items are found in the list. If any item is not found, returns code 1."$'\n'"Return code: 0 - All items are found in the \`listValue\`"$'\n'"Return code: 1 - One or more items were NOT found in the \`listValue\`"$'\n'"If no items are passed in the return value is 0 (true)."$'\n'"Argument: listValue - Required. List value to search."$'\n'"Argument: separator - Required. Separator string for item values (typically \`:\`)"$'\n'"Argument: item ... - Optional. the item to be searched for in the \`listValue\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Add an item to the beginning or end of a text-delimited list"$'\n'""$'\n'""
return_code="0 - All items are found in the \`listValue\`"$'\n'"1 - One or more items were NOT found in the \`listValue\`"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="41d98a302feb190799f47d4570b57b5beb5b3303"
sourceLine="78"
summary="Does a character-delimited list contain item(s)?"$'\n'""
usage="listContains listValue separator [ item ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistContains'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlistValue'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mseparator'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ item ... ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mlistValue  '$'\e''[[(value)]mRequired. List value to search.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mseparator  '$'\e''[[(value)]mRequired. Separator string for item values (typically '$'\e''[[(code)]m:'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mitem ...   '$'\e''[[(value)]mOptional. the item to be searched for in the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Return code 0 IFF all items are found in the list. If any item is not found, returns code 1.'$'\n''If no items are passed in the return value is 0 (true).'$'\n''Add an item to the beginning or end of a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All items are found in the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more items were NOT found in the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: listContains listValue separator [ item ... ] [ --help ]'$'\n'''$'\n''    listValue  Required. List value to search.'$'\n''    separator  Required. Separator string for item values (typically :)'$'\n''    item ...   Optional. the item to be searched for in the listValue'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Return code 0 IFF all items are found in the list. If any item is not found, returns code 1.'$'\n''If no items are passed in the return value is 0 (true).'$'\n''Add an item to the beginning or end of a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- 0 - All items are found in the listValue'$'\n''- 1 - One or more items were NOT found in the listValue'$'\n'''
documentationPath="documentation/source/tools/list.md"
