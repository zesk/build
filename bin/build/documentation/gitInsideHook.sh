#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="Are we currently inside a git hook?"$'\n'""$'\n'"Tests non-blank strings in our environment."$'\n'""$'\n'"Return Code: 0 - We are, semantically, inside a git hook"$'\n'"Return Code: 1 - We are NOT, semantically, inside a git hook"$'\n'""$'\n'""
environment="GIT_EXEC_PATH - Must be set to pass"$'\n'"GIT_INDEX_FILE - Must be set to pass"$'\n'""
file="bin/build/tools/git.sh"
fn="gitInsideHook"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Are we currently inside a git hook?"
usage="gitInsideHook"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitInsideHook[0m

Are we currently inside a git hook?

Tests non-blank strings in our environment.

Return Code: 0 - We are, semantically, inside a git hook
Return Code: 1 - We are NOT, semantically, inside a git hook

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- GIT_EXEC_PATH - Must be set to pass
- GIT_INDEX_FILE - Must be set to pass
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitInsideHook

Are we currently inside a git hook?

Tests non-blank strings in our environment.

Return Code: 0 - We are, semantically, inside a git hook
Return Code: 1 - We are NOT, semantically, inside a git hook

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- GIT_EXEC_PATH - Must be set to pass
- GIT_INDEX_FILE - Must be set to pass
- 
'
