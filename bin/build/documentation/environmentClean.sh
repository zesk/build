#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore."$'\n'""
base="environment.sh"
description="Clean *most* exported variables from the current context except a few important ones:"$'\n'"- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2"$'\n'"Calls unset on any variable in the global environment and exported."$'\n'"Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentClean"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769061401"
summary="Clean *most* exported variables from the current context except a"
usage="environmentClean [ keepEnvironment ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentClean[0m [94m[ keepEnvironment ][0m

    [94mkeepEnvironment  [1;97mEnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.[0m

Clean [36mmost[0m exported variables from the current context except a few important ones:
- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2
Calls unset on any variable in the global environment and exported.
Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentClean [ keepEnvironment ]

    keepEnvironment  EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.

Clean most exported variables from the current context except a few important ones:
- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2
Calls unset on any variable in the global environment and exported.
Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
