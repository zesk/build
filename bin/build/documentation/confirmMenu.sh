#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--choice choiceCharacter - String. Required. Character to accept."$'\n'"--default default - String. Optional. Character to choose when there is a timeout or other failure."$'\n'"--result resultFile - File. Required. File to write the result to."$'\n'"--attempts attemptCount - PositiveInteger. Optional.Number of attempts to try and get valid unput from the user."$'\n'"--timeout timeoutSeconds - PositiveInteger. Optional.Number of seconds to wait for user input before stopping."$'\n'"--prompt promptString - String. Optional. String to suffix the prompt with (usually tells the user what to do)"$'\n'"message - String. Optional. Display this message as the confirmation menu."$'\n'""
base="interactive.sh"
description="Ask the user for a menu of options"$'\n'""$'\n'"Return Code: interrupt - Attempts exceeded"$'\n'"Return Code: timeout - Timeout"$'\n'""
file="bin/build/tools/interactive.sh"
fn="confirmMenu"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/interactive.sh"
sourceModified="1768695708"
summary="Ask the user for a menu of options"
usage="confirmMenu --choice choiceCharacter [ --default default ] --result resultFile [ --attempts attemptCount ] [ --timeout timeoutSeconds ] [ --prompt promptString ] [ message ]"
