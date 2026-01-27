#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/github.sh"
argument="projectName - String. Required. Github project name in the form of \`owner/repository\`"$'\n'""
base="github.sh"
description="Get the latest JSON structure"$'\n'""
environment="GITHUB_ACCESS_TOKEN"$'\n'""
file="bin/build/tools/github.sh"
foundNames=([0]="argument" [1]="environment")
rawComment="Get the latest JSON structure"$'\n'"Argument: projectName - String. Required. Github project name in the form of \`owner/repository\`"$'\n'"Environment: GITHUB_ACCESS_TOKEN"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceModified="1769323931"
summary="Get the latest JSON structure"
usage="githubLatest projectName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgithubLatest'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mprojectName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mprojectName  '$'\e''[[(value)]mString. Required. Github project name in the form of '$'\e''[[(code)]mowner/repository'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Get the latest JSON structure'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- GITHUB_ACCESS_TOKEN'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: githubLatest projectName'$'\n'''$'\n''    projectName  String. Required. Github project name in the form of owner/repository'$'\n'''$'\n''Get the latest JSON structure'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- GITHUB_ACCESS_TOKEN'$'\n'''
# elapsed 0.583
