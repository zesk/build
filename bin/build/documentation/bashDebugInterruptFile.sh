#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--error - Flag. Add ERR trap."$'\n'"--interrupt - Flag. Add INT trap."$'\n'""
base="debug.sh"
description="Adds a trap to capture the debugging stack on interrupt"$'\n'"Use this in a bash script which runs forever or runs in an infinite loop to"$'\n'"determine where the problem or loop exists."$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="requires" [1]="argument")
rawComment="Adds a trap to capture the debugging stack on interrupt"$'\n'"Use this in a bash script which runs forever or runs in an infinite loop to"$'\n'"determine where the problem or loop exists."$'\n'"Requires: trap"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --error - Flag. Add ERR trap."$'\n'"Argument: --interrupt - Flag. Add INT trap."$'\n'""$'\n'""
requires="trap"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="f288b9b3b91991d05bd6676a6b9ef73b9e0296b8"
summary="Adds a trap to capture the debugging stack on interrupt"
usage="bashDebugInterruptFile [ --help ] [ --error ] [ --interrupt ]"
