#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="envName - String. Optional. Name of the environment value to find"$'\n'"--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="build.sh"
description="Determine the environment file names for environment variables"$'\n'""
environment="BUILD_ENVIRONMENT_DIRS"$'\n'""
file="bin/build/tools/build.sh"
foundNames=([0]="argument" [1]="environment")
rawComment="Determine the environment file names for environment variables"$'\n'"Argument: envName - String. Optional. Name of the environment value to find"$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Environment: BUILD_ENVIRONMENT_DIRS"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1769364138"
summary="Determine the environment file names for environment variables"
usage="buildEnvironmentFiles [ envName ] [ --application applicationHome ] [ --help ] [ --handler handler ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildEnvironmentFiles'$'\e''[0m '$'\e''[[(blue)]m[ envName ]'$'\e''[0m '$'\e''[[(blue)]m[ --application applicationHome ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]menvName                        '$'\e''[[(value)]mString. Optional. Name of the environment value to find'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--application applicationHome  '$'\e''[[(value)]mPath. Optional. Directory of alternate application home. Can be specified more than once to change state.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler              '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n'''$'\n''Determine the environment file names for environment variables'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_ENVIRONMENT_DIRS'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentFiles [ envName ] [ --application applicationHome ] [ --help ] [ --handler handler ]'$'\n'''$'\n''    envName                        String. Optional. Name of the environment value to find'$'\n''    --application applicationHome  Path. Optional. Directory of alternate application home. Can be specified more than once to change state.'$'\n''    --help                         Flag. Optional. Display this help.'$'\n''    --handler handler              Function. Optional. Use this error handler instead of the default error handler.'$'\n'''$'\n''Determine the environment file names for environment variables'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_ENVIRONMENT_DIRS'$'\n'''
# elapsed 0.644
