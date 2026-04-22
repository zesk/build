#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"text - String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations."$'\n'""
base="date.sh"
description="Checks a date syntax and ensures it's a valid calendar date."$'\n'""
file="bin/build/tools/date.sh"
fn="dateValid"
foundNames=([0]="summary" [1]="argument")
line="192"
lowerFn="datevalid"
rawComment="Summary: Is a date valid?"$'\n'"Checks a date syntax and ensures it's a valid calendar date."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"Argument: text - String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="8b6a5808143207c1b2329179a4d73d95ea46d8cc"
sourceLine="192"
summary="Is a date valid?"$'\n'""
usage="dateValid [ --help ] [ -- ] text"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdateValid'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mtext'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--      '$'\e''[[(value)]mFlag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mtext    '$'\e''[[(value)]mString. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations.'$'\e''[[(reset)]m'$'\n'''$'\n''Checks a date syntax and ensures it'\''s a valid calendar date.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dateValid [ --help ] [ -- ] text'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    --      Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\n''    text    String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations.'$'\n'''$'\n''Checks a date syntax and ensures it'\''s a valid calendar date.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/date.md"
