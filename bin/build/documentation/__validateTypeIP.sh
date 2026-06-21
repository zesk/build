#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument="none"
base="network.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'An IP address (IPv4 or IPv6)\n\n'
descriptionLineCount="2"
file="bin/build/tools/network.sh"
fn="__validateTypeIP"
fnMarker="__validatetypeip"
foundNames=()
line="44"
original="__validateTypeIP"
rawComment=$'An IP address (IPv4 or IPv6)\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/network.sh"
sourceHash="8e348568373c9cc01fe79d8a8cf35f22192cc6bb"
sourceLine="44"
summary="An IP address (IPv4 or IPv6)"
summaryComputed="true"
usage="__validateTypeIP"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]m__validateTypeIP'$'\e''[0m'$'\n'''$'\n''An IP address (IPv4 or IPv6)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: __validateTypeIP'$'\n'''$'\n''An IP address (IPv4 or IPv6)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
