#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/list.sh"
argument="separator - String. Required. List separator character."$'\n'"listText - String. Required. List to clean duplicates."$'\n'"--removed - Flag. Optional. Show removed items instead of the new list."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="list.sh"
description="Removes duplicates from a list and maintains ordering."$'\n'""$'\n'""
file="bin/build/tools/list.sh"
fn="listCleanDuplicates"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/list.sh"
sourceModified="1768759476"
summary="Removes duplicates from a list and maintains ordering."
usage="listCleanDuplicates separator listText [ --removed ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mlistCleanDuplicates[0m [38;2;255;255;0m[35;48;2;0;0;0mseparator[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mlistText[0m[0m [94m[ --removed ][0m [94m[ --help ][0m

    [31mseparator  [1;97mString. Required. List separator character.[0m
    [31mlistText   [1;97mString. Required. List to clean duplicates.[0m
    [94m--removed  [1;97mFlag. Optional. Show removed items instead of the new list.[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Removes duplicates from a list and maintains ordering.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: listCleanDuplicates separator listText [ --removed ] [ --help ]

    separator  String. Required. List separator character.
    listText   String. Required. List to clean duplicates.
    --removed  Flag. Optional. Show removed items instead of the new list.
    --help     Flag. Optional. Display this help.

Removes duplicates from a list and maintains ordering.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
