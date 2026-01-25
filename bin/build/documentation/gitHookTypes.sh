#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="List current valid git hook types"$'\n'"Hook types:"$'\n'"- pre-commit"$'\n'"- pre-push"$'\n'"- pre-merge-commit"$'\n'"- pre-rebase"$'\n'"- pre-receive"$'\n'"- update"$'\n'"- post-update"$'\n'"- post-commit"$'\n'""
exitCode="0"
file="bin/build/tools/git.sh"
foundNames=([0]="output")
output="lines:gitHookType"$'\n'""
rawComment="List current valid git hook types"$'\n'"Output: lines:gitHookType"$'\n'"Hook types:"$'\n'"- pre-commit"$'\n'"- pre-push"$'\n'"- pre-merge-commit"$'\n'"- pre-rebase"$'\n'"- pre-receive"$'\n'"- update"$'\n'"- post-update"$'\n'"- post-commit"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769199547"
summary="List current valid git hook types"
usage="gitHookTypes"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mgitHookTypes'$'\e''[0m'$'\n'''$'\n''List current valid git hook types'$'\n''Hook types:'$'\n''- pre-commit'$'\n''- pre-push'$'\n''- pre-merge-commit'$'\n''- pre-rebase'$'\n''- pre-receive'$'\n''- update'$'\n''- post-update'$'\n''- post-commit'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitHookTypes'$'\n'''$'\n''List current valid git hook types'$'\n''Hook types:'$'\n''- pre-commit'$'\n''- pre-push'$'\n''- pre-merge-commit'$'\n''- pre-rebase'$'\n''- pre-receive'$'\n''- update'$'\n''- post-update'$'\n''- post-commit'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
