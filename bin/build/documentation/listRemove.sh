#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="listValue - Required. List value to modify."$'\n'"separator - Required. Separator string for item values (typically \`:\`)"$'\n'"item - the item to be removed from the \`listValue\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Remove one or more items from a text-delimited list"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/list.sh"
fn="listRemove"
fnMarker="listremove"
foundNames=([0]="argument")
line="40"
rawComment="Remove one or more items from a text-delimited list"$'\n'"Argument: listValue - Required. List value to modify."$'\n'"Argument: separator - Required. Separator string for item values (typically \`:\`)"$'\n'"Argument: item - the item to be removed from the \`listValue\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="3f580df9b039d92b40c8f1a751e6a2027746278d"
sourceLine="40"
summary="Remove one or more items from a text-delimited list"
summaryComputed="true"
usage="listRemove listValue separator [ item ] [ --help ]"
