#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/manpath.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="manpath.sh"
description="Cleans the MANPATH and removes non-directory entries and duplicates"$'\n'""$'\n'"Maintains ordering."$'\n'""$'\n'"No-Arguments: default"$'\n'""
file="bin/build/tools/manpath.sh"
fn="manPathCleanDuplicates"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/manpath.sh"
sourceModified="1769063211"
summary="Cleans the MANPATH and removes non-directory entries and duplicates"
usage="manPathCleanDuplicates [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmanPathCleanDuplicates[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Cleans the MANPATH and removes non-directory entries and duplicates

Maintains ordering.

No-Arguments: default

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: manPathCleanDuplicates [ --help ]

    --help  Flag. Optional. Display this help.

Cleans the MANPATH and removes non-directory entries and duplicates

Maintains ordering.

No-Arguments: default

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
