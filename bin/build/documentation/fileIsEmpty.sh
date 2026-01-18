#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="file - File. Optional. One or more files, all of which must be empty."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="file.sh"
description="Is this an empty (zero-sized) file?"$'\n'"Return Code: 0 - if all files passed in are empty files"$'\n'"Return Code: 1 - if any files passed in are non-empty files"$'\n'""
file="bin/build/tools/file.sh"
fn="fileIsEmpty"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768695708"
summary="Is this an empty (zero-sized) file?"
usage="fileIsEmpty [ file ] [ --help ]"
