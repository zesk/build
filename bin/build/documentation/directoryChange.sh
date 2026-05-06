#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="directory - Directory. Required. Directory to change to prior to running command."$'\n'"command - Callable. Required. Thing to do in this directory."$'\n'"... - Arguments. Optional. Arguments to \`command\`."$'\n'""
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run a command after changing directory to it and then returning to the previous directory afterwards."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/directory.sh"
fn="directoryChange"
fnMarker="directorychange"
foundNames=([0]="argument" [1]="requires")
line="32"
rawComment="Argument: directory - Directory. Required. Directory to change to prior to running command."$'\n'"Argument: command - Callable. Required. Thing to do in this directory."$'\n'"Argument: ... - Arguments. Optional. Arguments to \`command\`."$'\n'"Run a command after changing directory to it and then returning to the previous directory afterwards."$'\n'"Requires: pushd popd"$'\n'""$'\n'""
requires="pushd popd"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="da838a55948477df4605f58aff4c29b4f13319f7"
sourceLine="32"
summary="Run a command after changing directory to it and then"
summaryComputed="true"
usage="directoryChange directory command [ ... ]"
