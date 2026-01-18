#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--copy - Flag. Optional. Copy the hook but do not execute it."$'\n'"--verbose - Flag. Optional. Be verbose about what is done."$'\n'"--application home - Directory. Optional. Set the application home directory to this prior to looking for hooks."$'\n'"hookName - String. Optional. A hook or hook names to install. See \`gitHookTypes\`"$'\n'""
base="git.sh"
description="Install one or more git hooks from Zesk Build hooks."$'\n'"Zesk Build hooks are named \`git-hookName.sh\` in \`bin/hooks/\` so \`git-pre-commit.sh\` will be installed as the \`pre-commit\` hook for git."$'\n'""$'\n'"Hook types:"$'\n'"- pre-commit"$'\n'"- pre-push"$'\n'"- pre-merge-commit"$'\n'"- pre-rebase"$'\n'"- pre-receive"$'\n'"- update"$'\n'"- post-update"$'\n'"- post-commit"$'\n'""
file="bin/build/tools/git.sh"
fn="gitInstallHooks"
foundNames=([0]="argument" [1]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="gitHookTypes"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Install one or more git hooks from Zesk Build hooks."
usage="gitInstallHooks [ --copy ] [ --verbose ] [ --application home ] [ hookName ]"
