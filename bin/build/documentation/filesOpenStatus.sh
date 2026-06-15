#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-15
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output current open files"$'\n'"stdout"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/debug.sh"
fn="filesOpenStatus"
fnMarker="filesopenstatus"
foundNames=()
line="584"
rawComment="Output current open files"$'\n'"stdout"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="31fe892c1ce36e9aab313274a8fe87aa1c2ff9a6"
sourceLine="584"
summary="Output current open files"
summaryComputed="true"
usage="filesOpenStatus"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfilesOpenStatus'$'\e''[0m'$'\n'''$'\n''Output current open files'$'\n''stdout'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: filesOpenStatus'$'\n'''$'\n''Output current open files'$'\n''stdout'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/unused.md"
