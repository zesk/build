#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/timing.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="timing.sh"
description="Outputs the offset in milliseconds from January 1, 1970."$'\n'"Should never fail, unless date is not installed"$'\n'""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingReport \"\$init\" \"Completed in\""$'\n'""
file="bin/build/tools/timing.sh"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
init=""
rawComment="Summary: Start a timer"$'\n'"Outputs the offset in milliseconds from January 1, 1970."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     init=\$(timingStart)"$'\n'"Example:     ..."$'\n'"Example:     timingReport \"\$init\" \"Completed in\""$'\n'"Requires: __timestamp, returnEnvironment date"$'\n'"Should never fail, unless date is not installed"$'\n'""$'\n'""
requires="__timestamp, returnEnvironment date"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceModified="1769063211"
summary="Start a timer"$'\n'""
usage="timingStart [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtimingStart'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Outputs the offset in milliseconds from January 1, 1970.'$'\n''Should never fail, unless date is not installed'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingReport "$init" "Completed in"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: timingStart [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Outputs the offset in milliseconds from January 1, 1970.'$'\n''Should never fail, unless date is not installed'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    init=$(timingStart)'$'\n''    ...'$'\n''    timingReport "$init" "Completed in"'$'\n'''
# elapsed (****)
