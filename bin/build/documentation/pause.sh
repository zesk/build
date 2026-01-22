#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"message ... - Display this message while pausing"$'\n'""
base="interactive.sh"
description="Pause for user input"$'\n'""
file="bin/build/tools/interactive.sh"
fn="pause"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Pause for user input"
usage="pause [ --help ] [ -- ] [ message ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpause[0m [94m[ --help ][0m [94m[ -- ][0m [94m[ message ... ][0m

    [94m--help       [1;97mFlag. Optional. Display this help.[0m
    [94m--           [1;97mFlag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.[0m
    [94mmessage ...  [1;97mDisplay this message while pausing[0m

Pause for user input

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: pause [ --help ] [ -- ] [ message ... ]

    --help       Flag. Optional. Display this help.
    --           Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
    message ...  Display this message while pausing

Pause for user input

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
