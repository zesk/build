#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'listValue - Required. List value to modify.\nseparator - Required. Separator string for item values (typically `:`)\n--first - Flag. Optional. Place any items after this flag first in the list\n--last - Flag. Optional. Place any items after this flag last in the list. Default.\nitem - the value to be added to the `listValue`\n--help - Flag. Optional. Display this help.\n'
base="list.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Add an item to a list IFF it does not exist in the list already\nAdd an item to the beginning or end of a text-delimited list\n\n'
descriptionLineCount="3"
file="bin/build/tools/list.sh"
fn="listAppend"
fnMarker="listappend"
foundNames=([0]="summary" [1]="argument")
line="122"
original="listAppend"
rawComment=$'Summary: Add an item to a character-delimited list.\nAdd an item to a list IFF it does not exist in the list already\nArgument: listValue - Required. List value to modify.\nArgument: separator - Required. Separator string for item values (typically `:`)\nArgument: --first - Flag. Optional. Place any items after this flag first in the list\nArgument: --last - Flag. Optional. Place any items after this flag last in the list. Default.\nArgument: item - the value to be added to the `listValue`\nArgument: --help - Flag. Optional. Display this help.\nAdd an item to the beginning or end of a text-delimited list\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/list.sh"
sourceHash="1179b5a538eb132a6b38a5c32bf461f3f9ad5f78"
sourceLine="122"
summary="Add an item to a character-delimited list."
summaryComputed=""
usage="listAppend listValue separator [ --first ] [ --last ] [ item ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistAppend'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlistValue'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mseparator'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --first ]'$'\e''[0m '$'\e''[[(blue)]m[ --last ]'$'\e''[0m '$'\e''[[(blue)]m[ item ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mlistValue  '$'\e''[[(value)]mRequired. List value to modify.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mseparator  '$'\e''[[(value)]mRequired. Separator string for item values (typically '$'\e''[[(code)]m:'$'\e''[[(reset)]m)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--first    '$'\e''[[(value)]mFlag. Optional. Place any items after this flag first in the list'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--last     '$'\e''[[(value)]mFlag. Optional. Place any items after this flag last in the list. Default.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mitem       '$'\e''[[(value)]mthe value to be added to the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Add an item to a list IFF it does not exist in the list already'$'\n''Add an item to the beginning or end of a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: listAppend listValue separator [ --first ] [ --last ] [ item ] [ --help ]'$'\n'''$'\n''    listValue  Required. List value to modify.'$'\n''    separator  Required. Separator string for item values (typically :)'$'\n''    --first    Flag. Optional. Place any items after this flag first in the list'$'\n''    --last     Flag. Optional. Place any items after this flag last in the list. Default.'$'\n''    item       the value to be added to the listValue'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Add an item to a list IFF it does not exist in the list already'$'\n''Add an item to the beginning or end of a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/list.md"
