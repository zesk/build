#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Returns whether the shell has the debugging flag set\n\nUseful if you need to temporarily enable or disable it.\n\n'
descriptionLineCount="4"
file="bin/build/tools/debug.sh"
fn="isBashDebug"
fnMarker="isbashdebug"
foundNames=([0]="return_code")
line="134"
rawComment=$'Returns whether the shell has the debugging flag set\nUseful if you need to temporarily enable or disable it.\nReturn Code: 0 - bash debugging (`set -x`) is enabled\nReturn Code: 1 - bash debugging (`set -x`) is not enabled\n\n'
return_code=$'0 - bash debugging (`set -x`) is enabled\n1 - bash debugging (`set -x`) is not enabled\n'
sourceFile="bin/build/tools/debug.sh"
sourceHash="c698b75c5757732f1b8a82693f110a2be335611f"
sourceLine="134"
summary="Returns whether the shell has the debugging flag set"
summaryComputed="true"
usage="isBashDebug"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misBashDebug'$'\e''[0m'$'\n'''$'\n''Returns whether the shell has the debugging flag set'$'\n'''$'\n''Useful if you need to temporarily enable or disable it.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - bash debugging ('$'\e''[[(code)]mset -x'$'\e''[[(reset)]m) is enabled'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - bash debugging ('$'\e''[[(code)]mset -x'$'\e''[[(reset)]m) is not enabled'
# shellcheck disable=SC2016
helpPlain='Usage: isBashDebug'$'\n'''$'\n''Returns whether the shell has the debugging flag set'$'\n'''$'\n''Useful if you need to temporarily enable or disable it.'$'\n'''$'\n''Return codes:'$'\n''- 0 - bash debugging (set -x) is enabled'$'\n''- 1 - bash debugging (set -x) is not enabled'
documentationPath="documentation/source/tools/debug.md"
