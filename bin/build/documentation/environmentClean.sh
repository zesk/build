#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore."$'\n'""
base="environment.sh"
BASH_LINENO=([0]="129" [1]="963" [2]="226" [3]="237" [4]="82" [5]="65" [6]="75" [7]="22" [8]="54" [9]="129" [10]="115" [11]="65" [12]="75" [13]="16" [14]="37" [15]="1001" [16]="51" [17]="129" [18]="37" [19]="226" [20]="237" [21]="358" [22]="173" [23]="123" [24]="150" [25]="154" [26]="0")
description="Clean *most* exported variables from the current context except a few important ones:"$'\n'"- BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2"$'\n'"Calls unset on any variable in the global environment and exported."$'\n'"Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentClean"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768759812"
summary="Clean *most* exported variables from the current context except a"
usage="environmentClean [ keepEnvironment ]"
