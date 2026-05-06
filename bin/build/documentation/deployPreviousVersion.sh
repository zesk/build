#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="deployHome - Directory. Required. Deployment database home."$'\n'"versionName - String. Required. Application ID to look for"$'\n'""
base="deploy.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the previous version of the supplied version"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/deploy.sh"
fn="deployPreviousVersion"
fnMarker="deploypreviousversion"
foundNames=([0]="argument" [1]="return_code")
line="163"
rawComment="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Argument: versionName - String. Required. Application ID to look for"$'\n'"Get the previous version of the supplied version"$'\n'"Return Code: 1 - No version exists"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="1 - No version exists"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="9800c80d1e803796230e87b8fd398df05b0442b9"
sourceLine="163"
summary="Get the previous version of the supplied version"
summaryComputed="true"
usage="deployPreviousVersion deployHome versionName"
