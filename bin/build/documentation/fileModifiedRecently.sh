#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="directory - Directory. Required. Must exists - directory to list."$'\n'"findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List the most recently modified file in a directory prefixed with the timestamp"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="fileModifiedRecently"
fnMarker="filemodifiedrecently"
foundNames=([0]="argument")
line="132"
rawComment="List the most recently modified file in a directory prefixed with the timestamp"$'\n'"Argument: directory - Directory. Required. Must exists - directory to list."$'\n'"Argument: findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="132"
summary="List the most recently modified file in a directory prefixed"
summaryComputed="true"
usage="fileModifiedRecently directory [ findArgs ]"
