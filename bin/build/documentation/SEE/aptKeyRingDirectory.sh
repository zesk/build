#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="apt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get key ring directory path"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/apt.sh"
fn="aptKeyRingDirectory"
fnMarker="aptkeyringdirectory"
foundNames=()
line="47"
rawComment="Get key ring directory path"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/apt.sh"
sourceHash="88cf0bf4880cbbb00ac4ecc16ac7dac0654df552"
sourceLine="47"
summary="Get key ring directory path"
summaryComputed="true"
usage="aptKeyRingDirectory"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]maptKeyRingDirectory'$'\e''[0m'$'\n'''$'\n''Get key ring directory path'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyRingDirectory'$'\n'''$'\n''Get key ring directory path'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/apt.md"
