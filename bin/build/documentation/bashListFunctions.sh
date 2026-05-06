#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"file - File. Optional. File(s) to list bash functions defined within."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List functions in a given shell file"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/bash.sh"
fn="bashListFunctions"
fnMarker="bashlistfunctions"
foundNames=([0]="argument" [1]="requires")
line="360"
rawComment="List functions in a given shell file"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: file - File. Optional. File(s) to list bash functions defined within."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: __bashListFunctions throwArgument decorate usageArgumentFile"$'\n'""$'\n'""
requires="__bashListFunctions throwArgument decorate usageArgumentFile"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="360"
summary="List functions in a given shell file"
summaryComputed="true"
usage="bashListFunctions [ --help ] [ file ] [ --help ]"
