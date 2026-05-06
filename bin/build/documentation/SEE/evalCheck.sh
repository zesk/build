#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="security.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check files to ensure \`eval\`s in code have been checked"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/security.sh"
fn="evalCheck"
fnMarker="evalcheck"
foundNames=()
line="60"
rawComment="Check files to ensure \`eval\`s in code have been checked"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/security.sh"
sourceHash="eacf27e9e53e452bdaa719094b23729ab1dfc7aa"
sourceLine="60"
summary="Check files to ensure \`eval\`s in code have been checked"
summaryComputed="true"
usage="evalCheck"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mevalCheck'$'\e''[0m'$'\n'''$'\n''Check files to ensure '$'\e''[[(code)]meval'$'\e''[[(reset)]ms in code have been checked'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: evalCheck'$'\n'''$'\n''Check files to ensure evals in code have been checked'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/test.md"
