#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--default defaultValue - Boolean. Optional. Value to return if no value given by user"$'\n'"--attempts attempts - PositiveInteger. Optional. User can give us a bad response this many times before we return the default."$'\n'"--timeout seconds - PositiveInteger. Optional. Wait this long before choosing the default. If no default, default is --no."$'\n'"--info - Flag. Optional. Add \`Type Y or N\` as instructions to the user."$'\n'"--yes - Flag. Optional. Short for \`--default yes\`"$'\n'"--no - Flag. Optional. Short for \`--default no\`"$'\n'"--help -  Flag. Optional.Display this help."$'\n'"--handler handler -  Function. Optional.Use this error handler instead of the default error handler."$'\n'"message ... - String. Any additional arguments are considered part of the message."$'\n'""
base="interactive.sh"
description="Read user input and return 0 if the user says yes, or non-zero if they say no"$'\n'"Return Code: 0 - Yes"$'\n'"Return Code: 1 - No"$'\n'"Example: Will time out after 10 seconds, regardless (user must make valid input in that time):"$'\n'"Example:"$'\n'"Example:"$'\n'""
example="    confirmYesNo --timeout 10 \"Stop the timer!\""$'\n'""
file="bin/build/tools/interactive.sh"
fn="confirmYesNo"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/interactive.sh"
sourceModified="1768683999"
summary="Read user input and return success on yes"$'\n'""
usage="confirmYesNo [ --default defaultValue ] [ --attempts attempts ] [ --timeout seconds ] [ --info ] [ --yes ] [ --no ] [ --help ] [ --handler handler ] [ message ... ]"
