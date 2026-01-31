#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="build.sh"
description="Determine the environment file names for environment variables"$'\n'"Argument: envName - String. Optional. Name of the environment value to find"$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Environment: BUILD_ENVIRONMENT_DIRS"$'\n'""
file="bin/build/tools/build.sh"
foundNames=()
rawComment="Determine the environment file names for environment variables"$'\n'"Argument: envName - String. Optional. Name of the environment value to find"$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Environment: BUILD_ENVIRONMENT_DIRS"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="267ae3edaa9016ac7b2e56308eee0e1fd805c66e"
summary="Determine the environment file names for environment variables"
usage="buildEnvironmentFiles"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildEnvironmentFiles'$'\e''[0m'$'\n'''$'\n''Determine the environment file names for environment variables'$'\n''Argument: envName - String. Optional. Name of the environment value to find'$'\n''Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Environment: BUILD_ENVIRONMENT_DIRS'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentFiles'$'\n'''$'\n''Determine the environment file names for environment variables'$'\n''Argument: envName - String. Optional. Name of the environment value to find'$'\n''Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.'$'\n''Environment: BUILD_ENVIRONMENT_DIRS'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.443
