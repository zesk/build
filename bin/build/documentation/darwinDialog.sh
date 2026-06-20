#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--choice choiceText - String. Optional. Title of the thing.\n--ok - Flag. Optional. Adds "OK" as an option.\n--cancel - Flag. Optional. Adds "Cancel" as an option.\n--default buttonIndex - Integer. Required. The button (0-based index) to make the default button choice.\n--help - Flag. Optional. Display this help.\nmessage ... - String. Required. The message to display in the dialog.\n'
base="darwin.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Display a dialog using `osascript` with the choices provided. Typically this is found on Mac OS X.\nOutputs the selected button text upon exit.\n\n'
descriptionLineCount="3"
file="bin/build/tools/darwin.sh"
fn="darwinDialog"
fnMarker="darwindialog"
foundNames=([0]="argument" [1]="platform")
line="200"
original="darwinDialog"
platform=$'Darwin\n'
rawComment=$'Argument: --choice choiceText - String. Optional. Title of the thing.\nArgument: --ok - Flag. Optional. Adds "OK" as an option.\nArgument: --cancel - Flag. Optional. Adds "Cancel" as an option.\nArgument: --default buttonIndex - Integer. Required. The button (0-based index) to make the default button choice.\nArgument: --help - Flag. Optional. Display this help.\nArgument: message ... - String. Required. The message to display in the dialog.\nDisplay a dialog using `osascript` with the choices provided. Typically this is found on Mac OS X.\nOutputs the selected button text upon exit.\nPlatform: Darwin\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/darwin.sh"
sourceHash="fc8738a3039d92fa8d3b8455aca247fed1d6b6a9"
sourceLine="200"
summary="Display a dialog using \`osascript\` with the choices provided. Typically"
summaryComputed="true"
usage="darwinDialog [ --choice choiceText ] [ --ok ] [ --cancel ] --default buttonIndex [ --help ] message ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdarwinDialog'$'\e''[0m '$'\e''[[(blue)]m[ --choice choiceText ]'$'\e''[0m '$'\e''[[(blue)]m[ --ok ]'$'\e''[0m '$'\e''[[(blue)]m[ --cancel ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--default buttonIndex'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mmessage ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--choice choiceText    '$'\e''[[(value)]mString. Optional. Title of the thing.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--ok                   '$'\e''[[(value)]mFlag. Optional. Adds "OK" as an option.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--cancel               '$'\e''[[(value)]mFlag. Optional. Adds "Cancel" as an option.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--default buttonIndex  '$'\e''[[(value)]mInteger. Required. The button (0-based index) to make the default button choice.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                 '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mmessage ...            '$'\e''[[(value)]mString. Required. The message to display in the dialog.'$'\e''[[(reset)]m'$'\n'''$'\n''Display a dialog using '$'\e''[[(code)]mosascript'$'\e''[[(reset)]m with the choices provided. Typically this is found on Mac OS X.'$'\n''Outputs the selected button text upon exit.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: darwinDialog [ --choice choiceText ] [ --ok ] [ --cancel ] --default buttonIndex [ --help ] message ...'$'\n'''$'\n''    --choice choiceText    String. Optional. Title of the thing.'$'\n''    --ok                   Flag. Optional. Adds "OK" as an option.'$'\n''    --cancel               Flag. Optional. Adds "Cancel" as an option.'$'\n''    --default buttonIndex  Integer. Required. The button (0-based index) to make the default button choice.'$'\n''    --help                 Flag. Optional. Display this help.'$'\n''    message ...            String. Required. The message to display in the dialog.'$'\n'''$'\n''Display a dialog using osascript with the choices provided. Typically this is found on Mac OS X.'$'\n''Outputs the selected button text upon exit.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/darwin.md"
