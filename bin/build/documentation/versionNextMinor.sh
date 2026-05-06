#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="lastVersion - String. Required. Version to calculate the next minor version."$'\n'""
base="version.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/version.sh"
fn="versionNextMinor"
fnMarker="versionnextminor"
foundNames=([0]="argument")
line="116"
rawComment="Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1"$'\n'"Argument: lastVersion - String. Required. Version to calculate the next minor version."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceHash="8d1283d5353b479e2bc32aaf234efc0a9cb6570e"
sourceLine="116"
summary="Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1"
summaryComputed="true"
usage="versionNextMinor lastVersion"
