#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="branch ... - String. Required. List of branch names to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Does a branch exist remotely?"$'\n'"Return Code: 0 - All branches exist on the remote"$'\n'"Return Code: 1 - At least one branch does not exist remotely"$'\n'""
file="bin/build/tools/git.sh"
fn="gitBranchExistsRemote"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768721470"
summary="Does a branch exist remotely?"
usage="gitBranchExistsRemote branch ... [ --help ]"
