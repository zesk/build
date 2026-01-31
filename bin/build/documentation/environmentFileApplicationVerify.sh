#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="application.sh"
description="Check application environment is populated correctly."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: requiredEnvironment ... - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"Argument: -- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment"$'\n'"Argument: optionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not"$'\n'"Also verifies that \`environmentApplicationVariables\` and \`environmentApplicationLoad\` are defined."$'\n'""
file="bin/build/tools/environment/application.sh"
foundNames=()
rawComment="Check application environment is populated correctly."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: requiredEnvironment ... - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"Argument: -- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment"$'\n'"Argument: optionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not"$'\n'"Also verifies that \`environmentApplicationVariables\` and \`environmentApplicationLoad\` are defined."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/application.sh"
sourceHash="098b7608780123a2e21e2a57911d53cdd9997acc"
summary="Check application environment is populated correctly."
usage="environmentFileApplicationVerify"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentFileApplicationVerify'$'\e''[0m'$'\n'''$'\n''Check application environment is populated correctly.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: requiredEnvironment ... - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the '$'\e''[[(code)]m.env'$'\e''[[(reset)]m file.'$'\n''Argument: -- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment'$'\n''Argument: optionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not'$'\n''Also verifies that '$'\e''[[(code)]menvironmentApplicationVariables'$'\e''[[(reset)]m and '$'\e''[[(code)]menvironmentApplicationLoad'$'\e''[[(reset)]m are defined.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentFileApplicationVerify'$'\n'''$'\n''Check application environment is populated correctly.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: requiredEnvironment ... - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the .env file.'$'\n''Argument: -- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment'$'\n''Argument: optionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not'$'\n''Also verifies that environmentApplicationVariables and environmentApplicationLoad are defined.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.502
