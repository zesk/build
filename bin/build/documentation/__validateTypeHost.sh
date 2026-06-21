#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="network.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'A network name\n\n'
descriptionLineCount="2"
file="bin/build/tools/network.sh"
fn="__validateTypeHost"
fnMarker="__validatetypehost"
foundNames=()
line="50"
original="__validateTypeHost"
rawComment=$'A network name\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/network.sh"
sourceHash="8e348568373c9cc01fe79d8a8cf35f22192cc6bb"
sourceLine="50"
summary="A network name"
summaryComputed="true"
usage="__validateTypeHost"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeHost'$'\e''[0m'$'\n'''$'\n''A network name'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeHost'$'\n'''$'\n''A network name'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
