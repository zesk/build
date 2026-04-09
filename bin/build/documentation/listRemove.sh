#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="listValue - Required. List value to modify."$'\n'"separator - Required. Separator string for item values (typically \`:\`)"$'\n'"item - the item to be removed from the \`listValue\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
description="Remove one or more items from a text-delimited list"$'\n'""
file="bin/build/tools/list.sh"
fn="listRemove"
foundNames=([0]="argument")
line="40"
lowerFn="listremove"
rawComment="Remove one or more items from a text-delimited list"$'\n'"Argument: listValue - Required. List value to modify."$'\n'"Argument: separator - Required. Separator string for item values (typically \`:\`)"$'\n'"Argument: item - the item to be removed from the \`listValue\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="41d98a302feb190799f47d4570b57b5beb5b3303"
sourceLine="40"
summary="Remove one or more items from a text-delimited list"
summaryComputed="true"
usage="listRemove listValue separator [ item ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistRemove'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlistValue'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mseparator'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ item ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mlistValue  '$'\e''[[(value)]mRequired. List value to modify.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mseparator  '$'\e''[[(value)]mRequired. Separator string for item values (typically '$'\e''[[(code)]m:'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mitem       '$'\e''[[(value)]mthe item to be removed from the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove one or more items from a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: listRemove listValue separator [ item ] [ --help ]'$'\n'''$'\n''    listValue  Required. List value to modify.'$'\n''    separator  Required. Separator string for item values (typically :)'$'\n''    item       the item to be removed from the listValue'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Remove one or more items from a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/list.md"
