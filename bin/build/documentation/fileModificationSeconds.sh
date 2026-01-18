#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="filename ... - File to fetch modification time"$'\n'""
base="file.sh"
description="Fetch the modification time in seconds from now of a file as a timestamp"$'\n'""$'\n'"Return Code: 2 - If file does not exist"$'\n'"Return Code: 0 - If file exists and modification times are output, one per line"$'\n'""$'\n'""
example="    fileModificationTime ~/.bash_profile"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModificationSeconds"
foundNames=([0]="argument" [1]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768695708"
summary="Fetch the modification time in seconds from now of a"
usage="fileModificationSeconds [ filename ... ]"
