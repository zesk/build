#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="none"
base="darwin.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Are we on Mac OS X?\n\n'
descriptionLineCount="2"
file="bin/build/tools/darwin.sh"
fn="isDarwin"
fnMarker="isdarwin"
foundNames=()
line="10"
rawComment=$'Are we on Mac OS X?\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/darwin.sh"
sourceHash="fc8738a3039d92fa8d3b8455aca247fed1d6b6a9"
sourceLine="10"
summary="Are we on Mac OS X?"
summaryComputed="true"
usage="isDarwin"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misDarwin'$'\e''[0m'$'\n'''$'\n''Are we on Mac OS X?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: isDarwin'$'\n'''$'\n''Are we on Mac OS X?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/darwin.md"
