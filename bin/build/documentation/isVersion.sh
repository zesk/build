#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"binary - String. Required. The binary to look for."$'\n'""
base="version.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check if something matches a version"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/version.sh"
fn="isVersion"
fnMarker="isversion"
foundNames=([0]="argument")
line="16"
rawComment="Check if something matches a version"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: binary - String. Required. The binary to look for."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceHash="8d1283d5353b479e2bc32aaf234efc0a9cb6570e"
sourceLine="16"
summary="Check if something matches a version"
summaryComputed="true"
usage="isVersion [ --help ] binary"
