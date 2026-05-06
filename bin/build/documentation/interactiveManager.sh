#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"--exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"fileToCheck ... - File. Optional. Shell file to validate. May also supply file names via stdin."$'\n'""
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run checks interactively until errors are all fixed."$'\n'"Not ready for prime time yet - written not tested."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/interactive.sh"
fn="interactiveManager"
fnMarker="interactivemanager"
foundNames=([0]="argument")
line="211"
rawComment="Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"Argument: --exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: fileToCheck ... - File. Optional. Shell file to validate. May also supply file names via stdin."$'\n'"Run checks interactively until errors are all fixed."$'\n'"Not ready for prime time yet - written not tested."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="211"
summary="Run checks interactively until errors are all fixed."
summaryComputed="true"
usage="interactiveManager loopCallable [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]"
