#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'listValue - Required. List value to modify.\nseparator - Required. Separator string for item values (typically `:`)\nitem - the item to be removed from the `listValue`\n--help - Flag. Optional. Display this help.\n'
base="list.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Remove one or more items from a text-delimited list\n\n'
descriptionLineCount="2"
file="bin/build/tools/list.sh"
fn="listRemove"
fnMarker="listremove"
foundNames=([0]="argument")
line="42"
rawComment=$'Remove one or more items from a text-delimited list\nArgument: listValue - Required. List value to modify.\nArgument: separator - Required. Separator string for item values (typically `:`)\nArgument: item - the item to be removed from the `listValue`\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/list.sh"
sourceHash="8914fcd2d27b7643f86f1ce40b82da6b90c21455"
sourceLine="42"
summary="Remove one or more items from a text-delimited list"
summaryComputed="true"
usage="listRemove listValue separator [ item ] [ --help ]"
