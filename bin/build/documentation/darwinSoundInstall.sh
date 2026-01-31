#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="darwin.sh"
description="Install a sound file for notifications"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: soundFile ... - File. Required. Sound file(s) to install in user library."$'\n'"Argument: --create - Flag. Optional. Create sound directory if it does not exist."$'\n'""
file="bin/build/tools/darwin.sh"
foundNames=()
rawComment="Install a sound file for notifications"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: soundFile ... - File. Required. Sound file(s) to install in user library."$'\n'"Argument: --create - Flag. Optional. Create sound directory if it does not exist."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/darwin.sh"
sourceHash="432c767364a75cea4dd7323b34105fae4336231d"
summary="Install a sound file for notifications"
usage="darwinSoundInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdarwinSoundInstall'$'\e''[0m'$'\n'''$'\n''Install a sound file for notifications'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: soundFile ... - File. Required. Sound file(s) to install in user library.'$'\n''Argument: --create - Flag. Optional. Create sound directory if it does not exist.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: darwinSoundInstall'$'\n'''$'\n''Install a sound file for notifications'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: soundFile ... - File. Required. Sound file(s) to install in user library.'$'\n''Argument: --create - Flag. Optional. Create sound directory if it does not exist.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.504
