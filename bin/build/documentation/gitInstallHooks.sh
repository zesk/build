#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--copy - Flag. Optional. Copy the hook but do not execute it."$'\n'"--verbose - Flag. Optional. Be verbose about what is done."$'\n'"--application home - Directory. Optional. Set the application home directory to this prior to looking for hooks."$'\n'"hookName - String. Optional. A hook or hook names to install. See \`gitHookTypes\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install one or more git hooks from Zesk Build hooks."$'\n'"Zesk Build hooks are named \`git-hookName.sh\` in \`bin/hooks/\` so \`git-pre-commit.sh\` will be installed as the \`pre-commit\` hook for git."$'\n'""$'\n'"Hook types:"$'\n'"- \`pre-commit\`"$'\n'"- \`pre-push\`"$'\n'"- \`pre-merge-commit\`"$'\n'"- \`pre-rebase\`"$'\n'"- \`pre-receive\`"$'\n'"- \`update\`"$'\n'"- \`post-update\`"$'\n'"- \`post-commit\`"$'\n'""$'\n'""
descriptionLineCount="13"
file="bin/build/tools/git.sh"
fn="gitInstallHooks"
fnMarker="gitinstallhooks"
foundNames=([0]="argument" [1]="see")
line="747"
rawComment="Install one or more git hooks from Zesk Build hooks."$'\n'"Zesk Build hooks are named \`git-hookName.sh\` in \`bin/hooks/\` so \`git-pre-commit.sh\` will be installed as the \`pre-commit\` hook for git."$'\n'"Argument: --copy - Flag. Optional. Copy the hook but do not execute it."$'\n'"Argument: --verbose - Flag. Optional. Be verbose about what is done."$'\n'"Argument: --application home - Directory. Optional. Set the application home directory to this prior to looking for hooks."$'\n'"Argument: hookName - String. Optional. A hook or hook names to install. See \`gitHookTypes\`"$'\n'"Hook types:"$'\n'"- \`pre-commit\`"$'\n'"- \`pre-push\`"$'\n'"- \`pre-merge-commit\`"$'\n'"- \`pre-rebase\`"$'\n'"- \`pre-receive\`"$'\n'"- \`update\`"$'\n'"- \`post-update\`"$'\n'"- \`post-commit\`"$'\n'"See: gitHookTypes"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="gitHookTypes"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="747"
summary="Install one or more git hooks from Zesk Build hooks."
summaryComputed="true"
usage="gitInstallHooks [ --copy ] [ --verbose ] [ --application home ] [ hookName ] [ --help ]"
