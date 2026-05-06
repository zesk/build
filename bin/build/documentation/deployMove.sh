#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="applicationPath - Directory. Required. Application target path."$'\n'""
base="deploy.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Safe application deployment by moving"$'\n'""$'\n'"Deploy current application to target path"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/deploy.sh"
fn="deployMove"
fnMarker="deploymove"
foundNames=([0]="argument")
line="192"
rawComment="Safe application deployment by moving"$'\n'"Argument: applicationPath - Directory. Required. Application target path."$'\n'"Deploy current application to target path"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="9800c80d1e803796230e87b8fd398df05b0442b9"
sourceLine="192"
summary="Safe application deployment by moving"
summaryComputed="true"
usage="deployMove applicationPath"
