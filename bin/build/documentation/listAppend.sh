#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="listValue - Required. List value to modify."$'\n'"separator - Required. Separator string for item values (typically \`:\`)"$'\n'"--first - Flag. Optional. Place any items after this flag first in the list"$'\n'"--last - Flag. Optional. Place any items after this flag last in the list. Default."$'\n'"item - the value to be added to the \`listValue\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add an item to a list IFF it does not exist in the list already"$'\n'"Add an item to the beginning or end of a text-delimited list"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/list.sh"
fn="listAppend"
fnMarker="listappend"
foundNames=([0]="summary" [1]="argument")
line="120"
rawComment="Summary: Add an item to a character-delimited list."$'\n'"Add an item to a list IFF it does not exist in the list already"$'\n'"Argument: listValue - Required. List value to modify."$'\n'"Argument: separator - Required. Separator string for item values (typically \`:\`)"$'\n'"Argument: --first - Flag. Optional. Place any items after this flag first in the list"$'\n'"Argument: --last - Flag. Optional. Place any items after this flag last in the list. Default."$'\n'"Argument: item - the value to be added to the \`listValue\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Add an item to the beginning or end of a text-delimited list"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="3f580df9b039d92b40c8f1a751e6a2027746278d"
sourceLine="120"
summary="Add an item to a character-delimited list."
summaryComputed=""
usage="listAppend listValue separator [ --first ] [ --last ] [ item ] [ --help ]"
