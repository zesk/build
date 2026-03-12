#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"file - File. Optional. File(s) to list bash functions defined within."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="List functions in a given shell file"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashListFunctions"
foundNames=([0]="argument" [1]="requires")
rawComment="List functions in a given shell file"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: file - File. Optional. File(s) to list bash functions defined within."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: __bashListFunctions throwArgument decorate usageArgumentFile"$'\n'""$'\n'""
requires="__bashListFunctions throwArgument decorate usageArgumentFile"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
summary="List functions in a given shell file"
summaryComputed="true"
usage="bashListFunctions [ --help ] [ file ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
