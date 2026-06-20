#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="none"
base="apt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is apt-get installed?\n\n'
descriptionLineCount="2"
file="bin/build/tools/apt.sh"
fn="aptIsInstalled"
fnMarker="aptisinstalled"
foundNames=()
line="25"
original="aptIsInstalled"
rawComment=$'Is apt-get installed?\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/apt.sh"
sourceHash="88cf0bf4880cbbb00ac4ecc16ac7dac0654df552"
sourceLine="25"
summary="Is apt-get installed?"
summaryComputed="true"
usage="aptIsInstalled"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]maptIsInstalled'$'\e''[0m'$'\n'''$'\n''Is apt-get installed?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: aptIsInstalled'$'\n'''$'\n''Is apt-get installed?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/apt.md"
