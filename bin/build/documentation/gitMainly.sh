#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Return Code: 1 - Already in main, staging, or HEAD, or git merge failed"$'\n'"Return Code: 0 - git merge succeeded"$'\n'"Merge \`staging\` and \`main\` branches of a git repository into the current branch."$'\n'"Will merge \`origin/staging\` and \`origin/main\` after doing a \`--pull\` for both of them"$'\n'"Current repository should be clean and have no modified files."$'\n'""
file="bin/build/tools/git.sh"
foundNames=()
rawComment="Return Code: 1 - Already in main, staging, or HEAD, or git merge failed"$'\n'"Return Code: 0 - git merge succeeded"$'\n'"Merge \`staging\` and \`main\` branches of a git repository into the current branch."$'\n'"Will merge \`origin/staging\` and \`origin/main\` after doing a \`--pull\` for both of them"$'\n'"Current repository should be clean and have no modified files."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="3d571e2d1ac61ab50aca59a14e16e0ada007496b"
summary="Return Code: 1 - Already in main, staging, or HEAD,"
usage="gitMainly"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitMainly'$'\e''[0m'$'\n'''$'\n''Return Code: 1 - Already in main, staging, or HEAD, or git merge failed'$'\n''Return Code: 0 - git merge succeeded'$'\n''Merge '$'\e''[[(code)]mstaging'$'\e''[[(reset)]m and '$'\e''[[(code)]mmain'$'\e''[[(reset)]m branches of a git repository into the current branch.'$'\n''Will merge '$'\e''[[(code)]morigin/staging'$'\e''[[(reset)]m and '$'\e''[[(code)]morigin/main'$'\e''[[(reset)]m after doing a '$'\e''[[(code)]m--pull'$'\e''[[(reset)]m for both of them'$'\n''Current repository should be clean and have no modified files.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitMainly'$'\n'''$'\n''Return Code: 1 - Already in main, staging, or HEAD, or git merge failed'$'\n''Return Code: 0 - git merge succeeded'$'\n''Merge staging and main branches of a git repository into the current branch.'$'\n''Will merge origin/staging and origin/main after doing a --pull for both of them'$'\n''Current repository should be clean and have no modified files.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.518
