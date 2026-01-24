#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/process.sh"
argument="processId - Integer. Required. Wait for process ID to exit."$'\n'"--timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever."$'\n'"--signals signal - CommaDelimitedList. Optional. Send each signal to processes, in order."$'\n'"--require - Flag. Optional. Require all processes to be alive upon first invocation."$'\n'""
base="process.sh"
description="Wait for processes not owned by this process to exit, and send signals to terminate processes."$'\n'""
exitCode="0"
file="bin/build/tools/process.sh"
foundNames=([0]="argument")
rawComment="Wait for processes not owned by this process to exit, and send signals to terminate processes."$'\n'"Argument: processId - Integer. Required. Wait for process ID to exit."$'\n'"Argument: --timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever."$'\n'"Argument: --signals signal - CommaDelimitedList. Optional. Send each signal to processes, in order."$'\n'"Argument: --require - Flag. Optional. Require all processes to be alive upon first invocation."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="Wait for processes not owned by this process to exit,"
usage="processWait processId [ --timeout seconds ] [ --signals signal ] [ --require ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mprocessWait'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mprocessId'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ --timeout seconds ]'$'\e''[0m '$'\e''[[blue]m[ --signals signal ]'$'\e''[0m '$'\e''[[blue]m[ --require ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mprocessId          '$'\e''[[value]mInteger. Required. Wait for process ID to exit.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--timeout seconds  '$'\e''[[value]mInteger. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--signals signal   '$'\e''[[value]mCommaDelimitedList. Optional. Send each signal to processes, in order.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--require          '$'\e''[[value]mFlag. Optional. Require all processes to be alive upon first invocation.'$'\e''[[reset]m'$'\n'''$'\n''Wait for processes not owned by this process to exit, and send signals to terminate processes.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: processWait processId [ --timeout seconds ] [ --signals signal ] [ --require ]'$'\n'''$'\n''    processId          Integer. Required. Wait for process ID to exit.'$'\n''    --timeout seconds  Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever.'$'\n''    --signals signal   CommaDelimitedList. Optional. Send each signal to processes, in order.'$'\n''    --require          Flag. Optional. Require all processes to be alive upon first invocation.'$'\n'''$'\n''Wait for processes not owned by this process to exit, and send signals to terminate processes.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
