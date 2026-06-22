#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument="none"
base="validate.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'`:`-delimited list\n\n'
descriptionLineCount="2"
file="bin/build/tools/validate.sh"
fn="__validateTypeColonDelimitedList"
fnMarker="__validatetypecolondelimitedlist"
foundNames=()
line="251"
original="__validateTypeColonDelimitedList"
rawComment=$'`:`-delimited list\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/validate.sh"
sourceHash="b57b723712fe47b17a65ba1939a889d7dc5a4299"
sourceLine="251"
summary="\`:\`-delimited list"
summaryComputed="true"
usage="__validateTypeColonDelimitedList"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeColonDelimitedList'$'\e''[0m'$'\n'''$'\n'''$'\e''[[(code)]m:'$'\e''[[(reset)]m-delimited list'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeColonDelimitedList'$'\n'''$'\n'':-delimited list'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
