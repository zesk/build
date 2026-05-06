#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="-a - Flag. Optional. Append target (atomically as well)."$'\n'"target - File. Required. File to target"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Write to a file in a single operation to avoid invalid files"$'\n'"EXPERIMENTAL not a lot of testing of this don't use quite yet."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/file.sh"
fn="fileTeeAtomic"
fnMarker="fileteeatomic"
foundNames=([0]="argument" [1]="stdin" [2]="stdout" [3]="summary")
line="842"
rawComment="Write to a file in a single operation to avoid invalid files"$'\n'"Argument: -a - Flag. Optional. Append target (atomically as well)."$'\n'"Argument: target - File. Required. File to target"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Piped to a temporary file until EOF and then moved to target"$'\n'"stdout: A copy of stdin"$'\n'"Summary: tee but atomic (EXPERIMENTAL)"$'\n'"EXPERIMENTAL not a lot of testing of this don't use quite yet."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="842"
stdin="Piped to a temporary file until EOF and then moved to target"$'\n'""
stdout="A copy of stdin"$'\n'""
summary="tee but atomic (EXPERIMENTAL)"
summaryComputed=""
usage="fileTeeAtomic [ -a ] target [ --help ]"
