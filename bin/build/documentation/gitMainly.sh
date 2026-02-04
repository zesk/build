#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Merge \`staging\` and \`main\` branches of a git repository into the current branch."$'\n'"Will merge \`origin/staging\` and \`origin/main\` after doing a \`--pull\` for both of them"$'\n'"Current repository should be clean and have no modified files."$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="return_code")
rawComment="Return Code: 1 - Already in main, staging, or HEAD, or git merge failed"$'\n'"Return Code: 0 - git merge succeeded"$'\n'"Merge \`staging\` and \`main\` branches of a git repository into the current branch."$'\n'"Will merge \`origin/staging\` and \`origin/main\` after doing a \`--pull\` for both of them"$'\n'"Current repository should be clean and have no modified files."$'\n'""$'\n'""
return_code="1 - Already in main, staging, or HEAD, or git merge failed"$'\n'"0 - git merge succeeded"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="6ddead0079491da7c7f55886b428a38512863e13"
summary="Merge \`staging\` and \`main\` branches of a git repository into"
summaryComputed="true"
usage="gitMainly"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitMainly'$'\e''[0m'$'\n'''$'\n''Merge '$'\e''[[(code)]mstaging'$'\e''[[(reset)]m and '$'\e''[[(code)]mmain'$'\e''[[(reset)]m branches of a git repository into the current branch.'$'\n''Will merge '$'\e''[[(code)]morigin/staging'$'\e''[[(reset)]m and '$'\e''[[(code)]morigin/main'$'\e''[[(reset)]m after doing a '$'\e''[[(code)]m--pull'$'\e''[[(reset)]m for both of them'$'\n''Current repository should be clean and have no modified files.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Already in main, staging, or HEAD, or git merge failed'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - git merge succeeded'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitMainly'$'\n'''$'\n''Merge staging and main branches of a git repository into the current branch.'$'\n''Will merge origin/staging and origin/main after doing a --pull for both of them'$'\n''Current repository should be clean and have no modified files.'$'\n'''$'\n''Return codes:'$'\n''- 1 - Already in main, staging, or HEAD, or git merge failed'$'\n''- 0 - git merge succeeded'$'\n'''
