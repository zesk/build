#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"text - String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations."$'\n'""
base="date.sh"
description="Is a date valid?"$'\n'""
file="bin/build/tools/date.sh"
foundNames=([0]="argument")
rawComment="Is a date valid?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"Argument: text - String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="9a217a468b4498cc58a48e05ea655c248a77d8c1"
summary="Is a date valid?"
summaryComputed="true"
usage="dateValid [ --help ] [ -- ] text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateValid'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--      '$'\e''[[(value)]mFlag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtext    '$'\e''[[(value)]mString. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations.'$'\e''[[(reset)]m'$'\n'''$'\n''Is a date valid?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mdateValid [[(blue)]m[ --help ] [[(blue)]m[ -- ] [[(bold)]m[[(magenta)]mtext'$'\n'''$'\n''    [[(blue)]m--help  [[(value)]mFlag. Optional. Display this help.[[(reset)]m'$'\n''    [[(blue)]m--      [[(value)]mFlag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.[[(reset)]m'$'\n''    [[(red)]mtext    [[(value)]mString. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations.[[(reset)]m'$'\n'''$'\n''Is a date valid?'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''
