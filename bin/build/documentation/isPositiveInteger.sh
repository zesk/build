#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="type.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/type.sh"
fn="isPositiveInteger"
fnMarker="ispositiveinteger"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="153"
rawComment="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'"Argument: value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - if it is a positive integer"$'\n'"Return Code: 1 - if it is not a positive integer"$'\n'"Requires: catchArgument isUnsignedInteger bashDocumentation helpArgument"$'\n'""$'\n'""
requires="catchArgument isUnsignedInteger bashDocumentation helpArgument"$'\n'""
return_code="0 - if it is a positive integer"$'\n'"1 - if it is not a positive integer"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="3df0d84917e775e2aba0d9280d56eb8d73b4a8c3"
sourceLine="153"
summary="Test if an argument is a positive integer (non-zero)"
summaryComputed="true"
usage="isPositiveInteger value [ --help ]"
