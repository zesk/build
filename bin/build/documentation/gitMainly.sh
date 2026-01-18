#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="Return Code: 1 - Already in main, staging, or HEAD, or git merge failed"$'\n'"Return Code: 0 - git merge succeeded"$'\n'"Merge \`staging\` and \`main\` branches of a git repository into the current branch."$'\n'""$'\n'"Will merge \`origin/staging\` and \`origin/main\` after doing a \`--pull\` for both of them"$'\n'""$'\n'"Current repository should be clean and have no modified files."$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitMainly"
foundNames=()
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Return Code: 1 - Already in main, staging, or HEAD,"
usage="gitMainly"
