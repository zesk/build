#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="file - File. Optional. One or more files, all of which must be empty."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is this an empty (zero-sized) file?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="fileIsEmpty"
fnMarker="fileisempty"
foundNames=([0]="return_code" [1]="argument")
line="632"
rawComment="Is this an empty (zero-sized) file?"$'\n'"Return Code: 0 - if all files passed in are empty files"$'\n'"Return Code: 1 - if any files passed in are non-empty files"$'\n'"Argument: file - File. Optional. One or more files, all of which must be empty."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - if all files passed in are empty files"$'\n'"1 - if any files passed in are non-empty files"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="632"
summary="Is this an empty (zero-sized) file?"
summaryComputed="true"
usage="fileIsEmpty [ file ] [ --help ]"
