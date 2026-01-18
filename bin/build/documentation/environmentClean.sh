#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore."$'\n'""
base="environment.sh"
description="Clean *most* exported variables from the current context except a few important ones:"$'\n'"- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2"$'\n'"Calls unset on any variable in the global environment and exported."$'\n'"Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentClean"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768756695"
summary="Clean *most* exported variables from the current context except a"
usage="environmentClean [ keepEnvironment ]"
