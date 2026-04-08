#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="List current valid git hook types"$'\n'"Hook types:"$'\n'"- \`pre-commit\`"$'\n'"- \`pre-push\`"$'\n'"- \`pre-merge-commit\`"$'\n'"- \`pre-rebase\`"$'\n'"- \`pre-receive\`"$'\n'"- \`update\`"$'\n'"- \`post-update\`"$'\n'"- \`post-commit\`"$'\n'""
file="bin/build/tools/git.sh"
fn="gitHookTypes"
foundNames=([0]="output" [1]="argument")
output="lines:gitHookType"$'\n'""
rawComment="List current valid git hook types"$'\n'"Output: lines:gitHookType"$'\n'"Hook types:"$'\n'"- \`pre-commit\`"$'\n'"- \`pre-push\`"$'\n'"- \`pre-merge-commit\`"$'\n'"- \`pre-rebase\`"$'\n'"- \`pre-receive\`"$'\n'"- \`update\`"$'\n'"- \`post-update\`"$'\n'"- \`post-commit\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="ef317634b04a01c8ac47c9c01567340a86b0e4b6"
summary="List current valid git hook types"
summaryComputed="true"
usage="gitHookTypes [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitHookTypes'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''List current valid git hook types'$'\n''Hook types:'$'\n''- '$'\e''[[(code)]mpre-commit'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpre-push'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpre-merge-commit'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpre-rebase'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpre-receive'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mupdate'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpost-update'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mpost-commit'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitHookTypes [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''List current valid git hook types'$'\n''Hook types:'$'\n''- pre-commit'$'\n''- pre-push'$'\n''- pre-merge-commit'$'\n''- pre-rebase'$'\n''- pre-receive'$'\n''- update'$'\n''- post-update'$'\n''- post-commit'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
