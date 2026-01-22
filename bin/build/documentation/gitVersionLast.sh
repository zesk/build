#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="ignorePattern - Optional. String. Specify a grep pattern to ignore; allows you to ignore current version"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Get the last reported version."$'\n'""
file="bin/build/tools/git.sh"
fn="gitVersionLast"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769063211"
summary="Get the last reported version."
usage="gitVersionLast [ ignorePattern ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitVersionLast[0m [94m[ ignorePattern ][0m [94m[ --help ][0m

    [94mignorePattern  [1;97mOptional. String. Specify a grep pattern to ignore; allows you to ignore current version[0m
    [94m--help         [1;97mFlag. Optional. Display this help.[0m

Get the last reported version.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitVersionLast [ ignorePattern ] [ --help ]

    ignorePattern  Optional. String. Specify a grep pattern to ignore; allows you to ignore current version
    --help         Flag. Optional. Display this help.

Get the last reported version.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
