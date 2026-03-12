#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--error - Flag. Add ERR trap."$'\n'"--clear - Flag. Remove all traps."$'\n'"--interrupt - Flag. Add INT trap."$'\n'"--already-error - Flag. If the signals are already installed, then throw an error. Otherwise exits 0."$'\n'""
base="debug.sh"
description="Adds a trap to capture the debugging stack on interrupt"$'\n'"Use this in a bash script which runs forever or runs in an infinite loop to"$'\n'"determine where the problem or loop exists."$'\n'""
file="bin/build/tools/debug.sh"
fn="bashDebugInterruptFile"
foundNames=([0]="requires" [1]="argument")
rawComment="Adds a trap to capture the debugging stack on interrupt"$'\n'"Use this in a bash script which runs forever or runs in an infinite loop to"$'\n'"determine where the problem or loop exists."$'\n'"Requires: trap"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --error - Flag. Add ERR trap."$'\n'"Argument: --clear - Flag. Remove all traps."$'\n'"Argument: --interrupt - Flag. Add INT trap."$'\n'"Argument: --already-error - Flag. If the signals are already installed, then throw an error. Otherwise exits 0."$'\n'""$'\n'""
requires="trap"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="456ef1cd03391bca402951a815d37ccf1ed2ab88"
summary="Adds a trap to capture the debugging stack on interrupt"
summaryComputed="true"
usage="bashDebugInterruptFile [ --help ] [ --handler handler ] [ --error ] [ --clear ] [ --interrupt ] [ --already-error ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
