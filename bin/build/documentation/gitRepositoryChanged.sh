#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-10
# shellcheck disable=SC2034
argument="none"
base="git.sh"
credit="Chris Johnsen"$'\n'""
description="Has a git repository been changed from HEAD?"$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="return_code" [1]="source" [2]="credit")
rawComment="Return Code: 1 - the repo has NOT been modified"$'\n'"Return Code: 0 - the repo has been modified"$'\n'"Has a git repository been changed from HEAD?"$'\n'"Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'"Credit: Chris Johnsen"$'\n'""$'\n'""
return_code="1 - the repo has NOT been modified"$'\n'"0 - the repo has been modified"$'\n'""
source="https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="1c51d81ea9e59d2e079d5ba420ada503a43bd31a"
summary="Has a git repository been changed from HEAD?"
summaryComputed="true"
usage="gitRepositoryChanged"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitRepositoryChanged'$'\e''[0m'$'\n'''$'\n''Has a git repository been changed from HEAD?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - the repo has NOT been modified'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - the repo has been modified'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitRepositoryChanged'$'\n'''$'\n''Has a git repository been changed from HEAD?'$'\n'''$'\n''Return codes:'$'\n''- 1 - the repo has NOT been modified'$'\n''- 0 - the repo has been modified'$'\n'''
