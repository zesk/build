#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
rawComment=$'Summary: Add an item to a character-delimited list.\nAdd an item to a list IFF it does not exist in the list already\nArgument: listValue - Required. List value to modify.\nArgument: separator - Required. Separator string for item values (typically `:`)\nArgument: --first - Flag. Optional. Place any items after this flag first in the list\nArgument: --last - Flag. Optional. Place any items after this flag last in the list. Default.\nArgument: item - the value to be added to the `listValue`\nArgument: --help - Flag. Optional. Display this help.\nAdd an item to the beginning or end of a text-delimited list\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/list.sh"
sourceHash="8914fcd2d27b7643f86f1ce40b82da6b90c21455"
sourceLine="122"
summary="Add an item to a character-delimited list."
summaryComputed=""
usage="listAppend listValue separator [ --first ] [ --last ] [ item ] [ --help ]"
