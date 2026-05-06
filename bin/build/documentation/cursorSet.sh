#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="x - UnsignedInteger. Required. Column to place the cursor."$'\n'"y - UnsignedInteger. Required. Row to place the cursor."$'\n'""
base="cursor.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Move the cursor to x y"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/cursor.sh"
fn="cursorSet"
fnMarker="cursorset"
foundNames=([0]="argument")
line="41"
rawComment="Move the cursor to x y"$'\n'"Argument: x - UnsignedInteger. Required. Column to place the cursor."$'\n'"Argument: y - UnsignedInteger. Required. Row to place the cursor."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/cursor.sh"
sourceHash="168857d25babe32c4b67235ad26a6f7d090b0a94"
sourceLine="41"
summary="Move the cursor to x y"
summaryComputed="true"
usage="cursorSet x y"
