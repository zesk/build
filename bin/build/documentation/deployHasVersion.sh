#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="deployHome - Directory. Required. Deployment database home."$'\n'"versionName - String. Required. Application ID to look for"$'\n'""
base="deploy.sh"
description="Does a deploy version exist? versionName is the version identifier for deployments"$'\n'""$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployHasVersion"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deploy.sh"
sourceModified="1768721469"
summary="Does a deploy version exist? versionName is the version identifier"
usage="deployHasVersion deployHome versionName"
