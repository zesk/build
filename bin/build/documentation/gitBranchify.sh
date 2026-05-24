#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Check out a branch with the current version and optional formatting\n\n`BUILD_BRANCH_FORMAT` is a string which can contain tokens in the form `{user}` and `{version}`\n\nThe default value is `{version}-{user}`\n\n'
descriptionLineCount="6"
environment=$'BUILD_BRANCH_FORMAT\n'
file="bin/build/tools/git.sh"
fn="gitBranchify"
fnMarker="gitbranchify"
foundNames=([0]="environment" [1]="argument")
line="1093"
rawComment=$'Check out a branch with the current version and optional formatting\n`BUILD_BRANCH_FORMAT` is a string which can contain tokens in the form `{user}` and `{version}`\nThe default value is `{version}-{user}`\nEnvironment: BUILD_BRANCH_FORMAT\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="1093"
summary="Check out a branch with the current version and optional"
summaryComputed="true"
usage="gitBranchify [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitBranchify'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Check out a branch with the current version and optional formatting'$'\n'''$'\n'''$'\e''[[(code)]mBUILD_BRANCH_FORMAT'$'\e''[[(reset)]m is a string which can contain tokens in the form '$'\e''[[(code)]m{user}'$'\e''[[(reset)]m and '$'\e''[[(code)]m{version}'$'\e''[[(reset)]m'$'\n'''$'\n''The default value is '$'\e''[[(code)]m{version}-{user}'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_BRANCH_FORMAT'
# shellcheck disable=SC2016
helpPlain='Usage: gitBranchify [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Check out a branch with the current version and optional formatting'$'\n'''$'\n''BUILD_BRANCH_FORMAT is a string which can contain tokens in the form {user} and {version}'$'\n'''$'\n''The default value is {version}-{user}'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_BRANCH_FORMAT'
documentationPath="documentation/source/tools/git.md"
