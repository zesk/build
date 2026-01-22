#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/path.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="path.sh"
description="Cleans the path and removes non-directory entries and duplicates"$'\n'""$'\n'"Maintains ordering."$'\n'""$'\n'""
environment="PATH"$'\n'""
file="bin/build/tools/path.sh"
fn="pathCleanDuplicates"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/path.sh"
sourceModified="1768759497"
summary="Cleans the path and removes non-directory entries and duplicates"
usage="pathCleanDuplicates [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpathCleanDuplicates[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Cleans the path and removes non-directory entries and duplicates

Maintains ordering.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- PATH
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: pathCleanDuplicates [ --help ]

    --help  Flag. Optional. Display this help.

Cleans the path and removes non-directory entries and duplicates

Maintains ordering.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- PATH
- 
'
