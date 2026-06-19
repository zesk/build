#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Print the daemontools service home path\n\n'
descriptionLineCount="2"
file="bin/build/tools/daemontools.sh"
fn="daemontoolsHome"
fnMarker="daemontoolshome"
foundNames=([0]="return_code")
line="266"
rawComment=$'Print the daemontools service home path\nReturn Code: 0 - success\nReturn Code: 1 - No environment file found\n\n'
return_code=$'0 - success\n1 - No environment file found\n'
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="ce2a745dbc260a923b143c89c7a933496d6e9aa0"
sourceLine="266"
summary="Print the daemontools service home path"
summaryComputed="true"
usage="daemontoolsHome"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsHome'$'\e''[0m'$'\n'''$'\n''Print the daemontools service home path'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No environment file found'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsHome'$'\n'''$'\n''Print the daemontools service home path'$'\n'''$'\n''Return codes:'$'\n''- 0 - success'$'\n''- 1 - No environment file found'
documentationPath="documentation/source/tools/daemontools.md"
