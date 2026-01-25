#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values."$'\n'""
environment="BUILD_TIMESTAMP"$'\n'"APPLICATION_BUILD_DATE"$'\n'"APPLICATION_VERSION"$'\n'"APPLICATION_ID"$'\n'"APPLICATION_TAG"$'\n'""
exitCode="0"
file="bin/build/tools/environment.sh"
foundNames=([0]="environment" [1]="argument")
rawComment="Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values."$'\n'"Environment: BUILD_TIMESTAMP"$'\n'"Environment: APPLICATION_BUILD_DATE"$'\n'"Environment: APPLICATION_VERSION"$'\n'"Environment: APPLICATION_ID"$'\n'"Environment: APPLICATION_TAG"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769229530"
summary="Loads application environment variables, set them to their default values"
usage="environmentApplicationLoad [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]menvironmentApplicationLoad'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--help  '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_TIMESTAMP'$'\n''- APPLICATION_BUILD_DATE'$'\n''- APPLICATION_VERSION'$'\n''- APPLICATION_ID'$'\n''- APPLICATION_TAG'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentApplicationLoad [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_TIMESTAMP'$'\n''- APPLICATION_BUILD_DATE'$'\n''- APPLICATION_VERSION'$'\n''- APPLICATION_ID'$'\n''- APPLICATION_TAG'$'\n'''
