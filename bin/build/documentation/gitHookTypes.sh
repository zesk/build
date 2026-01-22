#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="List current valid git hook types"$'\n'"Hook types:"$'\n'"- pre-commit"$'\n'"- pre-push"$'\n'"- pre-merge-commit"$'\n'"- pre-rebase"$'\n'"- pre-receive"$'\n'"- update"$'\n'"- post-update"$'\n'"- post-commit"$'\n'""
file="bin/build/tools/git.sh"
fn="gitHookTypes"
output="lines:gitHookType"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="List current valid git hook types"
usage="gitHookTypes"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitHookTypes[0m

List current valid git hook types
Hook types:
- pre-commit
- pre-push
- pre-merge-commit
- pre-rebase
- pre-receive
- update
- post-update
- post-commit

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitHookTypes

List current valid git hook types
Hook types:
- pre-commit
- pre-push
- pre-merge-commit
- pre-rebase
- pre-receive
- update
- post-update
- post-commit

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
