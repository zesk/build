#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument="none"
base="install.sample.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is a valid function currently defined?"
descriptionLineCount=""
file="bin/build/install.sample.sh"
fn="validate Function"
fnMarker="__validatetypefunction"
foundNames=([0]="fn" [1]="summary" [2]="requires")
line="758"
original="__validateTypeFunction"
rawComment=$'fn: validate Function\nSummary: Is a valid function currently defined?\nRequires: isFunction _validateThrow\n\n'
requires=$'isFunction _validateThrow\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/install.sample.sh"
sourceHash="cc6a7bc654dc526a77adef2258e0e353f853addb"
sourceLine="758"
summary="Is a valid function currently defined?"
summaryComputed=""
usage="__validateTypeFunction"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mvalidate Function'$'\e''[0m'$'\n'''$'\n''Is a valid function currently defined?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: validate Function'$'\n'''$'\n''Is a valid function currently defined?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
