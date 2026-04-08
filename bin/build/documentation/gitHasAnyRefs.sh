#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Do any tags exist at all in \`git\`?"$'\n'"May need to \`git pull --tags\`, or no tags exist."$'\n'""
file="bin/build/tools/git.sh"
fn="gitHasAnyRefs"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
rawComment="Summary: Does git have any tags?"$'\n'"Do any tags exist at all in \`git\`?"$'\n'"May need to \`git pull --tags\`, or no tags exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - At least one tag exists"$'\n'"Return Code: 1 - No tags exist"$'\n'""$'\n'""
return_code="0 - At least one tag exists"$'\n'"1 - No tags exist"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="ef317634b04a01c8ac47c9c01567340a86b0e4b6"
summary="Does git have any tags?"$'\n'""
usage="gitHasAnyRefs [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitHasAnyRefs'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Do any tags exist at all in '$'\e''[[(code)]mgit'$'\e''[[(reset)]m?'$'\n''May need to '$'\e''[[(code)]mgit pull --tags'$'\e''[[(reset)]m, or no tags exist.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - At least one tag exists'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No tags exist'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitHasAnyRefs [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Do any tags exist at all in git?'$'\n''May need to git pull --tags, or no tags exist.'$'\n'''$'\n''Return codes:'$'\n''- 0 - At least one tag exists'$'\n''- 1 - No tags exist'$'\n'''
