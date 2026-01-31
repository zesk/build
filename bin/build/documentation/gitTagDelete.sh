#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Delete git tag locally and at origin"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: tag - The tag to delete locally and at origin"$'\n'"Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur."$'\n'""
file="bin/build/tools/git.sh"
rawComment="Delete git tag locally and at origin"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: tag - The tag to delete locally and at origin"$'\n'"Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceHash="0d4d5f47dbc638a6a3fc43178a3954586bc34adf"
summary="Delete git tag locally and at origin"
usage="gitTagDelete"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitTagDelete'$'\e''[0m'$'\n'''$'\n''Delete git tag locally and at origin'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: tag - The tag to delete locally and at origin'$'\n''Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitTagDelete'$'\n'''$'\n''Delete git tag locally and at origin'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: tag - The tag to delete locally and at origin'$'\n''Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.666
