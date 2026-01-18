#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="stateFile - File. Required. File to access, must exist."$'\n'"name - EnvironmentVariable. Required. Name to read."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Read an array value from a state file"$'\n'"Outputs array elements, one per line."$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentValueReadArray"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768756695"
summary="Read an array value from a state file"
usage="environmentValueReadArray stateFile name [ --help ]"
