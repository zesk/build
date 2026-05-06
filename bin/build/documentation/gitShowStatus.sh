#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
credit="Chris Johnsen"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Show changed files from HEAD with their status prefix character:"$'\n'""$'\n'"- ' ' = unmodified"$'\n'"- \`M\` = modified"$'\n'"- \`A\` = added"$'\n'"- \`D\` = deleted"$'\n'"- \`R\` = renamed"$'\n'"- \`C\` = copied"$'\n'"- \`U\` = updated but unmerged"$'\n'""$'\n'"(See \`man git\` for more details on status flags)"$'\n'""$'\n'""
descriptionLineCount="12"
file="bin/build/tools/git.sh"
fn="gitShowStatus"
fnMarker="gitshowstatus"
foundNames=([0]="argument" [1]="return_code" [2]="source" [3]="credit")
line="276"
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - the repo has been modified"$'\n'"Return Code: 1 - the repo has NOT bee modified"$'\n'"Show changed files from HEAD with their status prefix character:"$'\n'"- ' ' = unmodified"$'\n'"- \`M\` = modified"$'\n'"- \`A\` = added"$'\n'"- \`D\` = deleted"$'\n'"- \`R\` = renamed"$'\n'"- \`C\` = copied"$'\n'"- \`U\` = updated but unmerged"$'\n'"(See \`man git\` for more details on status flags)"$'\n'"Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'"Credit: Chris Johnsen"$'\n'""$'\n'""
return_code="0 - the repo has been modified"$'\n'"1 - the repo has NOT bee modified"$'\n'""
source="https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="276"
summary="Show changed files from HEAD with their status prefix character:"
summaryComputed="true"
usage="gitShowStatus [ --help ]"
