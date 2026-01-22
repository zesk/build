#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="branch - String. Required. Branch to merge the current branch with."$'\n'"--skip-ip - Boolean. Optional. Do not add the IP address to the comment."$'\n'"--comment - String. Optional. Comment for merge commit."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Merge the current branch with another, push to remote, and then return to the original branch."$'\n'""
file="bin/build/tools/git.sh"
fn="gitBranchMergeCurrent"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769063211"
summary="Merge the current branch with another, push to remote, and"
usage="gitBranchMergeCurrent branch [ --skip-ip ] [ --comment ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitBranchMergeCurrent[0m [38;2;255;255;0m[35;48;2;0;0;0mbranch[0m[0m [94m[ --skip-ip ][0m [94m[ --comment ][0m [94m[ --help ][0m

    [31mbranch     [1;97mString. Required. Branch to merge the current branch with.[0m
    [94m--skip-ip  [1;97mBoolean. Optional. Do not add the IP address to the comment.[0m
    [94m--comment  [1;97mString. Optional. Comment for merge commit.[0m
    [94m--help     [1;97mFlag. Optional. Display this help.[0m

Merge the current branch with another, push to remote, and then return to the original branch.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchMergeCurrent branch [ --skip-ip ] [ --comment ] [ --help ]

    branch     String. Required. Branch to merge the current branch with.
    --skip-ip  Boolean. Optional. Do not add the IP address to the comment.
    --comment  String. Optional. Comment for merge commit.
    --help     Flag. Optional. Display this help.

Merge the current branch with another, push to remote, and then return to the original branch.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
