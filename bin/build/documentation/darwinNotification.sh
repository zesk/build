#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--title - String. Optional. Title of the notification.\n--debug - Flag. Optional. Output the osascript as `darwinNotification.debug` at the application root after this call.\n--sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in `/Library/Sounds/`.\nmessage ... - String. Optional. Message to display to the user in the dialog.\n'
base="darwin.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Display a notification for the user\n\n'
descriptionLineCount="2"
file="bin/build/tools/darwin.sh"
fn="darwinNotification"
fnMarker="darwinnotification"
foundNames=([0]="argument")
line="127"
original="darwinNotification"
rawComment=$'Display a notification for the user\nArgument: --title - String. Optional. Title of the notification.\nArgument: --debug - Flag. Optional. Output the osascript as `darwinNotification.debug` at the application root after this call.\nArgument: --sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in `/Library/Sounds/`.\nArgument: message ... - String. Optional. Message to display to the user in the dialog.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/darwin.sh"
sourceHash="fc8738a3039d92fa8d3b8455aca247fed1d6b6a9"
sourceLine="127"
summary="Display a notification for the user"
summaryComputed="true"
usage="darwinNotification [ --title ] [ --debug ] [ --sound soundName ] [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdarwinNotification'$'\e''[0m '$'\e''[[(blue)]m[ --title ]'$'\e''[0m '$'\e''[[(blue)]m[ --debug ]'$'\e''[0m '$'\e''[[(blue)]m[ --sound soundName ]'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--title            '$'\e''[[(value)]mString. Optional. Title of the notification.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--debug            '$'\e''[[(value)]mFlag. Optional. Output the osascript as '$'\e''[[(code)]mdarwinNotification.debug'$'\e''[[(reset)]m at the application root after this call.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--sound soundName  '$'\e''[[(value)]mString. Optional. Sound to play with the notification. Represents a sound base name found in '$'\e''[[(code)]m/Library/Sounds/'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...        '$'\e''[[(value)]mString. Optional. Message to display to the user in the dialog.'$'\e''[[(reset)]m'$'\n'''$'\n''Display a notification for the user'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: darwinNotification [ --title ] [ --debug ] [ --sound soundName ] [ message ... ]'$'\n'''$'\n''    --title            String. Optional. Title of the notification.'$'\n''    --debug            Flag. Optional. Output the osascript as darwinNotification.debug at the application root after this call.'$'\n''    --sound soundName  String. Optional. Sound to play with the notification. Represents a sound base name found in /Library/Sounds/.'$'\n''    message ...        String. Optional. Message to display to the user in the dialog.'$'\n'''$'\n''Display a notification for the user'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/darwin.md"
