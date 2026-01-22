#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/darwin.sh"
argument="--choice choiceText - String. Optional. Title of the thing."$'\n'"--ok - Flag. Optional. Adds \"OK\" as an option."$'\n'"--cancel - Flag. Optional. Adds \"Cancel\" as an option."$'\n'"--default buttonIndex - Integer. Required. The button (0-based index) to make the default button choice."$'\n'"--help - Flag. Optional. Display this help."$'\n'"message ... - String. Required. The message to display in the dialog."$'\n'""
base="darwin.sh"
description="Display a dialog using \`osascript\` with the choices provided. Typically this is found on Mac OS X."$'\n'"Outputs the selected button text upon exit."$'\n'""
file="bin/build/tools/darwin.sh"
fn="darwinDialog"
foundNames=""
platform="Darwin"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/darwin.sh"
sourceModified="1769063211"
summary="Display a dialog using \`osascript\` with the choices provided. Typically"
usage="darwinDialog [ --choice choiceText ] [ --ok ] [ --cancel ] --default buttonIndex [ --help ] message ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdarwinDialog[0m [94m[ --choice choiceText ][0m [94m[ --ok ][0m [94m[ --cancel ][0m [38;2;255;255;0m[35;48;2;0;0;0m--default buttonIndex[0m[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mmessage ...[0m[0m

    [94m--choice choiceText    [1;97mString. Optional. Title of the thing.[0m
    [94m--ok                   [1;97mFlag. Optional. Adds "OK" as an option.[0m
    [94m--cancel               [1;97mFlag. Optional. Adds "Cancel" as an option.[0m
    [31m--default buttonIndex  [1;97mInteger. Required. The button (0-based index) to make the default button choice.[0m
    [94m--help                 [1;97mFlag. Optional. Display this help.[0m
    [31mmessage ...            [1;97mString. Required. The message to display in the dialog.[0m

Display a dialog using [38;2;0;255;0;48;2;0;0;0mosascript[0m with the choices provided. Typically this is found on Mac OS X.
Outputs the selected button text upon exit.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: darwinDialog [ --choice choiceText ] [ --ok ] [ --cancel ] --default buttonIndex [ --help ] message ...

    --choice choiceText    String. Optional. Title of the thing.
    --ok                   Flag. Optional. Adds "OK" as an option.
    --cancel               Flag. Optional. Adds "Cancel" as an option.
    --default buttonIndex  Integer. Required. The button (0-based index) to make the default button choice.
    --help                 Flag. Optional. Display this help.
    message ...            String. Required. The message to display in the dialog.

Display a dialog using osascript with the choices provided. Typically this is found on Mac OS X.
Outputs the selected button text upon exit.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
