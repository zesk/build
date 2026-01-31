#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="process.sh"
description="Wait for processes not owned by this process to exit, and send signals to terminate processes."$'\n'"Argument: processId - Integer. Required. Wait for process ID to exit."$'\n'"Argument: --timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever."$'\n'"Argument: --signals signal - CommaDelimitedList. Optional. Send each signal to processes, in order."$'\n'"Argument: --require - Flag. Optional. Require all processes to be alive upon first invocation."$'\n'""
file="bin/build/tools/process.sh"
foundNames=()
rawComment="Wait for processes not owned by this process to exit, and send signals to terminate processes."$'\n'"Argument: processId - Integer. Required. Wait for process ID to exit."$'\n'"Argument: --timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever."$'\n'"Argument: --signals signal - CommaDelimitedList. Optional. Send each signal to processes, in order."$'\n'"Argument: --require - Flag. Optional. Require all processes to be alive upon first invocation."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/process.sh"
sourceHash="36fbe746ad780ed0b3b8040cb1a41429d089fbbc"
summary="Wait for processes not owned by this process to exit,"
usage="processWait"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mprocessWait'$'\e''[0m'$'\n'''$'\n''Wait for processes not owned by this process to exit, and send signals to terminate processes.'$'\n''Argument: processId - Integer. Required. Wait for process ID to exit.'$'\n''Argument: --timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever.'$'\n''Argument: --signals signal - CommaDelimitedList. Optional. Send each signal to processes, in order.'$'\n''Argument: --require - Flag. Optional. Require all processes to be alive upon first invocation.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: processWait'$'\n'''$'\n''Wait for processes not owned by this process to exit, and send signals to terminate processes.'$'\n''Argument: processId - Integer. Required. Wait for process ID to exit.'$'\n''Argument: --timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever.'$'\n''Argument: --signals signal - CommaDelimitedList. Optional. Send each signal to processes, in order.'$'\n''Argument: --require - Flag. Optional. Require all processes to be alive upon first invocation.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.469
