#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="branch ... - String. Required. List of branch names to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Does a branch exist remotely?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitBranchExistsRemote"
fnMarker="gitbranchexistsremote"
foundNames=([0]="argument" [1]="return_code")
line="1062"
rawComment="Does a branch exist remotely?"$'\n'"Argument: branch ... - String. Required. List of branch names to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All branches exist on the remote"$'\n'"Return Code: 1 - At least one branch does not exist remotely"$'\n'""$'\n'""
return_code="0 - All branches exist on the remote"$'\n'"1 - At least one branch does not exist remotely"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="1062"
summary="Does a branch exist remotely?"
summaryComputed="true"
usage="gitBranchExistsRemote branch ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitBranchExistsRemote'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbranch ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbranch ...  '$'\e''[[(value)]mString. Required. List of branch names to check.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help      '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Does a branch exist remotely?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All branches exist on the remote'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - At least one branch does not exist remotely'
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchExistsRemote branch ... [ --help ]'$'\n'''$'\n''    branch ...  String. Required. List of branch names to check.'$'\n''    --help      Flag. Optional. Display this help.'$'\n'''$'\n''Does a branch exist remotely?'$'\n'''$'\n''Return codes:'$'\n''- 0 - All branches exist on the remote'$'\n''- 1 - At least one branch does not exist remotely'
documentationPath="documentation/source/tools/git.md"
