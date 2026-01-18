#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/convert.sh"
argument="filename - File. Optional. Docker environment file to check for common issues"$'\n'""
base="convert.sh"
BASH_LINENO=([0]="129" [1]="963" [2]="226" [3]="237" [4]="82" [5]="65" [6]="75" [7]="22" [8]="54" [9]="129" [10]="115" [11]="65" [12]="75" [13]="16" [14]="37" [15]="206" [16]="51" [17]="129" [18]="37" [19]="226" [20]="237" [21]="358" [22]="173" [23]="123" [24]="150" [25]="154" [26]="0")
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileBashCompatibleToDocker"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment/convert.sh"
sourceModified="1768759914"
stdin="text - Environment file to convert. (Optional)"$'\n'""
stdout="text - Only if stdin is supplied and no \`filename\` arguments."$'\n'""
summary="Ensure an environment file is compatible with non-quoted docker environment"
usage="environmentFileBashCompatibleToDocker [ filename ]"
