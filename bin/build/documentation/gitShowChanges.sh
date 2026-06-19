#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="git.sh"
credit=$'Chris Johnsen\n'
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Show changed files from HEAD\n\n'
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitShowChanges"
fnMarker="gitshowchanges"
foundNames=([0]="argument" [1]="return_code" [2]="source" [3]="credit")
line="246"
rawComment=$'Argument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - the repo has been modified\nReturn Code: 1 - the repo has NOT bee modified\nShow changed files from HEAD\nSource: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339\nCredit: Chris Johnsen\n\n'
return_code=$'0 - the repo has been modified\n1 - the repo has NOT bee modified\n'
source=$'https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="5e91a5d4b3beafc28e8b01755133cb215bd453d8"
sourceLine="246"
summary="Show changed files from HEAD"
summaryComputed="true"
usage="gitShowChanges [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitShowChanges'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Show changed files from HEAD'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - the repo has been modified'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - the repo has NOT bee modified'
# shellcheck disable=SC2016
helpPlain='Usage: gitShowChanges [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Show changed files from HEAD'$'\n'''$'\n''Return codes:'$'\n''- 0 - the repo has been modified'$'\n''- 1 - the repo has NOT bee modified'
documentationPath="documentation/source/tools/git.md"
