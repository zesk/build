#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore."$'\n'""
base="environment.sh"
description="Clean *most* exported variables from the current context except a few important ones:"$'\n'"- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4"$'\n'"Calls unset on any variable in the global environment and exported."$'\n'"Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line"$'\n'""
file="bin/build/tools/environment.sh"
rawComment="Clean *most* exported variables from the current context except a few important ones:"$'\n'"- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4"$'\n'"Calls unset on any variable in the global environment and exported."$'\n'"Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line"$'\n'"Argument: keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="4226efba8a29858c837cfce31f7416e4226eaa32"
summary="Clean *most* exported variables from the current context except a"
usage="environmentClean [ keepEnvironment ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentClean'$'\e''[0m '$'\e''[[(blue)]m[ keepEnvironment ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mkeepEnvironment  '$'\e''[[(value)]mEnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.'$'\e''[[(reset)]m'$'\n'''$'\n''Clean '$'\e''[[(cyan)]mmost'$'\e''[[(reset)]m exported variables from the current context except a few important ones:'$'\n''- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4'$'\n''Calls unset on any variable in the global environment and exported.'$'\n''Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: environmentClean [ keepEnvironment ]'$'\n'''$'\n''    keepEnvironment  EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.'$'\n'''$'\n''Clean most exported variables from the current context except a few important ones:'$'\n''- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4'$'\n''Calls unset on any variable in the global environment and exported.'$'\n''Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
# elapsed 2.415
