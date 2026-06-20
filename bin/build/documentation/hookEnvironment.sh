#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="hook.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Load hook environment variables used to find hooks.\n\nEnsures `BUILD_HOOK_EXTENSIONS` and `BUILD_HOOK_DIRS` are set to their proper defaults.\n\nIf already loaded, this function has no effect.\n\n'
descriptionLineCount="6"
environment=$'BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS\n'
file="bin/build/tools/hook.sh"
fn="hookEnvironment"
fnMarker="hookenvironment"
foundNames=([0]="summary" [1]="environment" [2]="argument")
line="378"
original="hookEnvironment"
rawComment=$'Load hook environment variables used to find hooks.\nEnsures `BUILD_HOOK_EXTENSIONS` and `BUILD_HOOK_DIRS` are set to their proper defaults.\nIf already loaded, this function has no effect.\nSummary: Load hook-related environment variables\nEnvironment: BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/hook.sh"
sourceHash="d7e5ca8901bb43435b977751cbb2ef47e4b94072"
sourceLine="378"
summary="Load hook-related environment variables"
summaryComputed=""
usage="hookEnvironment [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhookEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Load hook environment variables used to find hooks.'$'\n'''$'\n''Ensures '$'\e''[[(code)]mBUILD_HOOK_EXTENSIONS'$'\e''[[(reset)]m and '$'\e''[[(code)]mBUILD_HOOK_DIRS'$'\e''[[(reset)]m are set to their proper defaults.'$'\n'''$'\n''If already loaded, this function has no effect.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS'
# shellcheck disable=SC2016
helpPlain='Usage: hookEnvironment [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Load hook environment variables used to find hooks.'$'\n'''$'\n''Ensures BUILD_HOOK_EXTENSIONS and BUILD_HOOK_DIRS are set to their proper defaults.'$'\n'''$'\n''If already loaded, this function has no effect.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS'
documentationPath="documentation/source/tools/hook.md"
