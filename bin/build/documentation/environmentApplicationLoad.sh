#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values."$'\n'""
environment="BUILD_TIMESTAMP"$'\n'"APPLICATION_BUILD_DATE"$'\n'"APPLICATION_VERSION"$'\n'"APPLICATION_ID"$'\n'"APPLICATION_TAG"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentApplicationLoad"
foundNames=([0]="environment" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768756695"
summary="Loads application environment variables, set them to their default values"
usage="environmentApplicationLoad [ --help ]"
