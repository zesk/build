#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--choice choiceCharacter - String. Required. Character to accept."$'\n'"--default default - String. Optional. Character to choose when there is a timeout or other failure."$'\n'"--result resultFile - File. Required. File to write the result to."$'\n'"--attempts attemptCount - PositiveInteger. Optional. Number of attempts to try and get valid unput from the user."$'\n'"--timeout timeoutSeconds - PositiveInteger. Optional. Number of seconds to wait for user input before stopping."$'\n'"--prompt promptString - String. Optional. String to suffix the prompt with (usually tells the user what to do)"$'\n'"message - String. Optional. Display this message as the confirmation menu."$'\n'""
base="interactive.sh"
description="Ask the user for a menu of options"$'\n'""$'\n'"Return Code: interrupt - Attempts exceeded"$'\n'"Return Code: timeout - Timeout"$'\n'""
file="bin/build/tools/interactive.sh"
fn="confirmMenu"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Ask the user for a menu of options"
usage="confirmMenu --choice choiceCharacter [ --default default ] --result resultFile [ --attempts attemptCount ] [ --timeout timeoutSeconds ] [ --prompt promptString ] [ message ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mconfirmMenu[0m [38;2;255;255;0m[35;48;2;0;0;0m--choice choiceCharacter[0m[0m [94m[ --default default ][0m [38;2;255;255;0m[35;48;2;0;0;0m--result resultFile[0m[0m [94m[ --attempts attemptCount ][0m [94m[ --timeout timeoutSeconds ][0m [94m[ --prompt promptString ][0m [94m[ message ][0m

    [31m--choice choiceCharacter  [1;97mString. Required. Character to accept.[0m
    [94m--default default         [1;97mString. Optional. Character to choose when there is a timeout or other failure.[0m
    [31m--result resultFile       [1;97mFile. Required. File to write the result to.[0m
    [94m--attempts attemptCount   [1;97mPositiveInteger. Optional. Number of attempts to try and get valid unput from the user.[0m
    [94m--timeout timeoutSeconds  [1;97mPositiveInteger. Optional. Number of seconds to wait for user input before stopping.[0m
    [94m--prompt promptString     [1;97mString. Optional. String to suffix the prompt with (usually tells the user what to do)[0m
    [94mmessage                   [1;97mString. Optional. Display this message as the confirmation menu.[0m

Ask the user for a menu of options

Return Code: interrupt - Attempts exceeded
Return Code: timeout - Timeout

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: confirmMenu --choice choiceCharacter [ --default default ] --result resultFile [ --attempts attemptCount ] [ --timeout timeoutSeconds ] [ --prompt promptString ] [ message ]

    --choice choiceCharacter  String. Required. Character to accept.
    --default default         String. Optional. Character to choose when there is a timeout or other failure.
    --result resultFile       File. Required. File to write the result to.
    --attempts attemptCount   PositiveInteger. Optional. Number of attempts to try and get valid unput from the user.
    --timeout timeoutSeconds  PositiveInteger. Optional. Number of seconds to wait for user input before stopping.
    --prompt promptString     String. Optional. String to suffix the prompt with (usually tells the user what to do)
    message                   String. Optional. Display this message as the confirmation menu.

Ask the user for a menu of options

Return Code: interrupt - Attempts exceeded
Return Code: timeout - Timeout

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
