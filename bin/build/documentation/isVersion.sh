#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="version.sh"
description="Check if something matches a version"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: binary - String. Required. The binary to look for."$'\n'""
file="bin/build/tools/version.sh"
foundNames=()
rawComment="Check if something matches a version"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: binary - String. Required. The binary to look for."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceHash="d77afda1e8e2f6fc82e83a8aab8cb537d29f8c0e"
summary="Check if something matches a version"
usage="isVersion"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misVersion'$'\e''[0m'$'\n'''$'\n''Check if something matches a version'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: binary - String. Required. The binary to look for.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isVersion'$'\n'''$'\n''Check if something matches a version'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: binary - String. Required. The binary to look for.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.426
