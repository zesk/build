#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="variableName ... - String. Required. Exit status 0 if all variables names are valid ones."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Validates zero or more environment variable names."$'\n'""$'\n'"- alpha"$'\n'"- digit"$'\n'"- underscore"$'\n'""$'\n'"First letter MUST NOT be a digit"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentVariableNameValid"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768756695"
summary="Validates zero or more environment variable names."
usage="environmentVariableNameValid variableName ... [ --help ]"
