#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Delete git tag locally and at origin"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: tag - The tag to delete locally and at origin"$'\n'"Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur."$'\n'""
file="bin/build/tools/git.sh"
foundNames=()
rawComment="Delete git tag locally and at origin"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: tag - The tag to delete locally and at origin"$'\n'"Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="3d571e2d1ac61ab50aca59a14e16e0ada007496b"
summary="Delete git tag locally and at origin"
usage="gitTagDelete"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitTagDelete'$'\e''[0m'$'\n'''$'\n''Delete git tag locally and at origin'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: tag - The tag to delete locally and at origin'$'\n''Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitTagDelete'$'\n'''$'\n''Delete git tag locally and at origin'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: tag - The tag to delete locally and at origin'$'\n''Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.458
