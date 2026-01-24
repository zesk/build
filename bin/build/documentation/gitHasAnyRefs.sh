#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="Does git have any tags?"$'\n'"May need to \`git pull --tags\`, or no tags exist."$'\n'""
exitCode="0"
file="bin/build/tools/git.sh"
foundNames=()
rawComment="Does git have any tags?"$'\n'"May need to \`git pull --tags\`, or no tags exist."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769199547"
summary="Does git have any tags?"
usage="gitHasAnyRefs"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mgitHasAnyRefs'$'\e''[0m'$'\n'''$'\n''Does git have any tags?'$'\n''May need to '$'\e''[[code]mgit pull --tags'$'\e''[[reset]m, or no tags exist.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitHasAnyRefs'$'\n'''$'\n''Does git have any tags?'$'\n''May need to git pull --tags, or no tags exist.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
