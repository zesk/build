#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="filename ... - File to fetch modification time"$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Fetch the modification time of a file as a timestamp"$'\n'""$'\n'""
descriptionLineCount="2"
example="    fileModificationTime ~/.bash_profile"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModificationTime"
fnMarker="filemodificationtime"
foundNames=([0]="argument" [1]="return_code" [2]="example")
line="60"
rawComment="Fetch the modification time of a file as a timestamp"$'\n'"Argument: filename ... - File to fetch modification time"$'\n'"Return Code: 2 - If file does not exist"$'\n'"Return Code: 0 - If file exists and modification times are output, one per line"$'\n'"Example:     fileModificationTime ~/.bash_profile"$'\n'""$'\n'""
return_code="2 - If file does not exist"$'\n'"0 - If file exists and modification times are output, one per line"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="60"
summary="Fetch the modification time of a file as a timestamp"
summaryComputed="true"
usage="fileModificationTime [ filename ... ]"
