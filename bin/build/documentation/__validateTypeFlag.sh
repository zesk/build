#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument="none"
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Flags are command line options which set a value to true, usually\nPlaceholder to add type to list\n\n'
descriptionLineCount="3"
file="bin/build/tools/validate.sh"
fn="__validateTypeFlag"
fnMarker="__validatetypeflag"
foundNames=()
line="370"
original="__validateTypeFlag"
rawComment=$'Flags are command line options which set a value to true, usually\nPlaceholder to add type to list\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="b57b723712fe47b17a65ba1939a889d7dc5a4299"
sourceLine="370"
summary="Flags are command line options which set a value to"
summaryComputed="true"
usage="__validateTypeFlag"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeFlag'$'\e''[0m'$'\n'''$'\n''Flags are command line options which set a value to true, usually'$'\n''Placeholder to add type to list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeFlag'$'\n'''$'\n''Flags are command line options which set a value to true, usually'$'\n''Placeholder to add type to list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
