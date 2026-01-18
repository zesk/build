#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="source - File. Required. File where the function is defined."$'\n'"functionName - String. Required. The name of the bash function to extract the documentation for."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Extract a bash comment from a file. Excludes lines containing the following tokens:"$'\n'""$'\n'""$'\n'""
file="bin/build/tools/bash.sh"
fn="bashFunctionComment"
foundNames=([0]="argument" [1]="requires")
requires="grep cut fileReverseLines __help"$'\n'"usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/bash.sh"
sourceModified="1768721469"
summary="Extract a bash comment from a file. Excludes lines containing"
usage="bashFunctionComment source functionName [ --help ]"
