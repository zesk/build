#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="directory - Directory. Required. Directory to search for the oldest file."$'\n'"--find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)"$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Find the oldest modified file in a directory"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/file.sh"
fn="directoryOldestFile"
fnMarker="directoryoldestfile"
foundNames=([0]="argument")
line="707"
rawComment="Find the oldest modified file in a directory"$'\n'"Argument: directory - Directory. Required. Directory to search for the oldest file."$'\n'"Argument: --find findArgs ... -- - Arguments. Optional. Arguments delimited by a double-dash (or end of argument list)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="707"
summary="Find the oldest modified file in a directory"
summaryComputed="true"
usage="directoryOldestFile directory [ --find findArgs ... -- ]"
