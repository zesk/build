#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="directory - Directory. Required. Must exists - directory to list."$'\n'"findArgs - Arguments. Optional. Optional additional arguments to modify the find query"$'\n'""
base="file.sh"
description="List the most recently modified file in a directory prefixed with the timestamp"$'\n'""
file="bin/build/tools/file.sh"
fn="fileModifiedRecently"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768775696"
summary="List the most recently modified file in a directory prefixed"
usage="fileModifiedRecently directory [ findArgs ]"
