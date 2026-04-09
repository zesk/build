#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="deployHome - Directory. Required. Deployment database home."$'\n'"versionName - String. Required. Application ID to look for"$'\n'""
base="deploy.sh"
description="Get the previous version of the supplied version"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployPreviousVersion"
foundNames=([0]="argument" [1]="return_code")
line="163"
lowerFn="deploypreviousversion"
rawComment="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Argument: versionName - String. Required. Application ID to look for"$'\n'"Get the previous version of the supplied version"$'\n'"Return Code: 1 - No version exists"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="1 - No version exists"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="5a5eadb87fbfbe1607e28405b9f8a9b51d2cc067"
sourceLine="163"
summary="Get the previous version of the supplied version"
summaryComputed="true"
usage="deployPreviousVersion deployHome versionName"
documentationPath="documentation/source/tools/deploy.md"
