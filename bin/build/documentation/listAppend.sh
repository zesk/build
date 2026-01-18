#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/list.sh"
argument="listValue - Required. Path value to modify."$'\n'"separator - Required. Separator string for item values (typically \`:\`)"$'\n'"--first - Optional. Place any items after this flag first in the list"$'\n'"--last - Optional. Place any items after this flag last in the list. Default."$'\n'"item - the path to be added to the \`listValue\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
description="Add an item to the beginning or end of a text-delimited list"$'\n'""
file="bin/build/tools/list.sh"
fn="listAppend"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/list.sh"
sourceModified="1768756695"
summary="Add an item to the beginning or end of a"
usage="listAppend listValue separator [ --first ] [ --last ] [ item ] [ --help ]"
