#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="list.sh"
description="Remove one or more items from a text-delimited list"$'\n'"Argument: listValue - Required. List value to modify."$'\n'"Argument: separator - Required. Separator string for item values (typically \`:\`)"$'\n'"Argument: item - the item to be removed from the \`listValue\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/list.sh"
foundNames=()
rawComment="Remove one or more items from a text-delimited list"$'\n'"Argument: listValue - Required. List value to modify."$'\n'"Argument: separator - Required. Separator string for item values (typically \`:\`)"$'\n'"Argument: item - the item to be removed from the \`listValue\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="d039b4726ef8e08c7e4f11ceb46d9ee4af719992"
summary="Remove one or more items from a text-delimited list"
usage="listRemove"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mlistRemove'$'\e''[0m'$'\n'''$'\n''Remove one or more items from a text-delimited list'$'\n''Argument: listValue - Required. List value to modify.'$'\n''Argument: separator - Required. Separator string for item values (typically '$'\e''[[(code)]m:'$'\e''[[(reset)]m)'$'\n''Argument: item - the item to be removed from the '$'\e''[[(code)]mlistValue'$'\e''[[(reset)]m'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: listRemove'$'\n'''$'\n''Remove one or more items from a text-delimited list'$'\n''Argument: listValue - Required. List value to modify.'$'\n''Argument: separator - Required. Separator string for item values (typically :)'$'\n''Argument: item - the item to be removed from the listValue'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.55
