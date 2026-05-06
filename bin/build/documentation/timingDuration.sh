#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="duration - UnsignedInteger. Optional. Timing to output"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--stop stopUnit - String. Optional. Stop displaying fractional output after this unit is displayed."$'\n'""
base="timing.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output timing like \"1 day, 2 hours, 3 minutes, 4 seconds, 5 ms\""$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/timing.sh"
fn="timingDuration"
fnMarker="timingduration"
foundNames=([0]="argument")
line="191"
rawComment="Output timing like \"1 day, 2 hours, 3 minutes, 4 seconds, 5 ms\""$'\n'"Argument: duration - UnsignedInteger. Optional. Timing to output"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --stop stopUnit - String. Optional. Stop displaying fractional output after this unit is displayed."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/timing.sh"
sourceHash="752e3f656f86676b045a390a6cda420507fab0e1"
sourceLine="191"
summary="Output timing like \"1 day, 2 hours, 3 minutes, 4"
summaryComputed="true"
usage="timingDuration [ duration ] [ --help ] [ --handler handler ] [ --stop stopUnit ]"
