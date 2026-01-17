#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/timing.sh"
argument="timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="timing.sh"
description="Show elapsed time from a start time"$'\n'""
example="    init=\$(timingStart)"$'\n'"    ..."$'\n'"    timingElapsed \"\$init\""$'\n'""
file="bin/build/tools/timing.sh"
fn="timingElapsed"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="requires")
requires="__timestamp returnEnvironment validate date"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/timing.sh"
sourceModified="1768683853"
summary="Show elapsed time from a start time"$'\n'""
usage="timingElapsed timingOffset [ --help ]"
