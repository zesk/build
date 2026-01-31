#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="darwin.sh"
description="Argument: --choice choiceText - String. Optional. Title of the thing."$'\n'"Argument: --ok - Flag. Optional. Adds \"OK\" as an option."$'\n'"Argument: --cancel - Flag. Optional. Adds \"Cancel\" as an option."$'\n'"Argument: --default buttonIndex - Integer. Required. The button (0-based index) to make the default button choice."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: message ... - String. Required. The message to display in the dialog."$'\n'"Display a dialog using \`osascript\` with the choices provided. Typically this is found on Mac OS X."$'\n'"Outputs the selected button text upon exit."$'\n'"Platform: Darwin"$'\n'""
file="bin/build/tools/darwin.sh"
foundNames=()
rawComment="Argument: --choice choiceText - String. Optional. Title of the thing."$'\n'"Argument: --ok - Flag. Optional. Adds \"OK\" as an option."$'\n'"Argument: --cancel - Flag. Optional. Adds \"Cancel\" as an option."$'\n'"Argument: --default buttonIndex - Integer. Required. The button (0-based index) to make the default button choice."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: message ... - String. Required. The message to display in the dialog."$'\n'"Display a dialog using \`osascript\` with the choices provided. Typically this is found on Mac OS X."$'\n'"Outputs the selected button text upon exit."$'\n'"Platform: Darwin"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/darwin.sh"
sourceHash="432c767364a75cea4dd7323b34105fae4336231d"
summary="Argument: --choice choiceText - String. Optional. Title of the thing."
usage="darwinDialog"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdarwinDialog'$'\e''[0m'$'\n'''$'\n''Argument: --choice choiceText - String. Optional. Title of the thing.'$'\n''Argument: --ok - Flag. Optional. Adds "OK" as an option.'$'\n''Argument: --cancel - Flag. Optional. Adds "Cancel" as an option.'$'\n''Argument: --default buttonIndex - Integer. Required. The button (0-based index) to make the default button choice.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: message ... - String. Required. The message to display in the dialog.'$'\n''Display a dialog using '$'\e''[[(code)]mosascript'$'\e''[[(reset)]m with the choices provided. Typically this is found on Mac OS X.'$'\n''Outputs the selected button text upon exit.'$'\n''Platform: Darwin'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: darwinDialog'$'\n'''$'\n''Argument: --choice choiceText - String. Optional. Title of the thing.'$'\n''Argument: --ok - Flag. Optional. Adds "OK" as an option.'$'\n''Argument: --cancel - Flag. Optional. Adds "Cancel" as an option.'$'\n''Argument: --default buttonIndex - Integer. Required. The button (0-based index) to make the default button choice.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: message ... - String. Required. The message to display in the dialog.'$'\n''Display a dialog using osascript with the choices provided. Typically this is found on Mac OS X.'$'\n''Outputs the selected button text upon exit.'$'\n''Platform: Darwin'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.515
