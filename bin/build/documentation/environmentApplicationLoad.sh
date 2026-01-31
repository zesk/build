#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="application.sh"
description="Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values."$'\n'"Environment: BUILD_TIMESTAMP"$'\n'"Environment: APPLICATION_BUILD_DATE"$'\n'"Environment: APPLICATION_VERSION"$'\n'"Environment: APPLICATION_ID"$'\n'"Environment: APPLICATION_TAG"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/environment/application.sh"
foundNames=()
rawComment="Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values."$'\n'"Environment: BUILD_TIMESTAMP"$'\n'"Environment: APPLICATION_BUILD_DATE"$'\n'"Environment: APPLICATION_VERSION"$'\n'"Environment: APPLICATION_ID"$'\n'"Environment: APPLICATION_TAG"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/application.sh"
sourceHash="098b7608780123a2e21e2a57911d53cdd9997acc"
summary="Loads application environment variables, set them to their default values"
usage="environmentApplicationLoad"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentApplicationLoad'$'\e''[0m'$'\n'''$'\n''Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.'$'\n''Environment: BUILD_TIMESTAMP'$'\n''Environment: APPLICATION_BUILD_DATE'$'\n''Environment: APPLICATION_VERSION'$'\n''Environment: APPLICATION_ID'$'\n''Environment: APPLICATION_TAG'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentApplicationLoad'$'\n'''$'\n''Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.'$'\n''Environment: BUILD_TIMESTAMP'$'\n''Environment: APPLICATION_BUILD_DATE'$'\n''Environment: APPLICATION_VERSION'$'\n''Environment: APPLICATION_ID'$'\n''Environment: APPLICATION_TAG'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.461
