#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/timing.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="timing.sh"
description="Outputs the offset in milliseconds from January 1, 1970."$'\n'""$'\n'"Should never fail, unless date is not installed"$'\n'""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingReport \"\$init\" \"Completed in\""$'\n'""
file="bin/build/tools/timing.sh"
fn="timingStart"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
requires="__timestamp, returnEnvironment date"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/timing.sh"
sourceModified="1768721469"
summary="Start a timer"$'\n'""
usage="timingStart [ --help ]"
