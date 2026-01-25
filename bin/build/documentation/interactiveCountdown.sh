#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--badge text - String. Display this text as bigTextAt"$'\n'"--prefix prefix - String."$'\n'"counter - Integer. Required. Count down from."$'\n'"binary - Callable. Required. Run this with any additional arguments when the countdown is completed."$'\n'"... - Arguments. Optional. Passed to binary."$'\n'""
base="interactive.sh"
description="Display a message and count down display"$'\n'""
exitCode="0"
file="bin/build/tools/interactive.sh"
foundNames=([0]="argument")
rawComment="Display a message and count down display"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --badge text - String. Display this text as bigTextAt"$'\n'"Argument: --prefix prefix - String."$'\n'"Argument: counter - Integer. Required. Count down from."$'\n'"Argument: binary - Callable. Required. Run this with any additional arguments when the countdown is completed."$'\n'"Argument: ... - Arguments. Optional. Passed to binary."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="Display a message and count down display"
usage="interactiveCountdown [ --help ] [ --badge text ] [ --prefix prefix ] counter binary [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]minteractiveCountdown'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m '$'\e''[[blue]m[ --badge text ]'$'\e''[0m '$'\e''[[blue]m[ --prefix prefix ]'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mcounter'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mbinary'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help           '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--badge text     '$'\e''[[value]mString. Display this text as bigTextAt'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--prefix prefix  '$'\e''[[value]mString.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mcounter          '$'\e''[[value]mInteger. Required. Count down from.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mbinary           '$'\e''[[value]mCallable. Required. Run this with any additional arguments when the countdown is completed.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m...              '$'\e''[[value]mArguments. Optional. Passed to binary.'$'\e''[[reset]m'$'\n'''$'\n''Display a message and count down display'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: interactiveCountdown [ --help ] [ --badge text ] [ --prefix prefix ] counter binary [ ... ]'$'\n'''$'\n''    --help           Flag. Optional. Display this help.'$'\n''    --badge text     String. Display this text as bigTextAt'$'\n''    --prefix prefix  String.'$'\n''    counter          Integer. Required. Count down from.'$'\n''    binary           Callable. Required. Run this with any additional arguments when the countdown is completed.'$'\n''    ...              Arguments. Optional. Passed to binary.'$'\n'''$'\n''Display a message and count down display'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
