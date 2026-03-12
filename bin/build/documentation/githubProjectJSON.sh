#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="none"
base="github.sh"
description="Get a project JSON structure"$'\n'""
environment="GITHUB_ACCESS_TOKEN"$'\n'""
file="bin/build/tools/github.sh"
fn="githubProjectJSON"
foundNames=([0]="environment")
rawComment="Get a project JSON structure"$'\n'"Environment: GITHUB_ACCESS_TOKEN"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceHash="7962d8fef2f900b93920c38d2ca4a10b9665956d"
summary="Get a project JSON structure"
summaryComputed="true"
usage="githubProjectJSON"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgithubProjectJSON'$'\e''[0m'$'\n'''$'\n''Get a project JSON structure'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- GITHUB_ACCESS_TOKEN'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: githubProjectJSON'$'\n'''$'\n''Get a project JSON structure'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- GITHUB_ACCESS_TOKEN'$'\n'''
