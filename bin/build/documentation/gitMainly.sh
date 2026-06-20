#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Merge `staging` and `main` branches of a git repository into the current branch.\n\nWill merge `origin/staging` and `origin/main` after doing a `--pull` for both of them\n\nCurrent repository should be clean and have no modified files.\n\n'
descriptionLineCount="6"
file="bin/build/tools/git.sh"
fn="gitMainly"
fnMarker="gitmainly"
foundNames=([0]="return_code")
line="572"
original="gitMainly"
rawComment=$'Return Code: 1 - Already in main, staging, or HEAD, or git merge failed\nReturn Code: 0 - git merge succeeded\nMerge `staging` and `main` branches of a git repository into the current branch.\nWill merge `origin/staging` and `origin/main` after doing a `--pull` for both of them\nCurrent repository should be clean and have no modified files.\n\n'
return_code=$'1 - Already in main, staging, or HEAD, or git merge failed\n0 - git merge succeeded\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="5e91a5d4b3beafc28e8b01755133cb215bd453d8"
sourceLine="572"
summary="Merge \`staging\` and \`main\` branches of a git repository into"
summaryComputed="true"
usage="gitMainly"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitMainly'$'\e''[0m'$'\n'''$'\n''Merge '$'\e''[[(code)]mstaging'$'\e''[[(reset)]m and '$'\e''[[(code)]mmain'$'\e''[[(reset)]m branches of a git repository into the current branch.'$'\n'''$'\n''Will merge '$'\e''[[(code)]morigin/staging'$'\e''[[(reset)]m and '$'\e''[[(code)]morigin/main'$'\e''[[(reset)]m after doing a '$'\e''[[(code)]m--pull'$'\e''[[(reset)]m for both of them'$'\n'''$'\n''Current repository should be clean and have no modified files.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Already in main, staging, or HEAD, or git merge failed'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - git merge succeeded'
# shellcheck disable=SC2016
helpPlain='Usage: gitMainly'$'\n'''$'\n''Merge staging and main branches of a git repository into the current branch.'$'\n'''$'\n''Will merge origin/staging and origin/main after doing a --pull for both of them'$'\n'''$'\n''Current repository should be clean and have no modified files.'$'\n'''$'\n''Return codes:'$'\n''- 1 - Already in main, staging, or HEAD, or git merge failed'$'\n''- 0 - git merge succeeded'
documentationPath="documentation/source/tools/git.md"
