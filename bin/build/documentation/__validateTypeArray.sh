#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Boolean parsing\nArrays can be zero-length so any value passes\n\n'
descriptionLineCount="3"
file="bin/build/tools/validate.sh"
fn="__validateTypeArray"
fnMarker="__validatetypearray"
foundNames=()
line="225"
original="__validateTypeArray"
rawComment=$'Boolean parsing\nArrays can be zero-length so any value passes\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="6aa8ba7c4c01e78e1aaa60bba330293420ad5579"
sourceLine="225"
summary="Boolean parsing"
summaryComputed="true"
usage="__validateTypeArray"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeArray'$'\e''[0m'$'\n'''$'\n''Boolean parsing'$'\n''Arrays can be zero-length so any value passes'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeArray'$'\n'''$'\n''Boolean parsing'$'\n''Arrays can be zero-length so any value passes'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
