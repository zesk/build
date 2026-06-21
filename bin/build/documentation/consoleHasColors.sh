#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate\n\n'
descriptionLineCount="2"
environment=$'BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.\n'
file="bin/build/tools/decorate/core.sh"
fn="consoleHasColors"
fnMarker="consolehascolors"
foundNames=([0]="argument" [1]="return_code" [2]="environment" [3]="requires")
line="16"
original="consoleHasColors"
rawComment=$'Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - Console or output supports colors\nReturn Code: 1 - Colors are likely not supported by console\nEnvironment: BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.\nRequires: isPositiveInteger tput helpArgument convertValue\n\n'
requires=$'isPositiveInteger tput helpArgument convertValue\n'
return_code=$'0 - Console or output supports colors\n1 - Colors are likely not supported by console\n'
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="3725cb28e12948a0b0e952bb332cba7a3044c792"
sourceLine="16"
summary="Sets the environment variable \`BUILD_COLORS\` if not set, uses \`TERM\`"
summaryComputed="true"
usage="consoleHasColors [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleHasColors'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Sets the environment variable '$'\e''[[(code)]mBUILD_COLORS'$'\e''[[(reset)]m if not set, uses '$'\e''[[(code)]mTERM'$'\e''[[(reset)]m to calculate'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Console or output supports colors'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Colors are likely not supported by console'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mBUILD_COLORS'$'\e''[[(reset)]m - Boolean. Optional. Whether the build system will output ANSI colors.'
# shellcheck disable=SC2016
helpPlain='Usage: consoleHasColors [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Sets the environment variable BUILD_COLORS if not set, uses TERM to calculate'$'\n'''$'\n''Return codes:'$'\n''- 0 - Console or output supports colors'$'\n''- 1 - Colors are likely not supported by console'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_COLORS - Boolean. Optional. Whether the build system will output ANSI colors.'
documentationPath="documentation/source/tools/decorate.md"
