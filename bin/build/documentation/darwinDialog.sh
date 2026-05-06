#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--choice choiceText - String. Optional. Title of the thing."$'\n'"--ok - Flag. Optional. Adds \"OK\" as an option."$'\n'"--cancel - Flag. Optional. Adds \"Cancel\" as an option."$'\n'"--default buttonIndex - Integer. Required. The button (0-based index) to make the default button choice."$'\n'"--help - Flag. Optional. Display this help."$'\n'"message ... - String. Required. The message to display in the dialog."$'\n'""
base="darwin.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Display a dialog using \`osascript\` with the choices provided. Typically this is found on Mac OS X."$'\n'"Outputs the selected button text upon exit."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/darwin.sh"
fn="darwinDialog"
fnMarker="darwindialog"
foundNames=([0]="argument" [1]="platform")
line="200"
platform="Darwin"$'\n'""
rawComment="Argument: --choice choiceText - String. Optional. Title of the thing."$'\n'"Argument: --ok - Flag. Optional. Adds \"OK\" as an option."$'\n'"Argument: --cancel - Flag. Optional. Adds \"Cancel\" as an option."$'\n'"Argument: --default buttonIndex - Integer. Required. The button (0-based index) to make the default button choice."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: message ... - String. Required. The message to display in the dialog."$'\n'"Display a dialog using \`osascript\` with the choices provided. Typically this is found on Mac OS X."$'\n'"Outputs the selected button text upon exit."$'\n'"Platform: Darwin"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/darwin.sh"
sourceHash="ec705e085d0b6db06177741d264497efd1aa9f27"
sourceLine="200"
summary="Display a dialog using \`osascript\` with the choices provided. Typically"
summaryComputed="true"
usage="darwinDialog [ --choice choiceText ] [ --ok ] [ --cancel ] --default buttonIndex [ --help ] message ..."
