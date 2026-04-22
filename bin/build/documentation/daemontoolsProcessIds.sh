#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
description="List any processes associated with daemontools supervisors"$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsProcessIds"
foundNames=([0]="requires")
line="310"
lowerFn="daemontoolsprocessids"
rawComment="List any processes associated with daemontools supervisors"$'\n'"Requires: pgrep read printf"$'\n'""$'\n'""
requires="pgrep read printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="f448dbffaa1f7e767bd20c8f8728f0f9e0597de0"
sourceLine="310"
summary="List any processes associated with daemontools supervisors"
summaryComputed="true"
usage="daemontoolsProcessIds"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsProcessIds'$'\e''[0m'$'\n'''$'\n''List any processes associated with daemontools supervisors'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsProcessIds'$'\n'''$'\n''List any processes associated with daemontools supervisors'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/daemontools.md"
