#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/darwin.sh"
argument="--choice choiceText - String. Optional. Title of the thing."$'\n'"--ok - Flag. Optional.Adds \"OK\" as an option."$'\n'"--cancel - Flag. Optional.Adds \"Cancel\" as an option."$'\n'"--default buttonIndex - Integer. Required. The button (0-based index) to make the default button choice."$'\n'"--help - Flag. Optional.Display this help."$'\n'"message ... - String. Required. The message to display in the dialog."$'\n'""
base="darwin.sh"
description="Display a dialog using \`osascript\` with the choices provided. Typically this is found on Mac OS X."$'\n'"Outputs the selected button text upon exit."$'\n'""
file="bin/build/tools/darwin.sh"
fn="darwinDialog"
foundNames=([0]="argument" [1]="platform")
platform="Darwin"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/darwin.sh"
sourceModified="1768695708"
summary="Display a dialog using \`osascript\` with the choices provided. Typically"
usage="darwinDialog [ --choice choiceText ] [ --ok ] [ --cancel ] --default buttonIndex [ --help ] message ..."
