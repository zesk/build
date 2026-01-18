#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"--error - Flag. Add ERR trap."$'\n'"--interrupt - Flag. Add INT trap."$'\n'""
base="debug.sh"
description="Adds a trap to capture the debugging stack on interrupt"$'\n'"Use this in a bash script which runs forever or runs in an infinite loop to"$'\n'"determine where the problem or loop exists."$'\n'""
file="bin/build/tools/debug.sh"
fn="bashDebugInterruptFile"
foundNames=([0]="requires" [1]="argument")
requires="trap"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/debug.sh"
sourceModified="1768695708"
summary="Adds a trap to capture the debugging stack on interrupt"
usage="bashDebugInterruptFile [ --help ] [ --error ] [ --interrupt ]"
