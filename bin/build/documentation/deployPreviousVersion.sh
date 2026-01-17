#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="deployHome -  Directory. Required. Deployment database home."$'\n'"versionName - String. Required. Application ID to look for"$'\n'""
base="deploy.sh"
description="Get the previous version of the supplied version"$'\n'"Return Code: 1 - No version exists"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployPreviousVersion"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deploy.sh"
sourceModified="1768683999"
summary="Get the previous version of the supplied version"
usage="deployPreviousVersion deployHome versionName"
