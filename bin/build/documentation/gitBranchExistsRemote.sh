#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Does a branch exist remotely?"$'\n'"Argument: branch ... - String. Required. List of branch names to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All branches exist on the remote"$'\n'"Return Code: 1 - At least one branch does not exist remotely"$'\n'""
file="bin/build/tools/git.sh"
foundNames=()
rawComment="Does a branch exist remotely?"$'\n'"Argument: branch ... - String. Required. List of branch names to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - All branches exist on the remote"$'\n'"Return Code: 1 - At least one branch does not exist remotely"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="3d571e2d1ac61ab50aca59a14e16e0ada007496b"
summary="Does a branch exist remotely?"
usage="gitBranchExistsRemote"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitBranchExistsRemote'$'\e''[0m'$'\n'''$'\n''Does a branch exist remotely?'$'\n''Argument: branch ... - String. Required. List of branch names to check.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - All branches exist on the remote'$'\n''Return Code: 1 - At least one branch does not exist remotely'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchExistsRemote'$'\n'''$'\n''Does a branch exist remotely?'$'\n''Argument: branch ... - String. Required. List of branch names to check.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - All branches exist on the remote'$'\n''Return Code: 1 - At least one branch does not exist remotely'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.476
