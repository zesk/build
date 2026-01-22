#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Fetches a list of tags from git and filters those which start with v and a digit and returns"$'\n'"them sorted by version correctly."$'\n'""$'\n'"Return Code: 1 - If the \`.git\` directory does not exist"$'\n'"Return Code: 0 - Success"$'\n'""
file="bin/build/tools/git.sh"
fn="gitVersionList"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Fetches a list of tags from git and filters those"
usage="gitVersionList [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitVersionList[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Fetches a list of tags from git and filters those which start with v and a digit and returns
them sorted by version correctly.

Return Code: 1 - If the [38;2;0;255;0;48;2;0;0;0m.git[0m directory does not exist
Return Code: 0 - Success

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitVersionList [ --help ]

    --help  Flag. Optional. Display this help.

Fetches a list of tags from git and filters those which start with v and a digit and returns
them sorted by version correctly.

Return Code: 1 - If the .git directory does not exist
Return Code: 0 - Success

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
