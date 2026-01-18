#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="-a - Flag. Optional. Append target (atomically as well)."$'\n'"target - File. Required. File to target"$'\n'"--help - Optional. Flag. Display this help."$'\n'""
base="file.sh"
description="Write to a file in a single operation to avoid invalid files"$'\n'""
file="bin/build/tools/file.sh"
fn="fileTeeAtomic"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768721469"
stdin="Piped to a temporary file until EOF and then moved to target"$'\n'""
stdout="A copy of stdin"$'\n'""
summary="Write to a file in a single operation to avoid"
usage="fileTeeAtomic [ -a ] target [ --help ]"
