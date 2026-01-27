#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"message ... - Display this message while pausing"$'\n'""
base="interactive.sh"
description="Pause for user input"$'\n'""
file="bin/build/tools/interactive.sh"
foundNames=([0]="argument")
rawComment="Pause for user input"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"Argument: message ... - Display this message while pausing"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1769063211"
summary="Pause for user input"
usage="pause [ --help ] [ -- ] [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpause'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ -- ]'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--           '$'\e''[[(value)]mFlag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mDisplay this message while pausing'$'\e''[[(reset)]m'$'\n'''$'\n''Pause for user input'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pause [ --help ] [ -- ] [ message ... ]'$'\n'''$'\n''    --help       Flag. Optional. Display this help.'$'\n''    --           Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.'$'\n''    message ...  Display this message while pausing'$'\n'''$'\n''Pause for user input'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.548
