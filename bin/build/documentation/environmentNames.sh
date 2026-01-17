#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'""
base="environment.sh"
description="List names of environment values set in a bash state file"$'\n'""
example="    environmentNames < \"\$stateFile\""$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentNames"
foundNames=([0]="example" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768683999"
summary="List names of environment values set in a bash state"
usage="environmentNames [ --help ]"
