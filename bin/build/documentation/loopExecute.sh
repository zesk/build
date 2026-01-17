#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="loopCallable -  Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"--delay delaySeconds -  Integer. Optional.Delay in seconds between checks in interactive mode."$'\n'"--until exitCode -  Integer. Optional.Check until exit code matches this."$'\n'"--title title - String. Optional. Display this title instead of the command."$'\n'"arguments ... - Optional. Arguments to loopCallable"$'\n'""
base="interactive.sh"
description="Run checks interactively until errors are all fixed."$'\n'""
file="bin/build/tools/interactive.sh"
fn="loopExecute"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/interactive.sh"
sourceModified="1768683999"
summary="Run checks interactively until errors are all fixed."
usage="loopExecute loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]"
