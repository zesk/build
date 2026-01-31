#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="list.sh"
description="Argument: listValue - Required. Path value to modify."$'\n'"Argument: separator - Required. Separator string for item values (typically \`:\`)"$'\n'"Argument: --first - Flag. Optional. Place any items after this flag first in the list"$'\n'"Argument: --last - Flag. Optional. Place any items after this flag last in the list. Default."$'\n'"Argument: item - the path to be added to the \`listValue\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Add an item to the beginning or end of a text-delimited list"$'\n'""
file="bin/build/tools/list.sh"
foundNames=()
rawComment="Argument: listValue - Required. Path value to modify."$'\n'"Argument: separator - Required. Separator string for item values (typically \`:\`)"$'\n'"Argument: --first - Flag. Optional. Place any items after this flag first in the list"$'\n'"Argument: --last - Flag. Optional. Place any items after this flag last in the list. Default."$'\n'"Argument: item - the path to be added to the \`listValue\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Add an item to the beginning or end of a text-delimited list"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="d039b4726ef8e08c7e4f11ceb46d9ee4af719992"
summary="Argument: listValue - Required. Path value to modify."
usage="listAppend"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistAppend'$'\e''[0m'$'\n'''$'\n''Argument: listValue - Required. Path value to modify.'$'\n''Argument: separator - Required. Separator string for item values (typically '$'\e''[[(code)]m:'$'\e''[[(reset)]m)'$'\n''Argument: --first - Flag. Optional. Place any items after this flag first in the list'$'\n''Argument: --last - Flag. Optional. Place any items after this flag last in the list. Default.'$'\n''Argument: item - the path to be added to the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Add an item to the beginning or end of a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: listAppend'$'\n'''$'\n''Argument: listValue - Required. Path value to modify.'$'\n''Argument: separator - Required. Separator string for item values (typically :)'$'\n''Argument: --first - Flag. Optional. Place any items after this flag first in the list'$'\n''Argument: --last - Flag. Optional. Place any items after this flag last in the list. Default.'$'\n''Argument: item - the path to be added to the listValue'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Add an item to the beginning or end of a text-delimited list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.48
