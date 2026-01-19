#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="directory - Directory. Required. Must exists - directory to list."$'\n'"findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'""
base="file.sh"
description="Lists files in a directory recursively along with their modification time in seconds."$'\n'""$'\n'"Output is unsorted."$'\n'""$'\n'""$'\n'""
example="fileModificationTimes \$myDir ! -path \"*/.*/*\""$'\n'""
file="bin/build/tools/file.sh"
fn="fileModificationTimes"
foundNames=([0]="argument" [1]="example" [2]="output")
output="1705347087 bin/build/tools.sh"$'\n'"1704312758 bin/build/deprecated.sh"$'\n'"1705442647 bin/build/build.json"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768775696"
summary="Lists files in a directory recursively along with their modification"
usage="fileModificationTimes directory [ findArgs ]"
