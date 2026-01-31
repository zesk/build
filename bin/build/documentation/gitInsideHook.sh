#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="Are we currently inside a git hook?"$'\n'"Tests non-blank strings in our environment."$'\n'"Environment: GIT_EXEC_PATH - Must be set to pass"$'\n'"Environment: GIT_INDEX_FILE - Must be set to pass"$'\n'"Return Code: 0 - We are, semantically, inside a git hook"$'\n'"Return Code: 1 - We are NOT, semantically, inside a git hook"$'\n'""
file="bin/build/tools/git.sh"
foundNames=()
rawComment="Are we currently inside a git hook?"$'\n'"Tests non-blank strings in our environment."$'\n'"Environment: GIT_EXEC_PATH - Must be set to pass"$'\n'"Environment: GIT_INDEX_FILE - Must be set to pass"$'\n'"Return Code: 0 - We are, semantically, inside a git hook"$'\n'"Return Code: 1 - We are NOT, semantically, inside a git hook"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="3d571e2d1ac61ab50aca59a14e16e0ada007496b"
summary="Are we currently inside a git hook?"
usage="gitInsideHook"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitInsideHook'$'\e''[0m'$'\n'''$'\n''Are we currently inside a git hook?'$'\n''Tests non-blank strings in our environment.'$'\n''Environment: GIT_EXEC_PATH - Must be set to pass'$'\n''Environment: GIT_INDEX_FILE - Must be set to pass'$'\n''Return Code: 0 - We are, semantically, inside a git hook'$'\n''Return Code: 1 - We are NOT, semantically, inside a git hook'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitInsideHook'$'\n'''$'\n''Are we currently inside a git hook?'$'\n''Tests non-blank strings in our environment.'$'\n''Environment: GIT_EXEC_PATH - Must be set to pass'$'\n''Environment: GIT_INDEX_FILE - Must be set to pass'$'\n''Return Code: 0 - We are, semantically, inside a git hook'$'\n''Return Code: 1 - We are NOT, semantically, inside a git hook'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.476
