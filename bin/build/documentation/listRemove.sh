#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/list.sh"
argument="listValue - Required. List value to modify."$'\n'"separator - Required. Separator string for item values (typically \`:\`)"$'\n'"item - the item to be removed from the \`listValue\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
description="Remove one or more items from a text-delimited list"$'\n'""
file="bin/build/tools/list.sh"
fn="listRemove"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceModified="1769063211"
summary="Remove one or more items from a text-delimited list"
usage="listRemove listValue separator [ item ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mlistRemove[0m [38;2;255;255;0m[35;48;2;0;0;0mlistValue[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mseparator[0m[0m [94m[ item ][0m [94m[ --help ][0m

    [31mlistValue  [1;97mRequired. List value to modify.[0m
    [31mseparator  [1;97mRequired. Separator string for item values (typically [38;2;0;255;0;48;2;0;0;0m:[0m)[0m
    [94mitem       [1;97mthe item to be removed from the [38;2;0;255;0;48;2;0;0;0mlistValue[0m[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Remove one or more items from a text-delimited list

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: listRemove listValue separator [ item ] [ --help ]

    listValue  Required. List value to modify.
    separator  Required. Separator string for item values (typically :)
    item       the item to be removed from the listValue
    --help     Flag. Optional. Display this help.

Remove one or more items from a text-delimited list

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
