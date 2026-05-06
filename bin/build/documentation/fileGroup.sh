#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="file - File to get the owner for"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the file group name"$'\n'"Outputs the file group for each file passed on the command line"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="fileGroup"
fnMarker="filegroup"
foundNames=([0]="argument" [1]="return_code")
line="523"
rawComment="Get the file group name"$'\n'"Argument: file - File to get the owner for"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Outputs the file group for each file passed on the command line"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Unable to access file"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Unable to access file"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="523"
summary="Get the file group name"
summaryComputed="true"
usage="fileGroup [ file ] [ --help ]"
