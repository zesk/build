#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Restart the daemontools processes from scratch.\nDangerous. Stops any running services and restarts them.\n\n'
descriptionLineCount="3"
file="bin/build/tools/daemontools.sh"
fn="daemontoolsRestart"
fnMarker="daemontoolsrestart"
foundNames=()
line="394"
rawComment=$'Restart the daemontools processes from scratch.\nDangerous. Stops any running services and restarts them.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="ce2a745dbc260a923b143c89c7a933496d6e9aa0"
sourceLine="394"
summary="Restart the daemontools processes from scratch."
summaryComputed="true"
usage="daemontoolsRestart"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsRestart'$'\e''[0m'$'\n'''$'\n''Restart the daemontools processes from scratch.'$'\n''Dangerous. Stops any running services and restarts them.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsRestart'$'\n'''$'\n''Restart the daemontools processes from scratch.'$'\n''Dangerous. Stops any running services and restarts them.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/daemontools.md"
