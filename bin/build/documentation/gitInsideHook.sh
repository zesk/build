#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="Are we currently inside a git hook?"$'\n'""$'\n'"Tests non-blank strings in our environment."$'\n'""$'\n'"Return Code: 0 - We are, semantically, inside a git hook"$'\n'"Return Code: 1 - We are NOT, semantically, inside a git hook"$'\n'""$'\n'""
environment="GIT_EXEC_PATH - Must be set to pass"$'\n'"GIT_INDEX_FILE - Must be set to pass"$'\n'""
file="bin/build/tools/git.sh"
fn="gitInsideHook"
foundNames=([0]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768695708"
summary="Are we currently inside a git hook?"
usage="gitInsideHook"
