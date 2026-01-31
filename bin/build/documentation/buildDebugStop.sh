#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="debug.sh"
description="Stop build debugging if it is enabled"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="see" [1]="requires" [2]="argument")
rawComment="Stop build debugging if it is enabled"$'\n'"See: buildDebugStart"$'\n'"Requires: buildDebugEnabled"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
requires="buildDebugEnabled"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildDebugStart"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="a904ac31e55b57261f1d3e3fb6c67407a1f69618"
summary="Stop build debugging if it is enabled"
summaryComputed="true"
usage="buildDebugStop [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildDebugStop'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Stop build debugging if it is enabled'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mbuildDebugStop [ --help ]'$'\n'''$'\n''    --help  [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Stop build debugging if it is enabled'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
