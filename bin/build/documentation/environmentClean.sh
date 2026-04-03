#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore."$'\n'""
base="environment.sh"
description="Clean *most* exported variables from the current context except a few important ones:"$'\n'"- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4"$'\n'"Calls unset on any variable in the global environment and exported."$'\n'"Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentClean"
foundNames=([0]="argument")
rawComment="Clean *most* exported variables from the current context except a few important ones:"$'\n'"- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4"$'\n'"Calls unset on any variable in the global environment and exported."$'\n'"Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line"$'\n'"Argument: keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="5c883706d148f55f1c9ad4eb2c95662b00943bc9"
summary="Clean *most* exported variables from the current context except a"
summaryComputed="true"
usage="environmentClean [ keepEnvironment ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]menvironmentClean'$'\e''[0m '$'\e''[[(blue)]m[ keepEnvironment ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mkeepEnvironment  '$'\e''[[(value)]mEnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.'$'\e''[[(reset)]m'$'\n'''$'\n''Clean '$'\e''[[(cyan)]mmost'$'\e''[[(reset)]m exported variables from the current context except a few important ones:'$'\n''- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4'$'\n''Calls unset on any variable in the global environment and exported.'$'\n''Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: environmentClean [ keepEnvironment ]'$'\n'''$'\n''    keepEnvironment  EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.'$'\n'''$'\n''Clean most exported variables from the current context except a few important ones:'$'\n''- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4'$'\n''Calls unset on any variable in the global environment and exported.'$'\n''Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
