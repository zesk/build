#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/list.sh"
argument="listValue - Required. Path value to modify."$'\n'"separator - Required. Separator string for item values (typically \`:\`)"$'\n'"--first - Flag. Optional. Place any items after this flag first in the list"$'\n'"--last - Flag. Optional. Place any items after this flag last in the list. Default."$'\n'"item - the path to be added to the \`listValue\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
description="Add an item to the beginning or end of a text-delimited list"$'\n'""
file="bin/build/tools/list.sh"
fn="listAppend"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceModified="1768759476"
summary="Add an item to the beginning or end of a"
usage="listAppend listValue separator [ --first ] [ --last ] [ item ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mlistAppend[0m [38;2;255;255;0m[35;48;2;0;0;0mlistValue[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mseparator[0m[0m [94m[ --first ][0m [94m[ --last ][0m [94m[ item ][0m [94m[ --help ][0m

    [31mlistValue  [1;97mRequired. Path value to modify.[0m
    [31mseparator  [1;97mRequired. Separator string for item values (typically [38;2;0;255;0;48;2;0;0;0m:[0m)[0m
    [94m--first    [1;97mFlag. Optional. Place any items after this flag first in the list[0m
    [94m--last     [1;97mFlag. Optional. Place any items after this flag last in the list. Default.[0m
    [94mitem       [1;97mthe path to be added to the [38;2;0;255;0;48;2;0;0;0mlistValue[0m[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Add an item to the beginning or end of a text-delimited list

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: listAppend listValue separator [ --first ] [ --last ] [ item ] [ --help ]

    listValue  Required. Path value to modify.
    separator  Required. Separator string for item values (typically :)
    --first    Flag. Optional. Place any items after this flag first in the list
    --last     Flag. Optional. Place any items after this flag last in the list. Default.
    item       the path to be added to the listValue
    --help     Flag. Optional. Display this help.

Add an item to the beginning or end of a text-delimited list

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
