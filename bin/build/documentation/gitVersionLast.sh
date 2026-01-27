#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="ignorePattern - Optional. String. Specify a grep pattern to ignore; allows you to ignore current version"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Get the last reported version."$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="argument")
rawComment="Get the last reported version."$'\n'"Argument: ignorePattern - Optional. String. Specify a grep pattern to ignore; allows you to ignore current version"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769199547"
summary="Get the last reported version."
usage="gitVersionLast [ ignorePattern ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitVersionLast'$'\e''[0m '$'\e''[[(blue)]m[ ignorePattern ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mignorePattern  '$'\e''[[(value)]mOptional. String. Specify a grep pattern to ignore; allows you to ignore current version'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the last reported version.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitVersionLast [ ignorePattern ] [ --help ]'$'\n'''$'\n''    ignorePattern  Optional. String. Specify a grep pattern to ignore; allows you to ignore current version'$'\n''    --help         Flag. Optional. Display this help.'$'\n'''$'\n''Get the last reported version.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.444
