#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'envName - String. Optional. Name of the environment value to find\n--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.\n--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Determine the environment file names for environment variables\n\n'
descriptionLineCount="2"
environment=$'BUILD_ENVIRONMENT_DIRS\n'
file="bin/build/tools/build.sh"
fn="buildEnvironmentFiles"
fnMarker="buildenvironmentfiles"
foundNames=([0]="argument" [1]="environment")
line="224"
rawComment=$'Determine the environment file names for environment variables\nArgument: envName - String. Optional. Name of the environment value to find\nArgument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nEnvironment: BUILD_ENVIRONMENT_DIRS\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="224"
summary="Determine the environment file names for environment variables"
summaryComputed="true"
usage="buildEnvironmentFiles [ envName ] [ --application applicationHome ] [ --help ] [ --handler handler ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildEnvironmentFiles'$'\e''[0m '$'\e''[[(blue)]m[ envName ]'$'\e''[0m '$'\e''[[(blue)]m[ --application applicationHome ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]menvName                        '$'\e''[[(value)]mString. Optional. Name of the environment value to find'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--application applicationHome  '$'\e''[[(value)]mPath. Optional. Directory of alternate application home. Can be specified more than once to change state.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                         '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler              '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n'''$'\n''Determine the environment file names for environment variables'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_ENVIRONMENT_DIRS'
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentFiles [ envName ] [ --application applicationHome ] [ --help ] [ --handler handler ]'$'\n'''$'\n''    envName                        String. Optional. Name of the environment value to find'$'\n''    --application applicationHome  Path. Optional. Directory of alternate application home. Can be specified more than once to change state.'$'\n''    --help                         Flag. Optional. Display this help.'$'\n''    --handler handler              Function. Optional. Use this error handler instead of the default error handler.'$'\n'''$'\n''Determine the environment file names for environment variables'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_ENVIRONMENT_DIRS'
documentationPath="documentation/source/tools/build.md"
