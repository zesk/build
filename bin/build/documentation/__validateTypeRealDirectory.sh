#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument="none"
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'A real path for a directory\n\n'
descriptionLineCount="2"
file="bin/build/tools/validate.sh"
fn="__validateTypeRealDirectory"
fnMarker="__validatetyperealdirectory"
foundNames=()
line="448"
original="__validateTypeRealDirectory"
rawComment=$'A real path for a directory\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="b57b723712fe47b17a65ba1939a889d7dc5a4299"
sourceLine="448"
summary="A real path for a directory"
summaryComputed="true"
usage="__validateTypeRealDirectory"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeRealDirectory'$'\e''[0m'$'\n'''$'\n''A real path for a directory'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeRealDirectory'$'\n'''$'\n''A real path for a directory'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
