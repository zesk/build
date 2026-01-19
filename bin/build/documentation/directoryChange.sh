#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directory - Directory. Required. Directory to change to prior to running command."$'\n'"command - Callable. Required. Thing to do in this directory."$'\n'"... - Arguments. Optional. Arguments to \`command\`."$'\n'""
base="directory.sh"
description="Run a command after changing directory to it and then returning to the previous directory afterwards."$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryChange"
foundNames=([0]="argument" [1]="requires")
requires="pushd popd"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/directory.sh"
sourceModified="1768756695"
summary="Run a command after changing directory to it and then"
usage="directoryChange directory command [ ... ]"
