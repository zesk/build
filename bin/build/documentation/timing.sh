#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="command - Executable. Required. Command to run."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--name - String. Optional. Display this help."$'\n'""
base="timing.sh"
description="Time command, similar to \`time\` but uses internal functions"$'\n'"Outputs time as \`timingReport\`"$'\n'""
file="bin/build/tools/timing.sh"
fn="timing"
foundNames=([0]="argument")
rawComment="Time command, similar to \`time\` but uses internal functions"$'\n'"Argument: command - Executable. Required. Command to run."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --name - String. Optional. Display this help."$'\n'"Outputs time as \`timingReport\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="f783345c9632fff6bf787e6f257d7886528addeb"
summary="Time command, similar to \`time\` but uses internal functions"
summaryComputed="true"
usage="timing command [ --help ] [ --name ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtiming'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --name ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcommand  '$'\e''[[(value)]mExecutable. Required. Command to run.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--name   '$'\e''[[(value)]mString. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Time command, similar to '$'\e''[[(code)]mtime'$'\e''[[(reset)]m but uses internal functions'$'\n''Outputs time as '$'\e''[[(code)]mtimingReport'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: timing command [ --help ] [ --name ]'$'\n'''$'\n''    command  Executable. Required. Command to run.'$'\n''    --help   Flag. Optional. Display this help.'$'\n''    --name   String. Optional. Display this help.'$'\n'''$'\n''Time command, similar to time but uses internal functions'$'\n''Outputs time as timingReport'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
