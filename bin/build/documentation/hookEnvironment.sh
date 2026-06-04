#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="hook.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Load hook environment variables used to find hooks"$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS"$'\n'""
file="bin/build/tools/hook.sh"
fn="hookEnvironment"
fnMarker="hookenvironment"
foundNames=([0]="summary" [1]="environment" [2]="argument")
line="372"
rawComment="Load hook environment variables used to find hooks"$'\n'"Summary: Load hook-related environment variables"$'\n'"Environment: BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/hook.sh"
sourceHash="d0ba2dabdb14bfd56f5a5830f74f73a903e5184b"
sourceLine="372"
summary="Load hook-related environment variables"
summaryComputed=""
usage="hookEnvironment [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhookEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Load hook environment variables used to find hooks'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS'
# shellcheck disable=SC2016
helpPlain='Usage: hookEnvironment [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Load hook environment variables used to find hooks'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS'
documentationPath="documentation/source/tools/hook.md"
