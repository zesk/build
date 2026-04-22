#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="number - Float. Optional. Floating point number to convert to integer."$'\n'""
base="float.sh"
description="Convert float to an integer, round down always"$'\n'""
file="bin/build/tools/float.sh"
fn="floatTruncate"
foundNames=([0]="argument")
line="27"
lowerFn="floattruncate"
rawComment="Argument: number - Float. Optional. Floating point number to convert to integer."$'\n'"Convert float to an integer, round down always"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/float.sh"
sourceHash="e1ffb94734224e23fb5aec666a9a3ea259b0c325"
sourceLine="27"
summary="Convert float to an integer, round down always"
summaryComputed="true"
usage="floatTruncate [ number ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfloatTruncate'$'\e''[0m '$'\e''[[(blue)]m[ number ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mnumber  '$'\e''[[(value)]mFloat. Optional. Floating point number to convert to integer.'$'\e''[[(reset)]m'$'\n'''$'\n''Convert float to an integer, round down always'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: floatTruncate [ number ]'$'\n'''$'\n''    number  Float. Optional. Floating point number to convert to integer.'$'\n'''$'\n''Convert float to an integer, round down always'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/float.md"
