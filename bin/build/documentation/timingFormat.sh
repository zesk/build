#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="timing.sh"
description="Format a timing output (milliseconds) as seconds using a decimal"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: delta - Integer. Milliseconds"$'\n'""
file="bin/build/tools/timing.sh"
foundNames=()
rawComment="Format a timing output (milliseconds) as seconds using a decimal"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: delta - Integer. Milliseconds"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="8cfb9a50fadfff4b381ff34068eab3136b206319"
summary="Format a timing output (milliseconds) as seconds using a decimal"
usage="timingFormat"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingFormat'$'\e''[0m'$'\n'''$'\n''Format a timing output (milliseconds) as seconds using a decimal'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: delta - Integer. Milliseconds'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: timingFormat'$'\n'''$'\n''Format a timing output (milliseconds) as seconds using a decimal'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: delta - Integer. Milliseconds'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.487
