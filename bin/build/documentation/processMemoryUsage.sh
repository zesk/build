#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="pid - Integer. Required. Process ID of running process"$'\n'""
base="process.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Outputs value of resident memory used by a process, value is in kilobytes"$'\n'""$'\n'""
descriptionLineCount="2"
example="    > processMemoryUsage 23"$'\n'""
file="bin/build/tools/process.sh"
fn="processMemoryUsage"
fnMarker="processmemoryusage"
foundNames=([0]="argument" [1]="example" [2]="output" [3]="return_code")
line="150"
output="423"$'\n'""
rawComment="Outputs value of resident memory used by a process, value is in kilobytes"$'\n'"Argument: pid - Integer. Required. Process ID of running process"$'\n'"Example:     > {fn} 23"$'\n'"Output: 423"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/process.sh"
sourceHash="9a9162fce05d86abc173c620c9416ff86fe4e013"
sourceLine="150"
summary="Outputs value of resident memory used by a process, value"
summaryComputed="true"
usage="processMemoryUsage pid"
