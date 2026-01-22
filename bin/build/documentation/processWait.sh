#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/process.sh"
argument="processId - Integer. Required. Wait for process ID to exit."$'\n'"--timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever."$'\n'"--signals signal - CommaDelimitedList. Optional. Send each signal to processes, in order."$'\n'"--require - Flag. Optional. Require all processes to be alive upon first invocation."$'\n'""
base="process.sh"
description="Wait for processes not owned by this process to exit, and send signals to terminate processes."$'\n'""$'\n'""$'\n'""
file="bin/build/tools/process.sh"
fn="processWait"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/process.sh"
sourceModified="1768760463"
summary="Wait for processes not owned by this process to exit,"
usage="processWait processId [ --timeout seconds ] [ --signals signal ] [ --require ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mprocessWait[0m [38;2;255;255;0m[35;48;2;0;0;0mprocessId[0m[0m [94m[ --timeout seconds ][0m [94m[ --signals signal ][0m [94m[ --require ][0m

    [31mprocessId          [1;97mInteger. Required. Wait for process ID to exit.[0m
    [94m--timeout seconds  [1;97mInteger. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever.[0m
    [94m--signals signal   [1;97mCommaDelimitedList. Optional. Send each signal to processes, in order.[0m
    [94m--require          [1;97mFlag. Optional. Require all processes to be alive upon first invocation.[0m

Wait for processes not owned by this process to exit, and send signals to terminate processes.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: processWait processId [ --timeout seconds ] [ --signals signal ] [ --require ]

    processId          Integer. Required. Wait for process ID to exit.
    --timeout seconds  Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever.
    --signals signal   CommaDelimitedList. Optional. Send each signal to processes, in order.
    --require          Flag. Optional. Require all processes to be alive upon first invocation.

Wait for processes not owned by this process to exit, and send signals to terminate processes.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
