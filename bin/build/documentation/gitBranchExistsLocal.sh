#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="branch ... - String. Required. List of branch names to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Does a branch exist locally?"$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Does a branch exist locally?"$'\n'"Argument: branch ... - String. Required. List of branch names to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All branches exist"$'\n'"Return Code: 1 - At least one branch does not exist locally"$'\n'""$'\n'""
return_code="0 - All branches exist"$'\n'"1 - At least one branch does not exist locally"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="6ddead0079491da7c7f55886b428a38512863e13"
summary="Does a branch exist locally?"
summaryComputed="true"
usage="gitBranchExistsLocal branch ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitBranchExistsLocal'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbranch ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbranch ...  '$'\e''[[(value)]mString. Required. List of branch names to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Does a branch exist locally?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All branches exist'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - At least one branch does not exist locally'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchExistsLocal branch ... [ --help ]'$'\n'''$'\n''    branch ...  String. Required. List of branch names to check.'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Does a branch exist locally?'$'\n'''$'\n''Return codes:'$'\n''- 0 - All branches exist'$'\n''- 1 - At least one branch does not exist locally'$'\n'''
# elapsed 3.625
