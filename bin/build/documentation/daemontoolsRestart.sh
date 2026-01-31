#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
description="Restart the daemontools processes from scratch."$'\n'"Dangerous. Stops any running services and restarts them."$'\n'""
file="bin/build/tools/daemontools.sh"
foundNames=()
rawComment="Restart the daemontools processes from scratch."$'\n'"Dangerous. Stops any running services and restarts them."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="ad7724ecae1a0dfef00687192388ecf23b24032c"
summary="Restart the daemontools processes from scratch."
summaryComputed="true"
usage="daemontoolsRestart"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsRestart'$'\e''[0m'$'\n'''$'\n''Restart the daemontools processes from scratch.'$'\n''Dangerous. Stops any running services and restarts them.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mdaemontoolsRestart'$'\n'''$'\n''Restart the daemontools processes from scratch.'$'\n''Dangerous. Stops any running services and restarts them.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 3.428
