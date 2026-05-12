#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
sourceHash="8914fcd2d27b7643f86f1ce40b82da6b90c21455"
sourceLine="80"
summary="Does a character-delimited list contain item(s)?"
summaryComputed=""
usage="listContains listValue separator [ item ... ] [ --help ]"
