#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="directory - Directory. Required. Directory to search for the oldest file."$'\n'"--find findArgs ... -- - Arguments. Optional.Arguments delimited by a double-dash (or end of argument list)"$'\n'""
base="file.sh"
description="Find the oldest modified file in a directory"$'\n'""
file="bin/build/tools/file.sh"
fn="directoryOldestFile"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/file.sh"
sourceModified="1768695708"
summary="Find the oldest modified file in a directory"
usage="directoryOldestFile directory [ --find findArgs ... -- ]"
