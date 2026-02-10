#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-10
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"binary - String. Required. The binary to look for."$'\n'""
base="version.sh"
description="Check if something matches a version"$'\n'""
file="bin/build/tools/version.sh"
foundNames=([0]="argument")
rawComment="Check if something matches a version"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: binary - String. Required. The binary to look for."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceHash="7a78765522ff0f6d520a46d13938a5e77aabd972"
summary="Check if something matches a version"
summaryComputed="true"
usage="isVersion [ --help ] binary"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misVersion'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mbinary  '$'\e''[[(value)]mString. Required. The binary to look for.'$'\e''[[(reset)]m'$'\n'''$'\n''Check if something matches a version'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isVersion [ --help ] binary'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    binary  String. Required. The binary to look for.'$'\n'''$'\n''Check if something matches a version'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
