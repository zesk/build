#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
description="Restart the daemontools processes from scratch."$'\n'"Dangerous. Stops any running services and restarts them."$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsRestart"
foundNames=()
rawComment="Restart the daemontools processes from scratch."$'\n'"Dangerous. Stops any running services and restarts them."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="857f204c053a784dde5252c1bff78b826a67097e"
summary="Restart the daemontools processes from scratch."
summaryComputed="true"
usage="daemontoolsRestart"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsRestart'$'\e''[0m'$'\n'''$'\n''Restart the daemontools processes from scratch.'$'\n''Dangerous. Stops any running services and restarts them.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsRestart'$'\n'''$'\n''Restart the daemontools processes from scratch.'$'\n''Dangerous. Stops any running services and restarts them.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
