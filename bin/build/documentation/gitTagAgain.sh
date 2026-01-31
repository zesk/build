#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="tag - String. Optional. The tag to tag again."$'\n'""
base="git.sh"
description="Remove a tag everywhere and tag again on the current branch"$'\n'""
file="bin/build/tools/git.sh"
rawComment="Remove a tag everywhere and tag again on the current branch"$'\n'"Argument: tag - String. Optional. The tag to tag again."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="6ddead0079491da7c7f55886b428a38512863e13"
summary="Remove a tag everywhere and tag again on the current"
summaryComputed="true"
usage="gitTagAgain [ tag ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitTagAgain'$'\e''[0m '$'\e''[[(blue)]m[ tag ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mtag  '$'\e''[[(value)]mString. Optional. The tag to tag again.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove a tag everywhere and tag again on the current branch'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitTagAgain [ tag ]'$'\n'''$'\n''    tag  String. Optional. The tag to tag again.'$'\n'''$'\n''Remove a tag everywhere and tag again on the current branch'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 3.088
