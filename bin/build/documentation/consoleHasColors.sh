#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="core.sh"
description="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\` to calculate"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Console or output supports colors"$'\n'"Return Code: 1 - Colors are likely not supported by console"$'\n'"Environment: BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors."$'\n'"Requires: isPositiveInteger tput"$'\n'""
file="bin/build/tools/decorate/core.sh"
foundNames=()
rawComment="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\` to calculate"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Console or output supports colors"$'\n'"Return Code: 1 - Colors are likely not supported by console"$'\n'"Environment: BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors."$'\n'"Requires: isPositiveInteger tput"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="4e888a942dbc9f76fbb741ff39b1f642beb8541d"
summary="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\`"
usage="consoleHasColors"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleHasColors'$'\e''[0m'$'\n'''$'\n''Sets the environment variable '$'\e''[[(code)]mBUILD_COLORS'$'\e''[[(reset)]m if not set, uses '$'\e''[[(code)]mTERM'$'\e''[[(reset)]m to calculate'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - Console or output supports colors'$'\n''Return Code: 1 - Colors are likely not supported by console'$'\n''Environment: BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.'$'\n''Requires: isPositiveInteger tput'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: consoleHasColors'$'\n'''$'\n''Sets the environment variable BUILD_COLORS if not set, uses TERM to calculate'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - Console or output supports colors'$'\n''Return Code: 1 - Colors are likely not supported by console'$'\n''Environment: BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.'$'\n''Requires: isPositiveInteger tput'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.466
