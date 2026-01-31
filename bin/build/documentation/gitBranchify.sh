#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Check out a branch with the current version and optional formatting"$'\n'"\`BUILD_BRANCH_FORMAT\` is a string which can contain tokens in the form \`{user}\` and \`{version}\`"$'\n'"The default value is \`{version}-{user}\`"$'\n'"Environment: BUILD_BRANCH_FORMAT"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/git.sh"
foundNames=()
rawComment="Check out a branch with the current version and optional formatting"$'\n'"\`BUILD_BRANCH_FORMAT\` is a string which can contain tokens in the form \`{user}\` and \`{version}\`"$'\n'"The default value is \`{version}-{user}\`"$'\n'"Environment: BUILD_BRANCH_FORMAT"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="3d571e2d1ac61ab50aca59a14e16e0ada007496b"
summary="Check out a branch with the current version and optional"
usage="gitBranchify"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitBranchify'$'\e''[0m'$'\n'''$'\n''Check out a branch with the current version and optional formatting'$'\n'''$'\e''[[(code)]mBUILD_BRANCH_FORMAT'$'\e''[[(reset)]m is a string which can contain tokens in the form '$'\e''[[(code)]m{user}'$'\e''[[(reset)]m and '$'\e''[[(code)]m{version}'$'\e''[[(reset)]m'$'\n''The default value is '$'\e''[[(code)]m{version}-{user}'$'\e''[[(reset)]m'$'\n''Environment: BUILD_BRANCH_FORMAT'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchify'$'\n'''$'\n''Check out a branch with the current version and optional formatting'$'\n''BUILD_BRANCH_FORMAT is a string which can contain tokens in the form {user} and {version}'$'\n''The default value is {version}-{user}'$'\n''Environment: BUILD_BRANCH_FORMAT'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.515
