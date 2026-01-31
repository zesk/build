#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="timing.sh"
description="Time command, similar to \`time\` but uses internal functions"$'\n'"Argument: command - Executable. Required. Command to run."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --name - String. Optional. Display this help."$'\n'"Outputs time as \`timingReport\`"$'\n'""
file="bin/build/tools/timing.sh"
foundNames=()
rawComment="Time command, similar to \`time\` but uses internal functions"$'\n'"Argument: command - Executable. Required. Command to run."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --name - String. Optional. Display this help."$'\n'"Outputs time as \`timingReport\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="8cfb9a50fadfff4b381ff34068eab3136b206319"
summary="Time command, similar to \`time\` but uses internal functions"
usage="timing"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtiming'$'\e''[0m'$'\n'''$'\n''Time command, similar to '$'\e''[[(code)]mtime'$'\e''[[(reset)]m but uses internal functions'$'\n''Argument: command - Executable. Required. Command to run.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --name - String. Optional. Display this help.'$'\n''Outputs time as '$'\e''[[(code)]mtimingReport'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: timing'$'\n'''$'\n''Time command, similar to time but uses internal functions'$'\n''Argument: command - Executable. Required. Command to run.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --name - String. Optional. Display this help.'$'\n''Outputs time as timingReport'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.524
