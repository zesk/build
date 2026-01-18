#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="List current valid git hook types"$'\n'"Hook types:"$'\n'"- pre-commit"$'\n'"- pre-push"$'\n'"- pre-merge-commit"$'\n'"- pre-rebase"$'\n'"- pre-receive"$'\n'"- update"$'\n'"- post-update"$'\n'"- post-commit"$'\n'""
file="bin/build/tools/git.sh"
fn="gitHookTypes"
foundNames=([0]="output")
output="lines:gitHookType"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768721470"
summary="List current valid git hook types"
usage="gitHookTypes"
