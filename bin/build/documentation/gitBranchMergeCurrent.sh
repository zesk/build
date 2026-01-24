#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="branch - String. Required. Branch to merge the current branch with."$'\n'"--skip-ip - Boolean. Optional. Do not add the IP address to the comment."$'\n'"--comment - String. Optional. Comment for merge commit."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Merge the current branch with another, push to remote, and then return to the original branch."$'\n'""
exitCode="0"
file="bin/build/tools/git.sh"
foundNames=([0]="argument")
rawComment="Merge the current branch with another, push to remote, and then return to the original branch."$'\n'"Argument: branch - String. Required. Branch to merge the current branch with."$'\n'"Argument: --skip-ip - Boolean. Optional. Do not add the IP address to the comment."$'\n'"Argument: --comment - String. Optional. Comment for merge commit."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769199547"
summary="Merge the current branch with another, push to remote, and"
usage="gitBranchMergeCurrent branch [ --skip-ip ] [ --comment ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mgitBranchMergeCurrent'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mbranch'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ --skip-ip ]'$'\e''[0m '$'\e''[[blue]m[ --comment ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mbranch     '$'\e''[[value]mString. Required. Branch to merge the current branch with.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--skip-ip  '$'\e''[[value]mBoolean. Optional. Do not add the IP address to the comment.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--comment  '$'\e''[[value]mString. Optional. Comment for merge commit.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help     '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Merge the current branch with another, push to remote, and then return to the original branch.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchMergeCurrent branch [ --skip-ip ] [ --comment ] [ --help ]'$'\n'''$'\n''    branch     String. Required. Branch to merge the current branch with.'$'\n''    --skip-ip  Boolean. Optional. Do not add the IP address to the comment.'$'\n''    --comment  String. Optional. Comment for merge commit.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Merge the current branch with another, push to remote, and then return to the original branch.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
