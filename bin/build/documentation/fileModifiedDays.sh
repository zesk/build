#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="file ... - File. Required. One or more files to examine"$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="file.sh"
description="Prints days (integer) since modified"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 2 - Can not get modification time"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModifiedDays"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768687315"
summary="Prints days (integer) since modified"
usage="fileModifiedDays file ... [ --help ]"
