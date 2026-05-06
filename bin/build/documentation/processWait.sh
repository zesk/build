#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="processId - Integer. Required. Wait for process ID to exit."$'\n'"--timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever."$'\n'"--signals signal - CommaDelimitedList. Optional. Send each signal to processes, in order."$'\n'"--require - Flag. Optional. Require all processes to be alive upon first invocation."$'\n'""
base="process.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Wait for processes not owned by this process to exit, and send signals to terminate processes."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/process.sh"
fn="processWait"
fnMarker="processwait"
foundNames=([0]="argument")
line="36"
rawComment="Wait for processes not owned by this process to exit, and send signals to terminate processes."$'\n'"Argument: processId - Integer. Required. Wait for process ID to exit."$'\n'"Argument: --timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever."$'\n'"Argument: --signals signal - CommaDelimitedList. Optional. Send each signal to processes, in order."$'\n'"Argument: --require - Flag. Optional. Require all processes to be alive upon first invocation."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/process.sh"
sourceHash="9a9162fce05d86abc173c620c9416ff86fe4e013"
sourceLine="36"
summary="Wait for processes not owned by this process to exit,"
summaryComputed="true"
usage="processWait processId [ --timeout seconds ] [ --signals signal ] [ --require ]"
