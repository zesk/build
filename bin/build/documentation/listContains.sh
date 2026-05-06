#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="listValue - Required. List value to search."$'\n'"separator - Required. Separator string for item values (typically \`:\`)"$'\n'"item ... - Optional. the item to be searched for in the \`listValue\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Return code 0 IFF all items are found in the list. If any item is not found, returns code 1."$'\n'"If no items are passed in the return value is 0 (true)."$'\n'"Add an item to the beginning or end of a text-delimited list"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/list.sh"
fn="listContains"
fnMarker="listcontains"
foundNames=([0]="summary" [1]="return_code" [2]="argument")
line="78"
rawComment="Summary: Does a character-delimited list contain item(s)?"$'\n'"Return code 0 IFF all items are found in the list. If any item is not found, returns code 1."$'\n'"Return code: 0 - All items are found in the \`listValue\`"$'\n'"Return code: 1 - One or more items were NOT found in the \`listValue\`"$'\n'"If no items are passed in the return value is 0 (true)."$'\n'"Argument: listValue - Required. List value to search."$'\n'"Argument: separator - Required. Separator string for item values (typically \`:\`)"$'\n'"Argument: item ... - Optional. the item to be searched for in the \`listValue\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Add an item to the beginning or end of a text-delimited list"$'\n'""$'\n'""
return_code="0 - All items are found in the \`listValue\`"$'\n'"1 - One or more items were NOT found in the \`listValue\`"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceHash="3f580df9b039d92b40c8f1a751e6a2027746278d"
sourceLine="78"
summary="Does a character-delimited list contain item(s)?"
summaryComputed=""
usage="listContains listValue separator [ item ... ] [ --help ]"
