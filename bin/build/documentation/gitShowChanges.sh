#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
credit="Chris Johnsen"$'\n'""
description="Return Code: 0 - the repo has been modified"$'\n'"Return Code: 1 - the repo has NOT bee modified"$'\n'""$'\n'"Show changed files from HEAD"$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitShowChanges"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Return Code: 0 - the repo has been modified"
usage="gitShowChanges [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitShowChanges[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Return Code: 0 - the repo has been modified
Return Code: 1 - the repo has NOT bee modified

Show changed files from HEAD

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitShowChanges [ --help ]

    --help  Flag. Optional. Display this help.

Return Code: 0 - the repo has been modified
Return Code: 1 - the repo has NOT bee modified

Show changed files from HEAD

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
