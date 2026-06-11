#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-11
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Extracts the final comment from a stream."$'\n'"Excludes lines similarly to \`bashFirstComment\`."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/bash.sh"
fn="bashFinalComment"
fnMarker="bashfinalcomment"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="requires")
line="561"
rawComment="Summary: Extract final comment from a stream"$'\n'"Extracts the final comment from a stream."$'\n'"Excludes lines similarly to \`bashFirstComment\`."$'\n'"See: bashFirstComment"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: fileReverseLines sed cut grep convertValue"$'\n'""$'\n'""
requires="fileReverseLines sed cut grep convertValue"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashFirstComment"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c338e57d5d9111ed127b37263341910041a4b278"
sourceLine="561"
summary="Extract final comment from a stream"
summaryComputed=""
usage="bashFinalComment [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashFinalComment'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Extracts the final comment from a stream.'$'\n''Excludes lines similarly to '$'\e''[[(code)]mbashFirstComment'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashFinalComment [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Extracts the final comment from a stream.'$'\n''Excludes lines similarly to bashFirstComment.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
