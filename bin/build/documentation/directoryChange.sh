#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directory - Directory. Required. Directory to change to prior to running command."$'\n'"command - Callable. Required. Thing to do in this directory."$'\n'"... - Arguments. Optional. Arguments to \`command\`."$'\n'""
base="directory.sh"
BASH_LINENO=([0]="129" [1]="963" [2]="226" [3]="237" [4]="82" [5]="65" [6]="75" [7]="22" [8]="54" [9]="129" [10]="115" [11]="65" [12]="75" [13]="16" [14]="37" [15]="67" [16]="51" [17]="129" [18]="37" [19]="357" [20]="142" [21]="115" [22]="150" [23]="154" [24]="0")
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
