#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="variableName ... - String. Required. Exit status 0 if all variables names are valid ones."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Validates zero or more environment variable names."$'\n'""$'\n'"- alpha"$'\n'"- digit"$'\n'"- underscore"$'\n'""$'\n'"First letter MUST NOT be a digit"$'\n'""$'\n'""
descriptionLineCount="8"
file="bin/build/tools/environment.sh"
fn="environmentVariableNameValid"
fnMarker="environmentvariablenamevalid"
foundNames=([0]="argument")
line="16"
rawComment="Argument: variableName ... - String. Required. Exit status 0 if all variables names are valid ones."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Validates zero or more environment variable names."$'\n'"- alpha"$'\n'"- digit"$'\n'"- underscore"$'\n'"First letter MUST NOT be a digit"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="fd4da5f1d9a2c52100a1a281185a474bae9aba02"
sourceLine="16"
summary="Validates zero or more environment variable names."
summaryComputed="true"
usage="environmentVariableNameValid variableName ... [ --help ]"
