#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List current valid git hook types"$'\n'"Hook types:"$'\n'"- \`pre-commit\`"$'\n'"- \`pre-push\`"$'\n'"- \`pre-merge-commit\`"$'\n'"- \`pre-rebase\`"$'\n'"- \`pre-receive\`"$'\n'"- \`update\`"$'\n'"- \`post-update\`"$'\n'"- \`post-commit\`"$'\n'""$'\n'""
descriptionLineCount="11"
file="bin/build/tools/git.sh"
fn="gitHookTypes"
fnMarker="githooktypes"
foundNames=([0]="output" [1]="argument")
line="718"
output="lines:gitHookType"$'\n'""
rawComment="List current valid git hook types"$'\n'"Output: lines:gitHookType"$'\n'"Hook types:"$'\n'"- \`pre-commit\`"$'\n'"- \`pre-push\`"$'\n'"- \`pre-merge-commit\`"$'\n'"- \`pre-rebase\`"$'\n'"- \`pre-receive\`"$'\n'"- \`update\`"$'\n'"- \`post-update\`"$'\n'"- \`post-commit\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="718"
summary="List current valid git hook types"
summaryComputed="true"
usage="gitHookTypes [ --help ]"
