#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-04
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"soundFile ... - File. Required. Sound file(s) to install in user library."$'\n'"--create - Flag. Optional. Create sound directory if it does not exist."$'\n'""
base="darwin.sh"
description="Install a sound file for notifications"$'\n'""
file="bin/build/tools/darwin.sh"
rawComment="Install a sound file for notifications"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: soundFile ... - File. Required. Sound file(s) to install in user library."$'\n'"Argument: --create - Flag. Optional. Create sound directory if it does not exist."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/darwin.sh"
sourceHash="17fa598a8b0e744def5b310cbfb745211e708bdd"
summary="Install a sound file for notifications"
summaryComputed="true"
usage="darwinSoundInstall [ --help ] soundFile ... [ --create ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdarwinSoundInstall'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]msoundFile ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --create ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]msoundFile ...  '$'\e''[[(value)]mFile. Required. Sound file(s) to install in user library.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--create       '$'\e''[[(value)]mFlag. Optional. Create sound directory if it does not exist.'$'\e''[[(reset)]m'$'\n'''$'\n''Install a sound file for notifications'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: darwinSoundInstall [ --help ] soundFile ... [ --create ]'$'\n'''$'\n''    --help         Flag. Optional. Display this help.'$'\n''    soundFile ...  File. Required. Sound file(s) to install in user library.'$'\n''    --create       Flag. Optional. Create sound directory if it does not exist.'$'\n'''$'\n''Install a sound file for notifications'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
