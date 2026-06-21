#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="install.sample.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is callable?"
descriptionLineCount=""
file="bin/build/install.sample.sh"
fn="validate Callable"
fnMarker="__validatetypecallable"
foundNames=([0]="fn" [1]="summary" [2]="requires")
line="766"
original="__validateTypeCallable"
rawComment=$'fn: validate Callable\nSummary: Is callable?\nRequires: isCallable _validateThrow\n\n'
requires=$'isCallable _validateThrow\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/install.sample.sh"
sourceHash="c986aa074a8b33e6b95780ac611bfff080d45f62"
sourceLine="766"
summary="Is callable?"
summaryComputed=""
usage="__validateTypeCallable"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mvalidate Callable'$'\e''[0m'$'\n'''$'\n''Is callable?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: validate Callable'$'\n'''$'\n''Is callable?'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
