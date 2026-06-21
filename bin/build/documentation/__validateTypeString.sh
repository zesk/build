#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="install.sample.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Non-empty string\n\n'
descriptionLineCount="2"
file="bin/build/install.sample.sh"
fn="__validateTypeString"
fnMarker="__validatetypestring"
foundNames=([0]="requires")
line="739"
original="__validateTypeString"
rawComment=$'Non-empty string\nRequires: _validateThrow\n\n'
requires=$'_validateThrow\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/install.sample.sh"
sourceHash="53cbb6e3aa3a4600f9e0ef23bd6290d5ead53c13"
sourceLine="739"
summary="Non-empty string"
summaryComputed="true"
usage="__validateTypeString"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeString'$'\e''[0m'$'\n'''$'\n''Non-empty string'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeString'$'\n'''$'\n''Non-empty string'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
