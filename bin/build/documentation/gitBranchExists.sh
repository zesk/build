#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="branch ... - String. Required. List of branch names to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Does a branch exist locally or remotely?"$'\n'"Return Code: 0 - All branches passed exist"$'\n'"Return Code: 1 - At least one branch does not exist locally or remotely"$'\n'""
file="bin/build/tools/git.sh"
fn="gitBranchExists"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Does a branch exist locally or remotely?"
usage="gitBranchExists branch ... [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitBranchExists[0m [38;2;255;255;0m[35;48;2;0;0;0mbranch ...[0m[0m [94m[ --help ][0m

    [31mbranch ...  [1;97mString. Required. List of branch names to check.[0m
    [94m--help      [1;97mFlag. Optional. Display this help.[0m

Does a branch exist locally or remotely?
Return Code: 0 - All branches passed exist
Return Code: 1 - At least one branch does not exist locally or remotely

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchExists branch ... [ --help ]

    branch ...  String. Required. List of branch names to check.
    --help      Flag. Optional. Display this help.

Does a branch exist locally or remotely?
Return Code: 0 - All branches passed exist
Return Code: 1 - At least one branch does not exist locally or remotely

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
