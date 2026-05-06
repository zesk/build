#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="envName - String. Optional. Name of the environment value to find"$'\n'"--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Determine the environment file names for environment variables"$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_ENVIRONMENT_DIRS"$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentFiles"
fnMarker="buildenvironmentfiles"
foundNames=([0]="argument" [1]="environment")
line="224"
rawComment="Determine the environment file names for environment variables"$'\n'"Argument: envName - String. Optional. Name of the environment value to find"$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Environment: BUILD_ENVIRONMENT_DIRS"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="8814c5b6b68b94aa734c4c337d9463150c6d754d"
sourceLine="224"
summary="Determine the environment file names for environment variables"
summaryComputed="true"
usage="buildEnvironmentFiles [ envName ] [ --application applicationHome ] [ --help ] [ --handler handler ]"
