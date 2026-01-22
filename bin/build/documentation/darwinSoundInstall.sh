#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/darwin.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"soundFile ... - File. Required. Sound file(s) to install in user library."$'\n'"--create - Flag. Optional. Create sound directory if it does not exist."$'\n'""
base="darwin.sh"
description="Install a sound file for notifications"$'\n'""$'\n'""
file="bin/build/tools/darwin.sh"
fn="darwinSoundInstall"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/darwin.sh"
sourceModified="1768721470"
summary="Install a sound file for notifications"
usage="darwinSoundInstall [ --help ] soundFile ... [ --create ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdarwinSoundInstall[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0msoundFile ...[0m[0m [94m[ --create ][0m

    [94m--help         [1;97mFlag. Optional. Display this help.[0m
    [31msoundFile ...  [1;97mFile. Required. Sound file(s) to install in user library.[0m
    [94m--create       [1;97mFlag. Optional. Create sound directory if it does not exist.[0m

Install a sound file for notifications

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: darwinSoundInstall [ --help ] soundFile ... [ --create ]

    --help         Flag. Optional. Display this help.
    soundFile ...  File. Required. Sound file(s) to install in user library.
    --create       Flag. Optional. Create sound directory if it does not exist.

Install a sound file for notifications

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
