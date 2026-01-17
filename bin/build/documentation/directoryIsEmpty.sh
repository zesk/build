#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directory - Directory. Optional. Directory to check if empty."$'\n'""
base="directory.sh"
description="Does a directory exist and is it empty?"$'\n'"Return Code: 2 - Directory does not exist"$'\n'"Return Code: 1 - Directory is not empty"$'\n'"Return Code: 0 - Directory is empty"$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryIsEmpty"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/directory.sh"
sourceModified="1768683853"
summary="Does a directory exist and is it empty?"
usage="directoryIsEmpty [ directory ]"
