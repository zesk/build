#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Return Code: 1 - the repo has NOT been modified"$'\n'"Return Code: 0 - the repo has been modified"$'\n'"Has a git repository been changed from HEAD?"$'\n'"Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'"Credit: Chris Johnsen"$'\n'""
file="bin/build/tools/git.sh"
rawComment="Return Code: 1 - the repo has NOT been modified"$'\n'"Return Code: 0 - the repo has been modified"$'\n'"Has a git repository been changed from HEAD?"$'\n'"Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339"$'\n'"Credit: Chris Johnsen"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceHash="0d4d5f47dbc638a6a3fc43178a3954586bc34adf"
summary="Return Code: 1 - the repo has NOT been modified"
usage="gitRepositoryChanged"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitRepositoryChanged'$'\e''[0m'$'\n'''$'\n''Return Code: 1 - the repo has NOT been modified'$'\n''Return Code: 0 - the repo has been modified'$'\n''Has a git repository been changed from HEAD?'$'\n''Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339'$'\n''Credit: Chris Johnsen'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitRepositoryChanged'$'\n'''$'\n''Return Code: 1 - the repo has NOT been modified'$'\n''Return Code: 0 - the repo has been modified'$'\n''Has a git repository been changed from HEAD?'$'\n''Source: https://stackoverflow.com/questions/3882838/whats-an-easy-way-to-detect-modified-files-in-a-git-workspace/3899339#3899339'$'\n''Credit: Chris Johnsen'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.518
