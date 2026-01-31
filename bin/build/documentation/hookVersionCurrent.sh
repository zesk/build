#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="hooks.sh"
description="Application current version"$'\n'"Extracts the version from the repository"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --application application - Directory. Optional. Application home directory."$'\n'""
file="bin/build/tools/hooks.sh"
foundNames=()
rawComment="Application current version"$'\n'"Extracts the version from the repository"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --application application - Directory. Optional. Application home directory."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/hooks.sh"
sourceHash="e55e19a4ccb52eba046eab717a33086ae218bf14"
summary="Application current version"
usage="hookVersionCurrent"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhookVersionCurrent'$'\e''[0m'$'\n'''$'\n''Application current version'$'\n''Extracts the version from the repository'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --application application - Directory. Optional. Application home directory.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: hookVersionCurrent'$'\n'''$'\n''Application current version'$'\n''Extracts the version from the repository'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --application application - Directory. Optional. Application home directory.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.491
