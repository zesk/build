#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"file - File. Optional. File(s) to list bash functions defined within."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="List functions in a given shell file"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashListFunctions"
foundNames=([0]="argument" [1]="requires")
requires="__bashListFunctions throwArgument decorate usageArgumentFile"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/bash.sh"
sourceModified="1768776883"
summary="List functions in a given shell file"
usage="bashListFunctions [ --help ] [ file ] [ --help ]"
