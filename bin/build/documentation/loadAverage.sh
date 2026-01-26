#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
description="Get the load average using uptime"$'\n'""
file="bin/build/tools/platform.sh"
foundNames=([0]="requires" [1]="uptime_output" [2]="stdout" [3]="argument")
rawComment="Get the load average using uptime"$'\n'"Requires: uptime"$'\n'"Uptime output: 0:00  up 30 days,  6:02, 19 users, load averages: 15.01 12.66 11.64"$'\n'"Uptime output: 05:01:06 up 8 days,  4:03,  0 users,  load average: 3.87, 3.09, 2.71"$'\n'"stdout: lines:Number"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
requires="uptime"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceModified="1769184734"
stdout="lines:Number"$'\n'""
summary="Get the load average using uptime"
uptime_output="0:00  up 30 days,  6:02, 19 users, load averages: 15.01 12.66 11.64"$'\n'"05:01:06 up 8 days,  4:03,  0 users,  load average: 3.87, 3.09, 2.71"$'\n'""
usage="loadAverage [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mloadAverage'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the load average using uptime'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''lines:Number'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: loadAverage [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Get the load average using uptime'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''lines:Number'$'\n'''
# elapsed 0.532
