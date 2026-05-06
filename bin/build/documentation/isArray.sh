#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="variableName - String. Required. Variable name to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="type.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is a variable declared as an array?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/type.sh"
fn="isArray"
fnMarker="isarray"
foundNames=([0]="argument")
line="126"
rawComment="Is a variable declared as an array?"$'\n'"Argument: variableName - String. Required. Variable name to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="3df0d84917e775e2aba0d9280d56eb8d73b4a8c3"
sourceLine="126"
summary="Is a variable declared as an array?"
summaryComputed="true"
usage="isArray variableName [ --help ]"
