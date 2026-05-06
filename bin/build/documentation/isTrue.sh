#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"value ... - EmptyString. One or more values to test."$'\n'""
base="type.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="True-ish"$'\n'"Succeeds when all arguments are \"true\"-ish"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/type.sh"
fn="isTrue"
fnMarker="istrue"
foundNames=([0]="argument")
line="72"
rawComment="True-ish"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value ... - EmptyString. One or more values to test."$'\n'"Succeeds when all arguments are \"true\"-ish"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="3df0d84917e775e2aba0d9280d56eb8d73b4a8c3"
sourceLine="72"
summary="True-ish"
summaryComputed="true"
usage="isTrue [ --help ] [ value ... ]"
