#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="file ... - File. Required. One or more files to examine"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Prints seconds since modified"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="fileModifiedSeconds"
fnMarker="filemodifiedseconds"
foundNames=([0]="argument" [1]="return_code")
line="256"
rawComment="Prints seconds since modified"$'\n'"Argument: file ... - File. Required. One or more files to examine"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Can not get modification time"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"2 - Can not get modification time"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="256"
summary="Prints seconds since modified"
summaryComputed="true"
usage="fileModifiedSeconds file ... [ --help ]"
