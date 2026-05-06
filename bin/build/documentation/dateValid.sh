#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"-- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"text - String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations."$'\n'""
base="date.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Checks a date syntax and ensures it's a valid calendar date."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/date.sh"
fn="dateValid"
fnMarker="datevalid"
foundNames=([0]="summary" [1]="argument")
line="192"
rawComment="Summary: Is a date valid?"$'\n'"Checks a date syntax and ensures it's a valid calendar date."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning."$'\n'"Argument: text - String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/date.sh"
sourceHash="8b6a5808143207c1b2329179a4d73d95ea46d8cc"
sourceLine="192"
summary="Is a date valid?"
summaryComputed=""
usage="dateValid [ --help ] [ -- ] text"
