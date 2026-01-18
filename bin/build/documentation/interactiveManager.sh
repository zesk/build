#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"--exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"fileToCheck ... - File. Optional. Shell file to validate. May also supply file names via stdin."$'\n'""
base="interactive.sh"
description="Run checks interactively until errors are all fixed."$'\n'"Not ready for prime time yet - written not tested."$'\n'""
file="bin/build/tools/interactive.sh"
fn="interactiveManager"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Run checks interactively until errors are all fixed."
usage="interactiveManager loopCallable [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]"
