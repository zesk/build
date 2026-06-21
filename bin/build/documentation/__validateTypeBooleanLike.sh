#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Boolean-like value\n\n'
descriptionLineCount="2"
file="bin/build/tools/validate.sh"
fn="__validateTypeBooleanLike"
fnMarker="__validatetypebooleanlike"
foundNames=()
line="374"
original="__validateTypeBooleanLike"
rawComment=$'Boolean-like value\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="4f8ffd4b24993e2c06fe909247c19c030b8e0214"
sourceLine="374"
summary="Boolean-like value"
summaryComputed="true"
usage="__validateTypeBooleanLike"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeBooleanLike'$'\e''[0m'$'\n'''$'\n''Boolean-like value'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeBooleanLike'$'\n'''$'\n''Boolean-like value'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
