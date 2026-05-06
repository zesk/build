#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--default defaultValue - Boolean. Optional. Value to return if no value given by user"$'\n'"--attempts attempts - PositiveInteger. Optional. User can give us a bad response this many times before we return the default."$'\n'"--timeout seconds - PositiveInteger. Optional. Wait this long before choosing the default. If no default, default is --no."$'\n'"--info - Flag. Optional. Add \`Type Y or N\` as instructions to the user."$'\n'"--yes - Flag. Optional. Short for \`--default yes\`"$'\n'"--no - Flag. Optional. Short for \`--default no\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"message ... - String. Any additional arguments are considered part of the message."$'\n'""
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Read user input and return 0 if the user says yes, or non-zero if they say no"$'\n'"Example: Will time out after 10 seconds, regardless (user must make valid input in that time):"$'\n'"Example:"$'\n'"Example:"$'\n'""$'\n'""
descriptionLineCount="5"
example="    confirmYesNo --timeout 10 \"Stop the timer!\""$'\n'""
file="bin/build/tools/interactive.sh"
fn="confirmYesNo"
fnMarker="confirmyesno"
foundNames=([0]="return_code" [1]="summary" [2]="argument" [3]="example")
line="164"
rawComment="Read user input and return 0 if the user says yes, or non-zero if they say no"$'\n'"Return Code: 0 - Yes"$'\n'"Return Code: 1 - No"$'\n'"Summary: Read user input and return success on yes"$'\n'"Argument: --default defaultValue - Boolean. Optional. Value to return if no value given by user"$'\n'"Argument: --attempts attempts - PositiveInteger. Optional. User can give us a bad response this many times before we return the default."$'\n'"Argument: --timeout seconds - PositiveInteger. Optional. Wait this long before choosing the default. If no default, default is --no."$'\n'"Argument: --info - Flag. Optional. Add \`Type Y or N\` as instructions to the user."$'\n'"Argument: --yes - Flag. Optional. Short for \`--default yes\`"$'\n'"Argument: --no - Flag. Optional. Short for \`--default no\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: message ... - String. Any additional arguments are considered part of the message."$'\n'"Example: Will time out after 10 seconds, regardless (user must make valid input in that time):"$'\n'"Example:"$'\n'"Example:     confirmYesNo --timeout 10 \"Stop the timer!\""$'\n'"Example:"$'\n'""$'\n'""
return_code="0 - Yes"$'\n'"1 - No"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="164"
summary="Read user input and return success on yes"
summaryComputed=""
usage="confirmYesNo [ --default defaultValue ] [ --attempts attempts ] [ --timeout seconds ] [ --info ] [ --yes ] [ --no ] [ --help ] [ --handler handler ] [ message ... ]"
