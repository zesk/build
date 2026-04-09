#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="path.sh"
description="Cleans the path and removes non-directory entries and duplicates"$'\n'"Maintains ordering."$'\n'""
environment="PATH"$'\n'""
file="bin/build/tools/path.sh"
fn="pathCleanDuplicates"
foundNames=([0]="argument" [1]="environment")
line="95"
lowerFn="pathcleanduplicates"
rawComment="Cleans the path and removes non-directory entries and duplicates"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Maintains ordering."$'\n'"Environment: PATH"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/path.sh"
sourceHash="ef619ed0883f30842aea5824d3041921d03f400f"
sourceLine="95"
summary="Cleans the path and removes non-directory entries and duplicates"
summaryComputed="true"
usage="pathCleanDuplicates [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpathCleanDuplicates'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Cleans the path and removes non-directory entries and duplicates'$'\n''Maintains ordering.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- PATH'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pathCleanDuplicates [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Cleans the path and removes non-directory entries and duplicates'$'\n''Maintains ordering.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- PATH'$'\n'''
documentationPath="documentation/source/tools/path.md"
