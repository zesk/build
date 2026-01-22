#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
credit="Chris Johnsen"$'\n'""
description="Return Code: 1 - the repo has NOT been modified"$'\n'"Return Code: 0 - the repo has been modified"$'\n'""$'\n'"Has a git repository been changed from HEAD?"$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitRepositoryChanged"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Return Code: 1 - the repo has NOT been modified"
usage="gitRepositoryChanged"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitRepositoryChanged[0m

Return Code: 1 - the repo has NOT been modified
Return Code: 0 - the repo has been modified

Has a git repository been changed from HEAD?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitRepositoryChanged

Return Code: 1 - the repo has NOT been modified
Return Code: 0 - the repo has been modified

Has a git repository been changed from HEAD?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
