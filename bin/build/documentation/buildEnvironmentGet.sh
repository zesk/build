#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="build.sh"
description="Load and print one or more environment settings"$'\n'"Argument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and \`export\`ed."$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"If BOTH files exist, both are sourced, so application environments should anticipate values"$'\n'"created by build's default."$'\n'"Modifies local environment. Not usually run within a subshell."$'\n'"Environment: \$envName"$'\n'"Environment: BUILD_ENVIRONMENT_DIRS - \`:\` separated list of paths to load env files"$'\n'""
file="bin/build/tools/build.sh"
foundNames=()
rawComment="Load and print one or more environment settings"$'\n'"Argument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and \`export\`ed."$'\n'"Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state."$'\n'"If BOTH files exist, both are sourced, so application environments should anticipate values"$'\n'"created by build's default."$'\n'"Modifies local environment. Not usually run within a subshell."$'\n'"Environment: \$envName"$'\n'"Environment: BUILD_ENVIRONMENT_DIRS - \`:\` separated list of paths to load env files"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="267ae3edaa9016ac7b2e56308eee0e1fd805c66e"
summary="Load and print one or more environment settings"
usage="buildEnvironmentGet"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildEnvironmentGet'$'\e''[0m'$'\n'''$'\n''Load and print one or more environment settings'$'\n''Argument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and '$'\e''[[(code)]mexport'$'\e''[[(reset)]med.'$'\n''Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.'$'\n''If BOTH files exist, both are sourced, so application environments should anticipate values'$'\n''created by build'\''s default.'$'\n''Modifies local environment. Not usually run within a subshell.'$'\n''Environment: $envName'$'\n''Environment: BUILD_ENVIRONMENT_DIRS - '$'\e''[[(code)]m:'$'\e''[[(reset)]m separated list of paths to load env files'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentGet'$'\n'''$'\n''Load and print one or more environment settings'$'\n''Argument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and exported.'$'\n''Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.'$'\n''If BOTH files exist, both are sourced, so application environments should anticipate values'$'\n''created by build'\''s default.'$'\n''Modifies local environment. Not usually run within a subshell.'$'\n''Environment: $envName'$'\n''Environment: BUILD_ENVIRONMENT_DIRS - : separated list of paths to load env files'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.478
