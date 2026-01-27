#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="branch ... - String. Required. List of branch names to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Does a branch exist locally or remotely?"$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Does a branch exist locally or remotely?"$'\n'"Argument: branch ... - String. Required. List of branch names to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All branches passed exist"$'\n'"Return Code: 1 - At least one branch does not exist locally or remotely"$'\n'""$'\n'""
return_code="0 - All branches passed exist"$'\n'"1 - At least one branch does not exist locally or remotely"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769199547"
summary="Does a branch exist locally or remotely?"
usage="gitBranchExists branch ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitBranchExists'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbranch ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbranch ...  '$'\e''[[(value)]mString. Required. List of branch names to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Does a branch exist locally or remotely?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All branches passed exist'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - At least one branch does not exist locally or remotely'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchExists branch ... [ --help ]'$'\n'''$'\n''    branch ...  String. Required. List of branch names to check.'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Does a branch exist locally or remotely?'$'\n'''$'\n''Return codes:'$'\n''- 0 - All branches passed exist'$'\n''- 1 - At least one branch does not exist locally or remotely'$'\n'''
# elapsed 0.44
