#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="tag - String. Optional. The tag to tag again."$'\n'""
base="git.sh"
description="Remove a tag everywhere and tag again on the current branch"$'\n'""
exitCode="0"
file="bin/build/tools/git.sh"
foundNames=([0]="argument")
rawComment="Remove a tag everywhere and tag again on the current branch"$'\n'"Argument: tag - String. Optional. The tag to tag again."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769199547"
summary="Remove a tag everywhere and tag again on the current"
usage="gitTagAgain [ tag ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mgitTagAgain'$'\e''[0m '$'\e''[[blue]m[ tag ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mtag  '$'\e''[[value]mString. Optional. The tag to tag again.'$'\e''[[reset]m'$'\n'''$'\n''Remove a tag everywhere and tag again on the current branch'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitTagAgain [ tag ]'$'\n'''$'\n''    tag  String. Optional. The tag to tag again.'$'\n'''$'\n''Remove a tag everywhere and tag again on the current branch'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
