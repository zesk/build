#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="install.sample.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is a positive integer? (1 or greater)"
descriptionLineCount=""
file="bin/build/install.sample.sh"
fn="validate PositiveInteger"
fnMarker="__validatetypepositiveinteger"
foundNames=([0]="fn" [1]="summary" [2]="requires")
line="750"
original="__validateTypePositiveInteger"
rawComment=$'fn: validate PositiveInteger\nSummary: Is a positive integer? (1 or greater)\nRequires: isPositiveInteger _validateThrow\n\n'
requires=$'isPositiveInteger _validateThrow\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/install.sample.sh"
sourceHash="c986aa074a8b33e6b95780ac611bfff080d45f62"
sourceLine="750"
summary="Is a positive integer? (1 or greater)"
summaryComputed=""
usage="__validateTypePositiveInteger"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mvalidate PositiveInteger'$'\e''[0m'$'\n'''$'\n''Is a positive integer? (1 or greater)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: validate PositiveInteger'$'\n'''$'\n''Is a positive integer? (1 or greater)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
