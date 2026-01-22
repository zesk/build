#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--default defaultValue - Boolean. Optional. Value to return if no value given by user"$'\n'"--attempts attempts - PositiveInteger. Optional. User can give us a bad response this many times before we return the default."$'\n'"--timeout seconds - PositiveInteger. Optional. Wait this long before choosing the default. If no default, default is --no."$'\n'"--info - Flag. Optional. Add \`Type Y or N\` as instructions to the user."$'\n'"--yes - Flag. Optional. Short for \`--default yes\`"$'\n'"--no - Flag. Optional. Short for \`--default no\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"message ... - String. Any additional arguments are considered part of the message."$'\n'""
base="interactive.sh"
description="Read user input and return 0 if the user says yes, or non-zero if they say no"$'\n'"Return Code: 0 - Yes"$'\n'"Return Code: 1 - No"$'\n'"Example: Will time out after 10 seconds, regardless (user must make valid input in that time):"$'\n'"Example:"$'\n'"Example:"$'\n'""
example="    confirmYesNo --timeout 10 \"Stop the timer!\""$'\n'""
file="bin/build/tools/interactive.sh"
fn="confirmYesNo"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Read user input and return success on yes"$'\n'""
usage="confirmYesNo [ --default defaultValue ] [ --attempts attempts ] [ --timeout seconds ] [ --info ] [ --yes ] [ --no ] [ --help ] [ --handler handler ] [ message ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mconfirmYesNo[0m [94m[ --default defaultValue ][0m [94m[ --attempts attempts ][0m [94m[ --timeout seconds ][0m [94m[ --info ][0m [94m[ --yes ][0m [94m[ --no ][0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ message ... ][0m

    [94m--default defaultValue  [1;97mBoolean. Optional. Value to return if no value given by user[0m
    [94m--attempts attempts     [1;97mPositiveInteger. Optional. User can give us a bad response this many times before we return the default.[0m
    [94m--timeout seconds       [1;97mPositiveInteger. Optional. Wait this long before choosing the default. If no default, default is --no.[0m
    [94m--info                  [1;97mFlag. Optional. Add [38;2;0;255;0;48;2;0;0;0mType Y or N[0m as instructions to the user.[0m
    [94m--yes                   [1;97mFlag. Optional. Short for [38;2;0;255;0;48;2;0;0;0m--default yes[0m[0m
    [94m--no                    [1;97mFlag. Optional. Short for [38;2;0;255;0;48;2;0;0;0m--default no[0m[0m
    [94m--help                  [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler       [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94mmessage ...             [1;97mString. Any additional arguments are considered part of the message.[0m

Read user input and return 0 if the user says yes, or non-zero if they say no
Return Code: 0 - Yes
Return Code: 1 - No
Example: Will time out after 10 seconds, regardless (user must make valid input in that time):
Example:
Example:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    confirmYesNo --timeout 10 "Stop the timer!"
'
# shellcheck disable=SC2016
helpPlain='Usage: confirmYesNo [ --default defaultValue ] [ --attempts attempts ] [ --timeout seconds ] [ --info ] [ --yes ] [ --no ] [ --help ] [ --handler handler ] [ message ... ]

    --default defaultValue  Boolean. Optional. Value to return if no value given by user
    --attempts attempts     PositiveInteger. Optional. User can give us a bad response this many times before we return the default.
    --timeout seconds       PositiveInteger. Optional. Wait this long before choosing the default. If no default, default is --no.
    --info                  Flag. Optional. Add Type Y or N as instructions to the user.
    --yes                   Flag. Optional. Short for --default yes
    --no                    Flag. Optional. Short for --default no
    --help                  Flag. Optional. Display this help.
    --handler handler       Function. Optional. Use this error handler instead of the default error handler.
    message ...             String. Any additional arguments are considered part of the message.

Read user input and return 0 if the user says yes, or non-zero if they say no
Return Code: 0 - Yes
Return Code: 1 - No
Example: Will time out after 10 seconds, regardless (user must make valid input in that time):
Example:
Example:

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    confirmYesNo --timeout 10 "Stop the timer!"
'
