#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Merge \`staging\` and \`main\` branches of a git repository into the current branch."$'\n'""$'\n'"Will merge \`origin/staging\` and \`origin/main\` after doing a \`--pull\` for both of them"$'\n'""$'\n'"Current repository should be clean and have no modified files."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/git.sh"
fn="gitMainly"
fnMarker="gitmainly"
foundNames=([0]="return_code")
line="572"
rawComment="Return Code: 1 - Already in main, staging, or HEAD, or git merge failed"$'\n'"Return Code: 0 - git merge succeeded"$'\n'"Merge \`staging\` and \`main\` branches of a git repository into the current branch."$'\n'"Will merge \`origin/staging\` and \`origin/main\` after doing a \`--pull\` for both of them"$'\n'"Current repository should be clean and have no modified files."$'\n'""$'\n'""
return_code="1 - Already in main, staging, or HEAD, or git merge failed"$'\n'"0 - git merge succeeded"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="572"
summary="Merge \`staging\` and \`main\` branches of a git repository into"
summaryComputed="true"
usage="gitMainly"
