#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"tag - The tag to delete locally and at origin"$'\n'""
base="git.sh"
description="Delete git tag locally and at origin"$'\n'""$'\n'"Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur."$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitTagDelete"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Delete git tag locally and at origin"
usage="gitTagDelete [ --help ] [ tag ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitTagDelete[0m [94m[ --help ][0m [94m[ tag ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m
    [94mtag     [1;97mThe tag to delete locally and at origin[0m

Delete git tag locally and at origin

Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitTagDelete [ --help ] [ tag ]

    --help  Flag. Optional. Display this help.
    tag     The tag to delete locally and at origin

Delete git tag locally and at origin

Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
