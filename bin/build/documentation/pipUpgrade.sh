#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-01
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--bin binary - Executable. Optional. Binary for `pip`.\n'
base="python.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Utility to upgrade pip correctly\n\n'
descriptionLineCount="2"
file="bin/build/tools/python.sh"
fn="pipUpgrade"
fnMarker="pipupgrade"
foundNames=([0]="argument")
line="48"
rawComment=$'Utility to upgrade pip correctly\nArgument: --help - Flag. Optional. Display this help.\nArgument: --bin binary - Executable. Optional. Binary for `pip`.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/python.sh"
sourceHash="41488c39a086a773d0c97f580808181e9997f5f8"
sourceLine="48"
summary="Utility to upgrade pip correctly"
summaryComputed="true"
usage="pipUpgrade [ --help ] [ --bin binary ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpipUpgrade'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --bin binary ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--bin binary  '$'\e''[[(value)]mExecutable. Optional. Binary for '$'\e''[[(code)]mpip'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Utility to upgrade pip correctly'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: pipUpgrade [ --help ] [ --bin binary ]'$'\n'''$'\n''    --help        Flag. Optional. Display this help.'$'\n''    --bin binary  Executable. Optional. Binary for pip.'$'\n'''$'\n''Utility to upgrade pip correctly'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/python.md"
