#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="envName - String. Optional. Name of the environment value to find"$'\n'"--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="build.sh"
description="Determine the environment file names for environment variables"$'\n'""$'\n'""
environment="BUILD_ENVIRONMENT_DIRS"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentFiles"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/build.sh"
sourceModified="1768721469"
summary="Determine the environment file names for environment variables"
usage="buildEnvironmentFiles [ envName ] [ --application applicationHome ] [ --help ] [ --handler handler ]"
