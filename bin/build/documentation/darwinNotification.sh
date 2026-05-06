#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--title - String. Optional. Title of the notification."$'\n'"--debug - Flag. Optional. Output the osascript as \`darwinNotification.debug\` at the application root after this call."$'\n'"--sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in \`/Library/Sounds/\`."$'\n'"message ... - String. Optional. Message to display to the user in the dialog."$'\n'""
base="darwin.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Display a notification for the user"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/darwin.sh"
fn="darwinNotification"
fnMarker="darwinnotification"
foundNames=([0]="argument")
line="127"
rawComment="Display a notification for the user"$'\n'"Argument: --title - String. Optional. Title of the notification."$'\n'"Argument: --debug - Flag. Optional. Output the osascript as \`darwinNotification.debug\` at the application root after this call."$'\n'"Argument: --sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in \`/Library/Sounds/\`."$'\n'"Argument: message ... - String. Optional. Message to display to the user in the dialog."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/darwin.sh"
sourceHash="ec705e085d0b6db06177741d264497efd1aa9f27"
sourceLine="127"
summary="Display a notification for the user"
summaryComputed="true"
usage="darwinNotification [ --title ] [ --debug ] [ --sound soundName ] [ message ... ]"
