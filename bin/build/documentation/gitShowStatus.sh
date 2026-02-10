#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-10
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
credit="Chris Johnsen"$'\n'""
description="Show changed files from HEAD with their status prefix character:"$'\n'"- ' ' = unmodified"$'\n'"- \`M\` = modified"$'\n'"- \`A\` = added"$'\n'"- \`D\` = deleted"$'\n'"- \`R\` = renamed"$'\n'"- \`C\` = copied"$'\n'"- \`U\` = updated but unmerged"$'\n'"(See \`man git\` for more details on status flags)"$'\n'""
file="bin/build/tools/git.sh"
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - the repo has been modified"$'\n'"Return Code: 1 - the repo has NOT bee modified"$'\n'"Show changed files from HEAD with their status prefix character:"$'\n'"- ' ' = unmodified"$'\n'"- \`M\` = modified"$'\n'"- \`A\` = added"$'\n'"- \`D\` = deleted"$'\n'"- \`R\` = renamed"$'\n'"- \`C\` = copied"$'\n'"- \`U\` = updated but unmerged"$'\n'"(See \`man git\` for more details on status flags)"$'\n'"Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'"Credit: Chris Johnsen"$'\n'""$'\n'""
return_code="0 - the repo has been modified"$'\n'"1 - the repo has NOT bee modified"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="d861975b11d1fbf7234ff66f942c86779f09fac7"
summary="Show changed files from HEAD with their status prefix character:"
summaryComputed="true"
usage="gitShowStatus [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitShowStatus'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Show changed files from HEAD with their status prefix character:'$'\n''- '\'' '\'' = unmodified'$'\n''- '$'\e''[[(code)]mM'$'\e''[[(reset)]m = modified'$'\n''- '$'\e''[[(code)]mA'$'\e''[[(reset)]m = added'$'\n''- '$'\e''[[(code)]mD'$'\e''[[(reset)]m = deleted'$'\n''- '$'\e''[[(code)]mR'$'\e''[[(reset)]m = renamed'$'\n''- '$'\e''[[(code)]mC'$'\e''[[(reset)]m = copied'$'\n''- '$'\e''[[(code)]mU'$'\e''[[(reset)]m = updated but unmerged'$'\n''(See '$'\e''[[(code)]mman git'$'\e''[[(reset)]m for more details on status flags)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - the repo has been modified'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - the repo has NOT bee modified'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitShowStatus [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Show changed files from HEAD with their status prefix character:'$'\n''- '\'' '\'' = unmodified'$'\n''- M = modified'$'\n''- A = added'$'\n''- D = deleted'$'\n''- R = renamed'$'\n''- C = copied'$'\n''- U = updated but unmerged'$'\n''(See man git for more details on status flags)'$'\n'''$'\n''Return codes:'$'\n''- 0 - the repo has been modified'$'\n''- 1 - the repo has NOT bee modified'$'\n'''
