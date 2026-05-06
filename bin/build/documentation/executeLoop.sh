#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"--until exitCode - Integer. Optional. Check until exit code matches this."$'\n'"--title title - String. Optional. Display this title instead of the command."$'\n'"arguments ... - Optional. Arguments. Arguments to \`loopCallable\`"$'\n'""
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run checks interactively until errors are all fixed."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/interactive.sh"
fn="executeLoop"
fnMarker="executeloop"
foundNames=([0]="argument")
line="197"
rawComment="Argument: loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"Argument: --until exitCode - Integer. Optional. Check until exit code matches this."$'\n'"Argument: --title title - String. Optional. Display this title instead of the command."$'\n'"Argument: arguments ... - Optional. Arguments. Arguments to \`loopCallable\`"$'\n'"Run checks interactively until errors are all fixed."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="197"
summary="Run checks interactively until errors are all fixed."
summaryComputed="true"
usage="executeLoop loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]"
