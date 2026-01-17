#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'""
base="git.sh"
credit="Chris Johnsen"$'\n'""
description="Return Code: 0 - the repo has been modified"$'\n'"Return Code: 1 - the repo has NOT bee modified"$'\n'""$'\n'"Show changed files from HEAD with their status prefix character:"$'\n'""$'\n'"- ' ' = unmodified"$'\n'"- \`M\` = modified"$'\n'"- \`A\` = added"$'\n'"- \`D\` = deleted"$'\n'"- \`R\` = renamed"$'\n'"- \`C\` = copied"$'\n'"- \`U\` = updated but unmerged"$'\n'""$'\n'"(See \`man git\` for more details on status flags)"$'\n'""$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitShowStatus"
foundNames=([0]="argument" [1]="source" [2]="credit")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768683853"
summary="Return Code: 0 - the repo has been modified"
usage="gitShowStatus [ --help ]"
