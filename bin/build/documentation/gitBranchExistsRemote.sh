#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="branch ... - String. Required. List of branch names to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Does a branch exist remotely?"$'\n'""
file="bin/build/tools/git.sh"
fn="gitBranchExistsRemote"
foundNames=([0]="argument" [1]="return_code")
line="1063"
lowerFn="gitbranchexistsremote"
rawComment="Does a branch exist remotely?"$'\n'"Argument: branch ... - String. Required. List of branch names to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All branches exist on the remote"$'\n'"Return Code: 1 - At least one branch does not exist remotely"$'\n'""$'\n'""
return_code="0 - All branches exist on the remote"$'\n'"1 - At least one branch does not exist remotely"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="ef317634b04a01c8ac47c9c01567340a86b0e4b6"
sourceLine="1063"
summary="Does a branch exist remotely?"
summaryComputed="true"
usage="gitBranchExistsRemote branch ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitBranchExistsRemote'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbranch ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbranch ...  '$'\e''[[(value)]mString. Required. List of branch names to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Does a branch exist remotely?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All branches exist on the remote'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - At least one branch does not exist remotely'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchExistsRemote branch ... [ --help ]'$'\n'''$'\n''    branch ...  String. Required. List of branch names to check.'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Does a branch exist remotely?'$'\n'''$'\n''Return codes:'$'\n''- 0 - All branches exist on the remote'$'\n''- 1 - At least one branch does not exist remotely'$'\n'''
documentationPath="documentation/source/tools/git.md"
