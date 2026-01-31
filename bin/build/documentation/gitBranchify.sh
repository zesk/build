#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Check out a branch with the current version and optional formatting"$'\n'"\`BUILD_BRANCH_FORMAT\` is a string which can contain tokens in the form \`{user}\` and \`{version}\`"$'\n'"The default value is \`{version}-{user}\`"$'\n'""
environment="BUILD_BRANCH_FORMAT"$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="environment" [1]="argument")
rawComment="Check out a branch with the current version and optional formatting"$'\n'"\`BUILD_BRANCH_FORMAT\` is a string which can contain tokens in the form \`{user}\` and \`{version}\`"$'\n'"The default value is \`{version}-{user}\`"$'\n'"Environment: BUILD_BRANCH_FORMAT"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="6ddead0079491da7c7f55886b428a38512863e13"
summary="Check out a branch with the current version and optional"
summaryComputed="true"
usage="gitBranchify [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitBranchify'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Check out a branch with the current version and optional formatting'$'\n'''$'\e''[[(code)]mBUILD_BRANCH_FORMAT'$'\e''[[(reset)]m is a string which can contain tokens in the form '$'\e''[[(code)]m{user}'$'\e''[[(reset)]m and '$'\e''[[(code)]m{version}'$'\e''[[(reset)]m'$'\n''The default value is '$'\e''[[(code)]m{version}-{user}'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_BRANCH_FORMAT'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchify [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Check out a branch with the current version and optional formatting'$'\n''BUILD_BRANCH_FORMAT is a string which can contain tokens in the form {user} and {version}'$'\n''The default value is {version}-{user}'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_BRANCH_FORMAT'$'\n'''
# elapsed 3.561
