#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="branch - String. Required. Branch to merge the current branch with."$'\n'"--skip-ip - Boolean. Optional. Do not add the IP address to the comment."$'\n'"--comment - String. Optional. Comment for merge commit."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Merge the current branch with another, push to remote, and then return to the original branch."$'\n'""
file="bin/build/tools/git.sh"
fn="gitBranchMergeCurrent"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Merge the current branch with another, push to remote, and"
usage="gitBranchMergeCurrent branch [ --skip-ip ] [ --comment ] [ --help ]"
