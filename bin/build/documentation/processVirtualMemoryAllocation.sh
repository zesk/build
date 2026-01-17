#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/process.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"pid - Process ID of running process"$'\n'""
base="process.sh"
description="Outputs value of virtual memory allocated for a process, value is in kilobytes"$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Argument error"$'\n'""
example="    processVirtualMemoryAllocation 23"$'\n'""
file="bin/build/tools/process.sh"
fn="processVirtualMemoryAllocation"
foundNames=([0]="argument" [1]="example" [2]="output")
output="423"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/process.sh"
sourceModified="1768683750"
summary="Outputs value of virtual memory allocated for a process, value"
usage="processVirtualMemoryAllocation [ --help ] [ pid ]"
