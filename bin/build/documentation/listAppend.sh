#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="listValue - Required. List value to modify."$'\n'"separator - Required. Separator string for item values (typically \`:\`)"$'\n'"--first - Flag. Optional. Place any items after this flag first in the list"$'\n'"--last - Flag. Optional. Place any items after this flag last in the list. Default."$'\n'"item - the value to be added to the \`listValue\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
description="Add an item to a list IFF it does not exist in the list already"$'\n'"Add an item to the beginning or end of a text-delimited list"$'\n'""
file="bin/build/tools/list.sh"
fn="listAppend"
foundNames=([0]="summary" [1]="argument")
line="120"
lowerFn="listappend"
rawComment="Summary: Add an item to a character-delimited list."$'\n'"Add an item to a list IFF it does not exist in the list already"$'\n'"Argument: listValue - Required. List value to modify."$'\n'"Argument: separator - Required. Separator string for item values (typically \`:\`)"$'\n'"Argument: --first - Flag. Optional. Place any items after this flag first in the list"$'\n'"Argument: --last - Flag. Optional. Place any items after this flag last in the list. Default."$'\n'"Argument: item - the value to be added to the \`listValue\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Add an item to the beginning or end of a text-delimited list"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="41d98a302feb190799f47d4570b57b5beb5b3303"
sourceLine="120"
summary="Add an item to a character-delimited list."$'\n'""
usage="listAppend listValue separator [ --first ] [ --last ] [ item ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistAppend'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlistValue'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mseparator'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --first ]'$'\e''[0m '$'\e''[[(blue)]m[ --last ]'$'\e''[0m '$'\e''[[(blue)]m[ item ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mlistValue  '$'\e''[[(value)]mRequired. List value to modify.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mseparator  '$'\e''[[(value)]mRequired. Separator string for item values (typically '$'\e''[[(code)]m:'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--first    '$'\e''[[(value)]mFlag. Optional. Place any items after this flag first in the list'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--last     '$'\e''[[(value)]mFlag. Optional. Place any items after this flag last in the list. Default.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mitem       '$'\e''[[(value)]mthe value to be added to the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Add an item to a list IFF it does not exist in the list already'$'\n''Add an item to the beginning or end of a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: listAppend listValue separator [ --first ] [ --last ] [ item ] [ --help ]'$'\n'''$'\n''    listValue  Required. List value to modify.'$'\n''    separator  Required. Separator string for item values (typically :)'$'\n''    --first    Flag. Optional. Place any items after this flag first in the list'$'\n''    --last     Flag. Optional. Place any items after this flag last in the list. Default.'$'\n''    item       the value to be added to the listValue'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Add an item to a list IFF it does not exist in the list already'$'\n''Add an item to the beginning or end of a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/list.md"
