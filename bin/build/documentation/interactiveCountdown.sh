#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--badge text - String. Display this text as bigTextAt"$'\n'"--prefix prefix - String."$'\n'"counter - Integer. Required. Count down from."$'\n'"binary - Callable. Required. Run this with any additional arguments when the countdown is completed."$'\n'"... - Arguments. Optional. Passed to binary."$'\n'""
base="interactive.sh"
description="Display a message and count down display"$'\n'""
file="bin/build/tools/interactive.sh"
fn="interactiveCountdown"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Display a message and count down display"
usage="interactiveCountdown [ --help ] [ --badge text ] [ --prefix prefix ] counter binary [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255minteractiveCountdown[0m [94m[ --help ][0m [94m[ --badge text ][0m [94m[ --prefix prefix ][0m [38;2;255;255;0m[35;48;2;0;0;0mcounter[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mbinary[0m[0m [94m[ ... ][0m

    [94m--help           [1;97mFlag. Optional. Display this help.[0m
    [94m--badge text     [1;97mString. Display this text as bigTextAt[0m
    [94m--prefix prefix  [1;97mString.[0m
    [31mcounter          [1;97mInteger. Required. Count down from.[0m
    [31mbinary           [1;97mCallable. Required. Run this with any additional arguments when the countdown is completed.[0m
    [94m...              [1;97mArguments. Optional. Passed to binary.[0m

Display a message and count down display

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: interactiveCountdown [ --help ] [ --badge text ] [ --prefix prefix ] counter binary [ ... ]

    --help           Flag. Optional. Display this help.
    --badge text     String. Display this text as bigTextAt
    --prefix prefix  String.
    counter          Integer. Required. Count down from.
    binary           Callable. Required. Run this with any additional arguments when the countdown is completed.
    ...              Arguments. Optional. Passed to binary.

Display a message and count down display

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
