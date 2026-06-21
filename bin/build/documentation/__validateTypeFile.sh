#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'A file exists\n\n'
descriptionLineCount="2"
file="bin/build/tools/validate.sh"
fn="__validateTypeFile"
fnMarker="__validatetypefile"
foundNames=()
line="418"
original="__validateTypeFile"
rawComment=$'A file exists\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="4f8ffd4b24993e2c06fe909247c19c030b8e0214"
sourceLine="418"
summary="A file exists"
summaryComputed="true"
usage="__validateTypeFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeFile'$'\e''[0m'$'\n'''$'\n''A file exists'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeFile'$'\n'''$'\n''A file exists'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
