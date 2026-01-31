#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="darwin.sh"
description="Display a notification for the user"$'\n'"Argument: --title - String. Optional. Title of the notification."$'\n'"Argument: --debug - Flag. Optional. Output the osascript as \`darwinNotification.debug\` at the application root after this call."$'\n'"Argument: --sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in \`/Library/Sounds/\`."$'\n'"Argument: message ... - String. Optional. Message to display to the user in the dialog."$'\n'""
file="bin/build/tools/darwin.sh"
foundNames=()
rawComment="Display a notification for the user"$'\n'"Argument: --title - String. Optional. Title of the notification."$'\n'"Argument: --debug - Flag. Optional. Output the osascript as \`darwinNotification.debug\` at the application root after this call."$'\n'"Argument: --sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in \`/Library/Sounds/\`."$'\n'"Argument: message ... - String. Optional. Message to display to the user in the dialog."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/darwin.sh"
sourceHash="432c767364a75cea4dd7323b34105fae4336231d"
summary="Display a notification for the user"
usage="darwinNotification"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdarwinNotification'$'\e''[0m'$'\n'''$'\n''Display a notification for the user'$'\n''Argument: --title - String. Optional. Title of the notification.'$'\n''Argument: --debug - Flag. Optional. Output the osascript as '$'\e''[[(code)]mdarwinNotification.debug'$'\e''[[(reset)]m at the application root after this call.'$'\n''Argument: --sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in '$'\e''[[(code)]m/Library/Sounds/'$'\e''[[(reset)]m.'$'\n''Argument: message ... - String. Optional. Message to display to the user in the dialog.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: darwinNotification'$'\n'''$'\n''Display a notification for the user'$'\n''Argument: --title - String. Optional. Title of the notification.'$'\n''Argument: --debug - Flag. Optional. Output the osascript as darwinNotification.debug at the application root after this call.'$'\n''Argument: --sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in /Library/Sounds/.'$'\n''Argument: message ... - String. Optional. Message to display to the user in the dialog.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.508
