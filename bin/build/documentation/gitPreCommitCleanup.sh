#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Clean up after our pre-commit (deletes cache directory)"$'\n'""
file="bin/build/tools/git.sh"
fn="gitPreCommitCleanup"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Clean up after our pre-commit (deletes cache directory)"
usage="gitPreCommitCleanup [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitPreCommitCleanup[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Clean up after our pre-commit (deletes cache directory)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitCleanup [ --help ]

    --help  Flag. Optional. Display this help.

Clean up after our pre-commit (deletes cache directory)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
