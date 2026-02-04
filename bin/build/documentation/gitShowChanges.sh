#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
credit="Chris Johnsen"$'\n'""
description="Show changed files from HEAD"$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="argument" [1]="return_code" [2]="source" [3]="credit")
rawComment="Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - the repo has been modified"$'\n'"Return Code: 1 - the repo has NOT bee modified"$'\n'"Show changed files from HEAD"$'\n'"Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'"Credit: Chris Johnsen"$'\n'""$'\n'""
return_code="0 - the repo has been modified"$'\n'"1 - the repo has NOT bee modified"$'\n'""
source="https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="6ddead0079491da7c7f55886b428a38512863e13"
summary="Show changed files from HEAD"
summaryComputed="true"
usage="gitShowChanges [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitShowChanges'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Show changed files from HEAD'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - the repo has been modified'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - the repo has NOT bee modified'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: gitShowChanges [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(blue)]m--help  Flag. Optional. Display this help.'$'\n'''$'\n''Show changed files from HEAD'$'\n'''$'\n''Return codes:'$'\n''- 0 - the repo has been modified'$'\n''- 1 - the repo has NOT bee modified'$'\n'''
