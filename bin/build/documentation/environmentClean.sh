#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.\n'
base="environment.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Clean *most* exported variables from the current context except a few important ones:\n- CI PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4 BUILD_HOME\n- __BUILD_DECORATE BUILD_COLORS BUILD_DEBUG BUILD_HOOK_DIRS __BUILD_LOADER\nCalls unset on any variable in the global environment and exported.\nUse with caution. Any additional environment variables you wish to preserve, simply pass those on the command line\n\n'
descriptionLineCount="6"
file="bin/build/tools/environment.sh"
fn="environmentClean"
fnMarker="environmentclean"
foundNames=([0]="argument")
line="172"
original="environmentClean"
rawComment=$'Clean *most* exported variables from the current context except a few important ones:\n- CI PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4 BUILD_HOME\n- __BUILD_DECORATE BUILD_COLORS BUILD_DEBUG BUILD_HOOK_DIRS __BUILD_LOADER\nCalls unset on any variable in the global environment and exported.\nUse with caution. Any additional environment variables you wish to preserve, simply pass those on the command line\nArgument: keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/environment.sh"
sourceHash="18e820488a866ed32d204bb355260d6eeb9c6cf1"
sourceLine="172"
summary="Clean *most* exported variables from the current context except a"
summaryComputed="true"
usage="environmentClean [ keepEnvironment ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentClean'$'\e''[0m '$'\e''[[(blue)]m[ keepEnvironment ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mkeepEnvironment  '$'\e''[[(value)]mEnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.'$'\e''[[(reset)]m'$'\n'''$'\n''Clean '$'\e''[[(cyan)]mmost'$'\e''[[(reset)]m exported variables from the current context except a few important ones:'$'\n''- CI PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4 BUILD_HOME'$'\n''- __BUILD_DECORATE BUILD_COLORS BUILD_DEBUG BUILD_HOOK_DIRS __BUILD_LOADER'$'\n''Calls unset on any variable in the global environment and exported.'$'\n''Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: environmentClean [ keepEnvironment ]'$'\n'''$'\n''    keepEnvironment  EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.'$'\n'''$'\n''Clean most exported variables from the current context except a few important ones:'$'\n''- CI PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4 BUILD_HOME'$'\n''- __BUILD_DECORATE BUILD_COLORS BUILD_DEBUG BUILD_HOOK_DIRS __BUILD_LOADER'$'\n''Calls unset on any variable in the global environment and exported.'$'\n''Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/environment.md"
