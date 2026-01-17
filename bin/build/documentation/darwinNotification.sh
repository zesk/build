#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/darwin.sh"
argument="--title - String. Optional. Title of the notification."$'\n'"--debug - Flag. Optional. Output the osascript as \`darwinNotification.debug\` at the application root after this call."$'\n'"--sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in \`/Library/Sounds/\`."$'\n'"message ... - String. Optional. Message to display to the user in the dialog."$'\n'""
base="darwin.sh"
description="Display a notification for the user"$'\n'""
file="bin/build/tools/darwin.sh"
fn="darwinNotification"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/darwin.sh"
sourceModified="1768683999"
summary="Display a notification for the user"
usage="darwinNotification [ --title ] [ --debug ] [ --sound soundName ] [ message ... ]"
