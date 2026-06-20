#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="deprecated-tools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run deprecated tokens file search\n\n'
descriptionLineCount="2"
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedTokensFile"
fnMarker="deprecatedtokensfile"
foundNames=()
line="90"
original="deprecatedTokensFile"
rawComment=$'Run deprecated tokens file search\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="db3a69b3802bf02c741786f5456bb2a207a20d8b"
sourceLine="90"
summary="Run deprecated tokens file search"
summaryComputed="true"
usage="deprecatedTokensFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeprecatedTokensFile'$'\e''[0m'$'\n'''$'\n''Run deprecated tokens file search'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedTokensFile'$'\n'''$'\n''Run deprecated tokens file search'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/deprecated.md"
