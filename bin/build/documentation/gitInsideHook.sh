#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="Are we currently inside a git hook?"$'\n'"Tests non-blank strings in our environment."$'\n'""
environment="GIT_EXEC_PATH - Must be set to pass"$'\n'"GIT_INDEX_FILE - Must be set to pass"$'\n'""
exitCode="0"
file="bin/build/tools/git.sh"
foundNames=([0]="environment" [1]="return_code")
rawComment="Are we currently inside a git hook?"$'\n'"Tests non-blank strings in our environment."$'\n'"Environment: GIT_EXEC_PATH - Must be set to pass"$'\n'"Environment: GIT_INDEX_FILE - Must be set to pass"$'\n'"Return Code: 0 - We are, semantically, inside a git hook"$'\n'"Return Code: 1 - We are NOT, semantically, inside a git hook"$'\n'""$'\n'""
return_code="0 - We are, semantically, inside a git hook"$'\n'"1 - We are NOT, semantically, inside a git hook"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769199547"
summary="Are we currently inside a git hook?"
usage="gitInsideHook"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mgitInsideHook'$'\e''[0m'$'\n'''$'\n''Are we currently inside a git hook?'$'\n''Tests non-blank strings in our environment.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - We are, semantically, inside a git hook'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - We are NOT, semantically, inside a git hook'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[code]mGIT_EXEC_PATH'$'\e''[[reset]m - Must be set to pass'$'\n''- '$'\e''[[code]mGIT_INDEX_FILE'$'\e''[[reset]m - Must be set to pass'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitInsideHook'$'\n'''$'\n''Are we currently inside a git hook?'$'\n''Tests non-blank strings in our environment.'$'\n'''$'\n''Return codes:'$'\n''- 0 - We are, semantically, inside a git hook'$'\n''- 1 - We are NOT, semantically, inside a git hook'$'\n'''$'\n''Environment variables:'$'\n''- GIT_EXEC_PATH - Must be set to pass'$'\n''- GIT_INDEX_FILE - Must be set to pass'$'\n'''
