#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="core.sh"
description="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\` to calculate"$'\n'""
environment="BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors."$'\n'""
file="bin/build/tools/decorate/core.sh"
foundNames=([0]="argument" [1]="return_code" [2]="environment" [3]="requires")
rawComment="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\` to calculate"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Console or output supports colors"$'\n'"Return Code: 1 - Colors are likely not supported by console"$'\n'"Environment: BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors."$'\n'"Requires: isPositiveInteger tput"$'\n'""$'\n'""
requires="isPositiveInteger tput"$'\n'""
return_code="0 - Console or output supports colors"$'\n'"1 - Colors are likely not supported by console"$'\n'""
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="4e888a942dbc9f76fbb741ff39b1f642beb8541d"
summary="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\`"
summaryComputed="true"
usage="consoleHasColors [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleHasColors'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Sets the environment variable '$'\e''[[(code)]mBUILD_COLORS'$'\e''[[(reset)]m if not set, uses '$'\e''[[(code)]mTERM'$'\e''[[(reset)]m to calculate'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Console or output supports colors'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Colors are likely not supported by console'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mBUILD_COLORS'$'\e''[[(reset)]m - Boolean. Optional. Whether the build system will output ANSI colors.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleHasColors [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Sets the environment variable BUILD_COLORS if not set, uses TERM to calculate'$'\n'''$'\n''Return codes:'$'\n''- 0 - Console or output supports colors'$'\n''- 1 - Colors are likely not supported by console'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.'$'\n'''
