#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/darwin.sh"
argument="--title - String. Optional. Title of the notification."$'\n'"--debug - Flag. Optional. Output the osascript as \`darwinNotification.debug\` at the application root after this call."$'\n'"--sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in \`/Library/Sounds/\`."$'\n'"message ... - String. Optional. Message to display to the user in the dialog."$'\n'""
base="darwin.sh"
description="Display a notification for the user"$'\n'""
file="bin/build/tools/darwin.sh"
fn="darwinNotification"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/darwin.sh"
sourceModified="1768721470"
summary="Display a notification for the user"
usage="darwinNotification [ --title ] [ --debug ] [ --sound soundName ] [ message ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdarwinNotification[0m [94m[ --title ][0m [94m[ --debug ][0m [94m[ --sound soundName ][0m [94m[ message ... ][0m

    [94m--title            [1;97mString. Optional. Title of the notification.[0m
    [94m--debug            [1;97mFlag. Optional. Output the osascript as [38;2;0;255;0;48;2;0;0;0mdarwinNotification.debug[0m at the application root after this call.[0m
    [94m--sound soundName  [1;97mString. Optional. Sound to play with the notification. Represents a sound base name found in [38;2;0;255;0;48;2;0;0;0m/Library/Sounds/[0m.[0m
    [94mmessage ...        [1;97mString. Optional. Message to display to the user in the dialog.[0m

Display a notification for the user

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: darwinNotification [ --title ] [ --debug ] [ --sound soundName ] [ message ... ]

    --title            String. Optional. Title of the notification.
    --debug            Flag. Optional. Output the osascript as darwinNotification.debug at the application root after this call.
    --sound soundName  String. Optional. Sound to play with the notification. Represents a sound base name found in /Library/Sounds/.
    message ...        String. Optional. Message to display to the user in the dialog.

Display a notification for the user

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
