#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'number - Float. Optional. Floating point number to convert to integer.\n'
base="float.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Convert float to nearest integer (up or down)\n\n'
descriptionLineCount="2"
file="bin/build/tools/float.sh"
fn="floatRound"
fnMarker="floatround"
foundNames=([0]="argument")
line="13"
original="floatRound"
rawComment=$'Argument: number - Float. Optional. Floating point number to convert to integer.\nConvert float to nearest integer (up or down)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/float.sh"
sourceHash="e1ffb94734224e23fb5aec666a9a3ea259b0c325"
sourceLine="13"
summary="Convert float to nearest integer (up or down)"
summaryComputed="true"
usage="floatRound [ number ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfloatRound'$'\e''[0m '$'\e''[[(blue)]m[ number ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mnumber  '$'\e''[[(value)]mFloat. Optional. Floating point number to convert to integer.'$'\e''[[(reset)]m'$'\n'''$'\n''Convert float to nearest integer (up or down)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: floatRound [ number ]'$'\n'''$'\n''    number  Float. Optional. Floating point number to convert to integer.'$'\n'''$'\n''Convert float to nearest integer (up or down)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/float.md"
