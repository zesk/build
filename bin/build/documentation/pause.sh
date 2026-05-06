#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"message ... - Display this message while pausing"$'\n'""
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Pause for user input"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/interactive.sh"
fn="pause"
fnMarker="pause"
foundNames=([0]="argument")
line="31"
rawComment="Pause for user input"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"Argument: message ... - Display this message while pausing"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="31"
summary="Pause for user input"
summaryComputed="true"
usage="pause [ --help ] [ -- ] [ message ... ]"
