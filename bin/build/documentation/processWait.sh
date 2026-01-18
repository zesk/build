#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/process.sh"
argument="processId - Integer. Required. Wait for process ID to exit."$'\n'"--timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever."$'\n'"--signals signal - List of strings. Optional. Send each signal to processes, in order."$'\n'"--require - Flag. Optional. Require all processes to be alive upon first invocation."$'\n'""
base="process.sh"
description="Wait for processes not owned by this process to exit, and send signals to terminate processes."$'\n'""$'\n'""$'\n'""
file="bin/build/tools/process.sh"
fn="processWait"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/process.sh"
sourceModified="1768695708"
summary="Wait for processes not owned by this process to exit,"
usage="processWait processId [ --timeout seconds ] [ --signals signal ] [ --require ]"
