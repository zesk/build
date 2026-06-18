#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Do any tags exist at all in `git`?\nMay need to `git pull --tags`, or no tags exist.\n\n'
descriptionLineCount="3"
file="bin/build/tools/git.sh"
fn="gitHasAnyRefs"
fnMarker="githasanyrefs"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="691"
rawComment=$'Summary: Does git have any tags?\nDo any tags exist at all in `git`?\nMay need to `git pull --tags`, or no tags exist.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - At least one tag exists\nReturn Code: 1 - No tags exist\n\n'
return_code=$'0 - At least one tag exists\n1 - No tags exist\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="a0d23919137c5539c67fd2fa09a1b037d4933cfd"
sourceLine="691"
summary="Does git have any tags?"
summaryComputed=""
usage="gitHasAnyRefs [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitHasAnyRefs'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Do any tags exist at all in '$'\e''[[(code)]mgit'$'\e''[[(reset)]m?'$'\n''May need to '$'\e''[[(code)]mgit pull --tags'$'\e''[[(reset)]m, or no tags exist.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - At least one tag exists'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No tags exist'
# shellcheck disable=SC2016
helpPlain='Usage: gitHasAnyRefs [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Do any tags exist at all in git?'$'\n''May need to git pull --tags, or no tags exist.'$'\n'''$'\n''Return codes:'$'\n''- 0 - At least one tag exists'$'\n''- 1 - No tags exist'
documentationPath="documentation/source/tools/git.md"
